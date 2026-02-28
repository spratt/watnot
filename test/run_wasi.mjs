// Runs a WASI WASM module using Node.js's built-in node:wasi
import { readFile } from "node:fs/promises";
import { WASI } from "node:wasi";

const wasmFile = process.argv[2];
if (!wasmFile) {
  console.error("Usage: node test/run_wasi.mjs <file.wasm> [args...]");
  process.exit(1);
}

const wasi = new WASI({
  version: "preview1",
  args: process.argv.slice(2),
  preopens: { ".": "." },
});

const wasm = await WebAssembly.compile(await readFile(wasmFile));
const instance = await WebAssembly.instantiate(wasm, wasi.getImportObject());
try {
  wasi.start(instance);
} catch (e) {
  process.exit(1);
}
