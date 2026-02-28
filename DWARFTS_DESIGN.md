# dwarf.ts: DWARF Debug Section Parser

## Overview

`dwarf.ts` is an AssemblyScript module that parses the `.debug_line` section of a WASM binary and produces a mapping from **Code-section-relative byte offsets** to **source file locations** (file, line, column). This mapping is the core input that watnot needs to inject source comments into WAT output.

The module intentionally parses only `.debug_line`. Other DWARF sections (`.debug_info`, `.debug_loc`, etc.) are out of scope.

---

## Background: The `.debug_line` Section

The `.debug_line` section encodes a mapping from instruction addresses to source locations using a compact **line number program** — a bytecode interpreted by a state machine. The state machine maintains a set of registers and emits rows into a **line number matrix** each time it reaches a "copy" point.

### State Machine Registers

| Register | Type | Initial Value | Description |
|---|---|---|---|
| `address` | `u32` | `0` | Code-section-relative byte offset of the current instruction |
| `file` | `u32` | `1` | Index into the file table (1-based) |
| `line` | `u32` | `1` | Current source line number (1-based) |
| `column` | `u32` | `0` | Current source column (0 = unknown) |
| `is_stmt` | `bool` | per header | Whether this is a recommended breakpoint location |
| `end_sequence` | `bool` | `false` | Whether this row marks the end of a sequence |

### Line Number Matrix

Each time the state machine emits a row, it appends the current register values as one entry in the line number matrix. This matrix is the final output — a table of `(address, file, line, column)` tuples sorted by address.

For watnot, `address` is the Code-section-relative byte offset of a WASM instruction, and `file`/`line` identify the corresponding source location.

---

## Module Interface

```typescript
// dwarf.ts

/**
 * A single entry in the line number matrix.
 * address is a Code-section-relative byte offset.
 */
export class LineEntry {
  address: u32;
  fileIndex: u32;  // 1-based index into fileNames array
  line: u32;
  column: u32;
  isStmt: bool;
  endSequence: bool;
}

/**
 * The parsed result of a .debug_line section.
 */
export class DebugLineInfo {
  /** Ordered list of source file names, 1-indexed (index 0 is unused). */
  fileNames: Array<string>;

  /** The line number matrix, sorted by address ascending. */
  entries: Array<LineEntry>;

  /**
   * Given a Code-section-relative byte offset, return the LineEntry
   * whose address is the largest address <= the given offset.
   * Returns null if no entry is found.
   */
  lookup(offset: u32): LineEntry | null;
}

/**
 * Parse the .debug_line custom section from a WASM binary.
 *
 * @param wasmBytes  The full WASM binary as a byte array
 * @returns          Parsed DebugLineInfo, or null if no .debug_line section found
 */
export function parseDebugLine(wasmBytes: Uint8Array): DebugLineInfo | null;
```

---

## Implementation

### Step 1: Locate the `.debug_line` Custom Section

WASM binaries begin with an 8-byte header (`\0asm` magic + version), followed by a sequence of sections. Each section has the format:

```
section_id  : u8
section_size: uleb128
section_body: byte[section_size]
```

Custom sections have `section_id = 0`. Their body begins with a length-prefixed UTF-8 name string, followed by the section content.

To find `.debug_line`:

1. Skip the 8-byte WASM header
2. Iterate through sections
3. For each section with `id = 0`, read the name string
4. If the name is `.debug_line`, return a slice of the body bytes starting after the name

```typescript
function findCustomSection(wasmBytes: Uint8Array, name: string): Uint8Array | null;
```

### Step 2: Parse the `.debug_line` Section Header

Each compilation unit in `.debug_line` begins with a header:

```
unit_length         : u32         (total length of this compilation unit, not including this field)
version             : u16         (expected: 4 or 5)
header_length       : u32         (length of the remainder of the header)
minimum_instruction_length : u8
maximum_ops_per_instruction: u8   (DWARF 4+, always 1 for WASM)
default_is_stmt     : u8
line_base           : i8
line_range          : u8
opcode_base         : u8          (first special opcode; standard opcodes are 1..opcode_base-1)
standard_opcode_lengths: u8[opcode_base - 1]
include_directories : null-terminated list of null-terminated strings
file_names          : list of file name entries, terminated by a null byte
```

Each file name entry:
```
file_name           : null-terminated string
directory_index     : uleb128     (0 = current dir, else index into include_directories)
modification_time   : uleb128     (unused, always 0 in practice)
file_length         : uleb128     (unused, always 0 in practice)
```

