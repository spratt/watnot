# watnot: Annotated WAT Generator

## Overview

**watnot** is a command-line tool that takes an AssemblyScript source file and its compiled WASM binary, and produces a WAT file with the original source comments injected at the correct instruction locations.

watnot is itself implemented in AssemblyScript and compiled to WASM, so that running the tool on its own source produces annotated WAT — which serves as a bootstrapped, high-quality training example for the WasmGPT project.

---

## Inputs

- An AssemblyScript source file (`.ts`)
- The compiled WASM binary of that source file, built with `--debug --sourceMap` to include a source map

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

Read the AssemblyScript source file and extract all comments with their line numbers:
- Single-line comments (`// ...`)
- Multi-line comments (`/* ... */`)

Store as a map: `line number → comment text`

### Step 3: Disassemble binary to WAT with offset map

```bash
wasm2wat source.wasm --fold-exprs --debug-names --output source.wat --offset-map source.offsets.json
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

`--fold-exprs` emits instructions as nested S-expressions rather than flat stack notation, making the data flow explicit in the tree structure. `--debug-names` preserves function and local variable names from the name section.

Note: the folded S-expression form is preferred throughout watnot. `wasm-dis` (Binaryen) is explicitly avoided — it emits a non-compliant S-expression dialect that is incompatible with standard WAT tooling in several edge cases involving ordering and multi-return instructions.

### Step 4: Parse source map

Read the `.wasm.map` source map file and build a mapping:

```
WASM byte offset → source line number
```

Source maps use the standard [Source Map v3](https://sourcemaps.info/spec.html) format. The `mappings` field contains VLQ-encoded segments that map generated positions (WASM byte offsets) to original source positions (file, line, column).

### Step 5: Inject comments into WAT

Using the offset map from Step 3, correlate each WAT line with a WASM byte offset. Then look up that byte offset in the source map from Step 4 to find the original source line. If that source line (or the line immediately preceding it) has a comment in the comment map from Step 2, inject the comment into the WAT output at that position.

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

### Module Structure

```
src/
  index.ts          # Entry point, CLI argument handling
  sourcemap.ts      # Source map parser (v3 format, VLQ decoding)
  comments.ts       # Source file comment extractor
  injector.ts       # Combines source map + comment map → annotated WAT
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
  sourceLine: u32 = 0;
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

The injector reads the WAT file line by line. For each line, it checks the offset map for a byte offset, then looks up that offset in the source map to find the original source line, then checks the comment map for a comment at that source line.

---

## Bootstrapping

Once the tool is working, run it on its own source:

```bash
# Compile watnot itself
asc src/index.ts --outFile watnot.wasm --debug --sourceMap

# Disassemble to WAT with offset map
wasm2wat watnot.wasm --fold-exprs --debug-names --output watnot.wat --offset-map watnot.offsets.json

# Run watnot on its own source to produce annotated WAT
wasmtime watnot.wasm -- src/index.ts watnot.wasm.map watnot.wat watnot.offsets.json > watnot-annotated.wat
```

The resulting `watnot-annotated.wat` is a fully annotated WAT file of watnot itself — a high-quality, self-referential training example for WasmGPT.

---

## Open Questions

- **Multi-file projects** — source maps can reference multiple source files. Initial implementation may limit scope to single-file AssemblyScript inputs.
- **Comment proximity** — comments sometimes appear on the line *before* the statement they describe, and sometimes at the end of the same line. The injector should handle both cases.
