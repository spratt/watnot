# watnot: Annotated WAT Generator

## Overview

**watnot** is a command-line tool that takes an AssemblyScript source file and its compiled WASM binary, and produces a WAT file with the original source comments injected at the correct instruction locations.

watnot is itself implemented in AssemblyScript and compiled to WASM, so that running the tool on its own source produces annotated WAT — which serves as a bootstrapped, high-quality training example for the WasmGPT project.

---

## Inputs

- One or more AssemblyScript source files (`.ts`)
- The compiled WASM binary of those source files, built with `--debug --sourceMap` to include a source map

## Output

- A `.wat` file — the disassembled WASM with source comments injected at the corresponding instruction locations

---

## Pipeline

### Step 1: Compile AssemblyScript with source map

```bash
asc source.ts --outFile source.wasm --debug --sourceMap
```

The `--sourceMap` flag causes the compiler to emit a `source.wasm.map` file containing a source map. The source map provides a mapping from WASM byte offsets to source file locations (file, line, column). The `--debug` flag preserves function and local variable names.

Note: AssemblyScript does not emit DWARF debug sections. Source maps are the mechanism AssemblyScript uses for mapping generated code back to source locations.

### Step 2: Parse source comments

Read each AssemblyScript source file and extract all comments with their line numbers:
- Single-line comments (`// ...`)
- Multi-line comments (`/* ... */`)

Each source file is matched to its index in the source map's `sources` array (exact match, then suffix match). Comments are stored in a map keyed by `(sourceIndex, line)` using a composite `u64` key: `(sourceIndex << 32) | line`.

### Step 3: Disassemble binary to WAT with offset map

```bash
wasm2wat source.wasm --fold-exprs --output source.wat --offset-map source.offsets.json
```

This produces a human-readable WAT file in folded S-expression form, plus a JSON offset map that correlates WAT output line numbers with WASM binary byte offsets. The offset map is the key link between WAT output and source maps.