```typescript
class DebugLineHeader {
  version: u16;
  minimumInstructionLength: u8;
  defaultIsStmt: bool;
  lineBase: i8;
  lineRange: u8;
  opcodeBase: u8;
  standardOpcodeLengths: Uint8Array;
  includeDirectories: Array<string>;
  fileNames: Array<string>;  // index 0 unused; file 1 = fileNames[1]
  headerEndOffset: u32;      // byte offset where the line number program begins
}

function parseHeader(bytes: Uint8Array, offset: u32): DebugLineHeader;
```

### Step 3: Execute the Line Number Program

After the header, the remaining bytes are the **line number program** — a sequence of opcodes interpreted by the state machine.

There are three categories of opcode:

#### Special Opcodes

Any opcode >= `opcode_base` is a special opcode. It encodes both an address advance and a line advance in a single byte:

```
adjusted_opcode = opcode - opcode_base
address_advance = adjusted_opcode / line_range
line_advance    = line_base + (adjusted_opcode % line_range)
```

After applying these advances, the state machine emits a row and resets `basic_block`, `prologue_end`, `epilogue_begin` to false.

#### Standard Opcodes

| Opcode | Name | Effect |
|---|---|---|
| `1` | `DW_LNS_copy` | Emit a row, reset flags |
| `2` | `DW_LNS_advance_pc` | `address += operand * minimum_instruction_length` |
| `3` | `DW_LNS_advance_line` | `line += sleb128 operand` |
| `4` | `DW_LNS_set_file` | `file = uleb128 operand` |
| `5` | `DW_LNS_set_column` | `column = uleb128 operand` |
| `6` | `DW_LNS_negate_stmt` | `is_stmt = !is_stmt` |
| `7` | `DW_LNS_set_basic_block` | (ignored for our purposes) |
| `8` | `DW_LNS_const_add_pc` | `address += address_advance of special opcode 255` |
| `9` | `DW_LNS_fixed_advance_pc` | `address += u16 operand` (not scaled) |

#### Extended Opcodes

Extended opcodes begin with a `0` byte, followed by a `uleb128` length, followed by the extended opcode byte:

| Extended Opcode | Name | Effect |
|---|---|---|
| `1` | `DW_LNE_end_sequence` | Set `end_sequence = true`, emit row, reset state machine |
| `2` | `DW_LNE_set_address` | `address = u32 operand` (for WASM, always 4 bytes) |
| `3` | `DW_LNE_define_file` | Add a file entry (rarely used in practice) |

```typescript
function executeLineNumberProgram(
  bytes: Uint8Array,
  offset: u32,
  header: DebugLineHeader
): Array<LineEntry>;
```

### Step 4: Build the Lookup Table

Sort the resulting `LineEntry` array by `address` ascending. The `lookup(offset)` method performs a binary search to find the entry with the largest `address <= offset`.

---

## LEB128 Utilities

The DWARF format uses LEB128 (Little Endian Base 128) for variable-length integers throughout. Two variants are needed:

```typescript
/**
 * Read an unsigned LEB128 integer.
 * Returns the value and advances the offset.
 */
function readUleb128(bytes: Uint8Array, offset: u32): { value: u32, newOffset: u32 };

/**
 * Read a signed LEB128 integer.
 * Returns the value and advances the offset.
 */
function readSleb128(bytes: Uint8Array, offset: u32): { value: i32, newOffset: u32 };
```

---

## Module Structure

```
src/
  dwarf.ts          # Public API — parseDebugLine(), DebugLineInfo, LineEntry
  dwarf/
    section.ts      # findCustomSection() — locates .debug_line bytes in WASM binary
    header.ts       # parseHeader() — parses the .debug_line header
    program.ts      # executeLineNumberProgram() — runs the state machine
    leb128.ts       # readUleb128(), readSleb128()
```

---

## Verification

### Overview

A minimal test script `dwarf_test.ts` calls `parseDebugLine()` and emits the resulting line number matrix as JSON to stdout. It is compiled to WASM and run via `wasmtime`.

The test is self-verifying: we run it on its own compiled WASM binary and on `dwarf.ts`'s compiled WASM binary. If the output contains plausible source locations mapping back to the original `.ts` source files, the parser is working correctly.

### dwarf_test.ts

