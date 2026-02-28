# watnot

watnot is a command-line tool that takes AssemblyScript source files and their compiled WASM binary, and produces a WAT file with the original source comments injected at the correct instruction locations.

watnot is itself implemented in AssemblyScript and compiled to WASM, so running the tool on its own source produces annotated WAT — a bootstrapped, self-referential training example for the WasmGPT project.

## Usage

```bash
# 1. Compile your AssemblyScript source with debug info and a source map
asc src/index.ts --outFile build/out.wasm --debug --sourceMap

# 2. Disassemble to WAT with an offset map (requires wabt with --offset-map support)
wasm2wat build/out.wasm --fold-exprs --output build/out.wat --offset-map build/out.offsets.json

# 3. Run watnot to produce annotated WAT
wasmtime --dir . build/watnot.wasm \
  build/out.wasm.map build/out.wat build/out.offsets.json \
  src/file1.ts src/file2.ts ...
```

The annotated WAT is written to stdout.

## Design

See [DESIGN.md](DESIGN.md) for the full pipeline, module structure, data structures, and design decisions.