The `--offset-map` flag is provided by [our fork of wabt](https://github.com/spratt/wabt/tree/byte_offsets). It outputs a JSON file like:

```json
{
  "version": 1,
  "mappings": [
    { "watLine": 4, "offset": 35 },
    { "watLine": 5, "offset": 37 },
    { "watLine": 6, "offset": 39 }
  ]
}
```

`--fold-exprs` emits instructions as nested S-expressions rather than flat stack notation, making the data flow explicit in the tree structure. Debug names (function and local variable names from the name section) are preserved by default; use `--no-debug-names` to disable.

Note: the folded S-expression form is preferred throughout watnot. `wasm-dis` (Binaryen) is explicitly avoided — it emits a non-compliant S-expression dialect that is incompatible with standard WAT tooling in several edge cases involving ordering and multi-return instructions.

### Step 4: Parse source map

Read the `.wasm.map` source map file and build a mapping:

```
WASM byte offset → (sourceIndex, sourceLine, sourceColumn)
```

Source maps use the standard [Source Map v3](https://sourcemaps.info/spec.html) format. The `mappings` field contains VLQ-encoded segments that map generated positions (WASM byte offsets) to original source positions (file index, line, column). The `sources` array lists all referenced source files.

### Step 5: Inject comments into WAT

Using the offset map from Step 3, correlate each WAT line with a WASM byte offset. Then look up that byte offset in the source map from Step 4 to find the original source file and line. Use that source location to find comments in the comment map from Step 2 and inject them into the WAT output.

The injector uses three complementary strategies to achieve complete comment coverage. They run in order and share an `emittedComments` set so each comment is injected exactly once.

#### Scan-upward

The primary injection strategy. For each WAT line that maps to a source line, scan upward through the source file collecting comments until hitting a natural boundary (another mapped source line). This adaptively handles comments directly on an instruction, comments one line above, function documentation separated by a function signature, and multi-line comment blocks — without a fixed proximity window.

The scan peeks past single-line gaps (blank lines, function signatures) to find comments just above, but stops at mapped lines belonging to other instructions to avoid misattribution. Comments are injected in top-down source order before the WAT line.

#### File-level injection

For each source file, finds the minimum source line that any WAT instruction maps to. Any comment with a line number below that minimum is a file-level comment — it appears in the file header before any code that generates WASM instructions. These comments are injected before the first WAT instruction from that source file.

This handles file-level documentation (module descriptions, usage comments) that scan-upward cannot reach because imports and declarations separate them from the first instruction.

#### Orphan pass

After the main injection loop, collects any comments that were not placed by scan-upward or file-level injection. Each orphan is attached to the nearest WAT instruction from the same source file, preferring the next instruction after the comment. This catches section dividers and function documentation separated from the first instruction by multiple lines of declarations.

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

Annotated WAT output (folded S-expression form):
```wat
(func $allocate (param $size i32) (result i32)
  ;; check if heap has enough space remaining
  (i32.le_u
    (i32.add
      (global.get $heap_ptr)
      ;; align to 8-byte boundary before allocating
      (i32.and
        (i32.add
          (local.get $size)
          (i32.const 7))
        (i32.const -8)))
    (global.get $heap_end)))
```

---

## Implementation

watnot is implemented in AssemblyScript and compiled to WASM. It runs via a WASI-compatible runtime (e.g. `wasmtime` or `wasmedge`) from the command line.

### Usage

```
wasmtime --dir . watnot.wasm <source.wasm.map> <source.wat> <source.offsets.json> <source1.ts> [source2.ts] ...
```

Source files are matched to the source map's `sources` array by path (exact match first, then suffix match). Files not found in the source map are skipped with a warning.

### Module Structure

```
src/
  index.ts          # Entry point, CLI argument handling
  comments.ts       # Source file comment extractor
  sourcemap.ts      # Source map parser (v3 format, VLQ decoding)
  offsetmap.ts      # Offset map parser (wasm2wat --offset-map JSON)
  injector.ts       # Combines offset map + source map + comments → annotated WAT
```

### Key Data Structures

```typescript
// A comment extracted from source
class SourceComment {
  line: u32 = 0;
  text: string = "";  // includes the comment syntax, e.g. "// my comment"
}

// One entry from the source map
class SourceMapEntry {
  generatedOffset: u32 = 0;  // byte offset in the WASM binary
  sourceIndex: u32 = 0;      // index into sources array
  sourceLine: u32 = 0;       // 0-indexed source line
  sourceColumn: u32 = 0;
}

// One entry from the offset map (produced by wasm2wat --offset-map)
class OffsetMapEntry {
  watLine: u32 = 0;    // line number in the WAT file
  offset: u32 = 0;     // byte offset in the WASM binary
}
```

### Source Map Parsing Notes

Source maps use the [Source Map v3](https://sourcemaps.info/spec.html) format:
- The file is JSON with fields: `version`, `sources`, `sourcesContent`, `mappings`, `names`
- The `mappings` field is a string of VLQ-encoded segments separated by `,` (within a line) and `;` (between lines)
- Each segment encodes: generated column, source file index, original line, original column, and optionally a name index
- For WASM source maps, the "generated line" is always 0 and the "generated column" is the byte offset into the WASM binary
- VLQ (Variable-Length Quantity) uses base64 encoding with continuation bits

### Offset Map Notes

The offset map produced by `wasm2wat --offset-map` provides a direct `watLine → byteOffset` mapping. This eliminates the need for watnot to parse the WASM binary or reconstruct WAT output — the correlation between WAT lines and WASM byte offsets is provided externally.

The injector reads the WAT file line by line. For each line, it checks the offset map for a byte offset, then looks up that offset in the source map to find the original source line. It then uses the three injection strategies (scan-upward, file-level injection, orphan pass) to find and inject comments from the comment map.

---

## Bootstrapping

Once the tool is working, run it on its own source:

```bash
# Compile watnot itself
asc src/index.ts --outFile build/watnot.wasm \
  --config node_modules/@assemblyscript/wasi-shim/asconfig.json \
  --debug --sourceMap

# Disassemble to WAT with offset map
wasm2wat build/watnot.wasm --fold-exprs \
  --output build/watnot.wat \
  --offset-map build/watnot.offsets.json

# Run watnot on its own source to produce annotated WAT
wasmtime --dir . build/watnot.wasm \
  build/watnot.wasm.map build/watnot.wat build/watnot.offsets.json \
  src/index.ts src/comments.ts src/sourcemap.ts \
  src/offsetmap.ts src/injector.ts \
  > build/watnot-annotated.wat
```

The resulting `watnot-annotated.wat` is a fully annotated WAT file of watnot itself — a high-quality, self-referential training example for WasmGPT.

### Bootstrap Verification Script

`bootstrap.ts` automates the full bootstrap pipeline and verifies the output. It:

1. Builds watnot (`npm run build`)
2. Disassembles the binary to WAT with an offset map (`wasm2wat --fold-exprs --offset-map`)
3. Runs watnot on its own source files to produce annotated WAT
4. Extracts all comments from the source files and checks that each one appears in the annotated WAT output

Run it with:

```bash
npx ts-node bootstrap.ts
```

The bootstrap currently achieves 100% comment coverage — all source comments are injected into the annotated WAT output.

---

## Resolved Design Decisions

- **JSON parsing** — Purpose-built minimal parsers for source map and offset map JSON, rather than a third-party library. This avoids extra dependencies and handles only the fields we need.
- **Comment injection strategies** — Three complementary strategies (scan-upward, file-level injection, orphan pass) achieve 100% comment coverage. Scan-upward handles comments near instructions, file-level injection handles file headers, and the orphan pass catches section dividers and documentation separated from instructions by multiple lines of code. All three share an `emittedComments` set to avoid duplicates.
- **as-wasi writeStringLn() bug** — `as-wasi`'s `writeStringLn()` reuses `memory.data(8)` for both the `\n` byte and `fd_write`'s output pointer, so newlines get overwritten. The workaround is to include `\n` in the string itself and always use `Console.write(s, false)`.
- **Multi-file projects** — Source maps reference multiple source files (e.g., 28 files for watnot: 5 user modules + 23 stdlib). The CLI accepts multiple source files, each matched to its `sourceIndex` in the source map's `sources` array. Comments are keyed by `(sourceIndex, line)` using a composite `u64` key so the injector only matches comments from the correct file.

---

## AssemblyScript Constraints

- All classes need field initializers
- No closures, no `for..of`, no anonymous object returns
- Sort comparators must be top-level functions
- `abort()` instead of `process.exit()`
- WASI support requires `@assemblyscript/wasi-shim` and `as-wasi`
- Compile with `--config node_modules/@assemblyscript/wasi-shim/asconfig.json` for WASI compatibility