```typescript
// dwarf_test.ts
// Usage: wasmtime dwarf_test.wasm -- <input.wasm>
//
// Reads a WASM binary, parses its .debug_line section,
// and emits the line number matrix as JSON to stdout.

import { parseDebugLine } from "./dwarf";

// WASI provides access to command-line arguments and file I/O.
// Read the input file path from argv[1].
const path = argv[1];
const wasmBytes = readFile(path);  // WASI file read

const info = parseDebugLine(wasmBytes);

if (info === null) {
  console.error("No .debug_line section found in " + path);
  process.exit(1);
}

// Emit JSON
console.log("{");
console.log('  "file": ' + JSON.stringify(path) + ",");

// File table
console.log('  "files": [');
for (let i = 1; i < info.fileNames.length; i++) {
  const comma = i < info.fileNames.length - 1 ? "," : "";
  console.log('    ' + JSON.stringify(info.fileNames[i]) + comma);
}
console.log("  ],");

// Line number matrix
console.log('  "entries": [');
for (let i = 0; i < info.entries.length; i++) {
  const e = info.entries[i];
  const comma = i < info.entries.length - 1 ? "," : "";
  console.log(
    '    { "address": ' + e.address.toString() +
    ', "file": ' + e.fileIndex.toString() +
    ', "line": ' + e.line.toString() +
    ', "column": ' + e.column.toString() +
    ', "isStmt": ' + (e.isStmt ? "true" : "false") +
    ', "endSequence": ' + (e.endSequence ? "true" : "false") +
    ' }' + comma
  );
}
console.log("  ]");
console.log("}");
```

### Verification Steps

#### Step 1: Compile the test script and the parser

```bash
# Compile dwarf.ts (the library under test)
asc src/dwarf.ts --outFile dwarf.wasm --debug

# Compile dwarf_test.ts (the test harness)
asc src/dwarf_test.ts --outFile dwarf_test.wasm --debug
```

#### Step 2: Run the test on dwarf_test.wasm itself

```bash
wasmtime dwarf_test.wasm -- dwarf_test.wasm > dwarf_test_self.json
```

Inspect the output. You should see entries mapping Code-section byte offsets back to lines in `dwarf_test.ts`. For example:

```json
{
  "file": "dwarf_test.wasm",
  "files": [
    "dwarf_test.ts"
  ],
  "entries": [
    { "address": 42, "file": 1, "line": 8, "column": 0, "isStmt": true, "endSequence": false },
    { "address": 67, "file": 1, "line": 12, "column": 0, "isStmt": true, "endSequence": false },
    ...
  ]
}
```

#### Step 3: Run the test on dwarf.wasm

```bash
wasmtime dwarf_test.wasm -- dwarf.wasm > dwarf_self.json
```

This runs the parser against the compiled output of the parser's own source. Inspect the output and verify that file names reference `dwarf.ts` (and its submodules), and that line numbers fall within the expected range of those source files.

#### Step 4: Cross-reference manually

Pick a few entries from the JSON output and manually verify them:

1. Take an `address` value from the output
2. Use `wasm-objdump -d dwarf.wasm` to find the instruction at that byte offset in the Code section
3. Check that the reported `line` number matches the corresponding line in the `.ts` source file

This manual spot-check confirms the byte offset interpretation is correct per the DWARF for WebAssembly spec — addresses are Code-section-relative, not file-relative.

### What Correct Output Looks Like

- `files` array contains `.ts` filenames, not `.wasm` or `.wat` filenames
- `entries` array is sorted by `address` ascending
- Line numbers are plausible (within the line count of the source file)
- At least one entry per function in the source
- The last entry in each sequence has `"endSequence": true`
- Addresses do not exceed the size of the Code section

### What Incorrect Output Looks Like

- Empty `entries` array → `.debug_line` section not found or header parse failed
- All entries have `line: 1` → line advance opcodes not being applied
- Addresses decrease or repeat unexpectedly → address advance opcodes not being applied
- File names are empty strings → file name table parse failed
- JSON parse error → output encoding issue in `dwarf_test.ts`

---

## Open Questions

- **DWARF version** — AssemblyScript with `--debug` emits DWARF version 4. The header parser should assert `version == 4` and error clearly if it encounters version 5, which has a different header format.
- **Multiple compilation units** — a single `.debug_line` section may contain multiple compilation unit headers in sequence. The implementation should iterate through all of them and merge their line number matrices.
- **WASI file I/O in AssemblyScript** — confirm the available WASI bindings for reading a file by path from `argv`. The `as-wasi` package provides these but must be declared as a dependency.
- **JSON output encoding** — AssemblyScript strings are UTF-16 internally; verify that file name output is correctly encoded as UTF-8 in the JSON.
