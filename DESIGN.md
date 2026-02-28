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

### Step 3: Disassemble binary to WAT

```bash
wasm2wat source.wasm --fold-exprs --debug-names --output source.wat
```

This produces a human-readable WAT file in folded S-expression form. `--fold-exprs` emits instructions as nested S-expressions rather than flat stack notation, making the data flow explicit in the tree structure. `--debug-names` preserves function and local variable names from the name section.

Note: the folded S-expression form is preferred throughout watnot. `wasm-dis` (Binaryen) is explicitly avoided — it emits a non-compliant S-expression dialect that is incompatible with standard WAT tooling in several edge cases involving ordering and multi-return instructions.

### Step 4: Parse source map

Read the `.wasm.map` source map file and build a mapping:

```
WASM byte offset → source line number
```

Source maps use the standard [Source Map v3](https://sourcemaps.info/spec.html) format. The `mappings` field contains VLQ-encoded segments that map generated positions (WASM byte offsets) to original source positions (file, line, column).

### Step 5: Inject comments into WAT

Walk the WAT instruction stream. At each instruction, look up its source line number via the source map. If that line number (or the line immediately preceding it) has a comment in the comment map, inject the comment into the WAT output at that position.

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
type SourceComment = {
  line: u32;
  text: string;  // includes the comment syntax, e.g. "// my comment"
};

// One entry from the source map
type SourceMapEntry = {
  generatedOffset: u32;  // byte offset in the WASM binary
  sourceLine: u32;
};

// An instruction in the WAT file with its position
type WatInstruction = {
  byteOffset: u32;   // corresponding byte offset in the WASM binary
  watLine: u32;      // line number in the WAT file
  text: string;      // the instruction text
};
```

### Source Map Parsing Notes

Source maps use the [Source Map v3](https://sourcemaps.info/spec.html) format:
- The file is JSON with fields: `version`, `sources`, `sourcesContent`, `mappings`, `names`
- The `mappings` field is a string of VLQ-encoded segments separated by `,` (within a line) and `;` (between lines)
- Each segment encodes: generated column, source file index, original line, original column, and optionally a name index
- For WASM source maps, the "generated line" is always 0 and the "generated column" is the byte offset into the WASM binary
- VLQ (Variable-Length Quantity) uses base64 encoding with continuation bits

### WAT Parsing Notes

Rather than building a full WAT parser, a line-oriented approach is sufficient:
- Use `wasm2wat --fold-exprs --debug-names` to produce the WAT file as a preprocessing step
- Parse the WAT line by line
- Use the source map to correlate WAT lines with WASM byte offsets

Alternatively, the tool can operate directly on the WASM binary without invoking `wasm2wat` as a subprocess, reconstructing WAT output itself. This is more self-contained but significantly more work.

---

## Bootstrapping

Once the tool is working, run it on its own source:

```bash
# Compile watnot itself
asc src/index.ts --outFile watnot.wasm --debug --sourceMap

# Disassemble to WAT in folded S-expression form (plain, no annotations)
wasm2wat watnot.wasm --fold-exprs --debug-names --output watnot.wat

# Run watnot on its own source to produce annotated WAT
wasmtime watnot.wasm -- src/index.ts watnot.wasm > watnot-annotated.wat
```

The resulting `watnot-annotated.wat` is a fully annotated WAT file of watnot itself — a high-quality, self-referential training example for WasmGPT.

---

## Open Questions

- **WAT line ↔ byte offset correlation** — `wasm2wat` does not emit byte offsets in its output by default. Investigate whether `--enable-annotations` or similar flags produce offset information, or whether the tool must reconstruct this mapping from the WASM binary directly.
- **Multi-file projects** — source maps can reference multiple source files. Initial implementation may limit scope to single-file AssemblyScript inputs.
- **Comment proximity** — comments sometimes appear on the line *before* the statement they describe, and sometimes at the end of the same line. The injector should handle both cases.
