# Comment Transplanter: Annotated WAT Generator

## Overview

A command-line tool that takes an AssemblyScript source file and its compiled WASM binary, and produces a WAT file with the original source comments injected at the correct instruction locations.

The tool is itself implemented in AssemblyScript and compiled to WASM, so that running the tool on its own source produces annotated WAT — which serves as a bootstrapped, high-quality training example for the WasmGPT project.

---

## Inputs

- An AssemblyScript source file (`.ts`)
- The compiled WASM binary of that source file, built with `--debug` to include DWARF debug info

## Output

- A `.wat` file — the disassembled WASM with source comments injected at the corresponding instruction locations

---

## Pipeline

### Step 1: Compile AssemblyScript with debug symbols

```bash
asc source.ts --outFile source.wasm --debug
```

The `--debug` flag causes the compiler to embed DWARF debug information in a custom section of the WASM binary. This includes:
- Mapping from every WASM instruction byte offset → source file, line number, column
- Preserved function names
- Preserved local variable names

### Step 2: Parse source comments

Read the AssemblyScript source file and extract all comments with their line numbers:
- Single-line comments (`// ...`)
- Multi-line comments (`/* ... */`)

Store as a map: `line number → comment text`

### Step 3: Disassemble binary to WAT

```bash
wasm2wat source.wasm --output source.wat
```

This produces a human-readable WAT file. With debug info present, `wasm2wat` will preserve function and local variable names.

### Step 4: Parse DWARF

Read the DWARF debug section from the WASM binary and build a mapping:

```
WAT instruction index → source line number
```

DWARF is stored in custom sections named `.debug_line`, `.debug_info`, etc. The `.debug_line` section contains the line number program — a state machine that, when executed, produces the mapping from instruction byte offsets to source locations.

### Step 5: Inject comments into WAT

Walk the WAT instruction stream. At each instruction, look up its source line number via the DWARF mapping. If that line number (or the line immediately preceding it) has a comment in the source map, inject the comment into the WAT output at that position.

**Example:**

AssemblyScript source:
```typescript
function allocate(size: i32): i32 {
  // align to 8-byte boundary before allocating
  size = (size + 7) & -8;
  // check if heap has enough space remaining
  return heap_ptr + size <= heap_end;
}
```

Annotated WAT output:
```wat
(func $allocate (param $size i32) (result i32)
  ;; align to 8-byte boundary before allocating
  local.get $size
  i32.const 7
  i32.add
  i32.const -8
  i32.and
  local.tee $size
  ;; check if heap has enough space remaining
  global.get $heap_ptr
  i32.add
  global.get $heap_end
  i32.le_u)
```

---

## Implementation

The tool is implemented in AssemblyScript and compiled to WASM. It runs via a WASI-compatible runtime (e.g. `wasmtime` or `wasmedge`) from the command line.

### Module Structure

```
src/
  index.ts          # Entry point, CLI argument handling
  reader.ts         # Binary reader utilities (byte-level WASM parsing)
  dwarf.ts          # DWARF debug section parser
  wat.ts            # WAT file parser and instruction walker
  comments.ts       # Source file comment extractor
  injector.ts       # Combines DWARF map + comment map → annotated WAT
```

### Key Data Structures

```typescript
// A comment extracted from source
type SourceComment = {
  line: u32;
  text: string;  // includes the comment syntax, e.g. "// my comment"
};

// One entry from the DWARF line number program
type DebugLineEntry = {
  instructionOffset: u32;  // byte offset in the WASM binary
  sourceLine: u32;
};

// An instruction in the WAT file with its position
type WatInstruction = {
  byteOffset: u32;   // corresponding byte offset in the WASM binary
  watLine: u32;      // line number in the WAT file
  text: string;      // the instruction text
};
```

### DWARF Parsing Notes

DWARF is a complex format. The minimum viable implementation only needs to parse the `.debug_line` section, which contains the line number program. Libraries for DWARF parsing in AssemblyScript do not currently exist, so a minimal line number program interpreter must be implemented from scratch.

The `.debug_line` state machine tracks:
- `address` — current instruction byte offset
- `line` — current source line number
- `file` — current source file index

Standard opcodes of interest: `DW_LNS_advance_pc`, `DW_LNS_advance_line`, `DW_LNS_copy`, `DW_LNE_end_sequence`.

### WAT Parsing Notes

Rather than building a full WAT parser, a line-oriented approach is sufficient:
- Use `wasm2wat` to produce the WAT file as a preprocessing step
- Parse the WAT line by line
- Use the `wasm-dis` name section or DWARF to correlate WAT line numbers with WASM byte offsets

Alternatively, the tool can operate directly on the WASM binary without invoking `wasm2wat` as a subprocess, reconstructing WAT output itself. This is more self-contained but significantly more work.

---

## Bootstrapping

Once the tool is working, run it on its own source:

```bash
# Compile the tool itself
asc src/index.ts --outFile comment-transplanter.wasm --debug

# Disassemble to WAT (plain, no annotations)
wasm2wat comment-transplanter.wasm --output comment-transplanter.wat

# Run the tool on its own source to produce annotated WAT
wasmtime comment-transplanter.wasm -- src/index.ts comment-transplanter.wasm > comment-transplanter-annotated.wat
```

The resulting `comment-transplanter-annotated.wat` is a fully annotated WAT file of the tool itself — a high-quality, self-referential training example for WasmGPT.

---

## Open Questions

- **DWARF library availability** — no AssemblyScript DWARF library exists; the `.debug_line` state machine must be implemented from scratch. Assess complexity before committing to AssemblyScript vs. using a host-language tool (e.g. Rust with the `gimli` crate) for the DWARF parsing step.
- **WAT line ↔ byte offset correlation** — `wasm2wat` does not emit byte offsets in its output by default. Investigate whether `--enable-annotations` or similar flags produce offset information, or whether the tool must reconstruct this mapping from the WASM binary directly.
- **Multi-file projects** — DWARF can reference multiple source files. Initial implementation may limit scope to single-file AssemblyScript inputs.
- **Comment proximity** — comments sometimes appear on the line *before* the statement they describe, and sometimes at the end of the same line. The injector should handle both cases.
