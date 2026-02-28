// watnot: Annotated WAT generator.
// Injects source comments into disassembled WAT output.
//
// Usage:
//   wasmtime --dir . watnot.wasm <source.ts> <source.wasm.map> <source.wat> <source.offsets.json>

import { CommandLine, Console, FileSystem, Descriptor } from "as-wasi/assembly";
import { extractComments } from "./comments";
import { parseSourceMap } from "./sourcemap";
import { parseOffsetMap, buildLineToOffsetMap } from "./offsetmap";
import { injectComments } from "./injector";

// --- Main ---

const args = CommandLine.all;

if (args.length < 5) {
  Console.error(
    "Usage: watnot <source.ts> <source.wasm.map> <source.wat> <source.offsets.json>\n"
  );
  abort();
}

const sourcePath = args[1];
const sourceMapPath = args[2];
const watPath = args[3];
const offsetMapPath = args[4];

// Step 1: Read all input files
const sourceText = readFileText(sourcePath);
const sourceMapJson = readFileText(sourceMapPath);
const watText = readFileText(watPath);
const offsetMapJson = readFileText(offsetMapPath);

// Step 2: Parse source comments
const comments = extractComments(sourceText);

// Step 3: Parse source map
const sourceMap = parseSourceMap(sourceMapJson);

// Step 4: Parse offset map
const offsetEntries = parseOffsetMap(offsetMapJson);
const lineToOffset = buildLineToOffsetMap(offsetEntries);

// Step 5: Inject comments into WAT
const annotatedWat = injectComments(
  watText,
  lineToOffset,
  sourceMap.entries,
  comments
);

// Step 6: Write output to stdout, line by line to avoid large buffer issues
writeOutput(annotatedWat);

// --- Helpers ---

function writeOutput(text: string): void {
  // Write each line including its newline as a single string.
  // We avoid Console.write(s, true) because as-wasi's writeStringLn
  // has a bug: memory.data(8) is reused for both the '\n' byte and
  // fd_write's output pointer, so the newline gets overwritten.
  let start: i32 = 0;
  for (let i: i32 = 0; i < text.length; i++) {
    if (text.charCodeAt(i) == 10) { // '\n'
      Console.write(text.substring(start, i + 1), false);
      start = i + 1;
    }
  }
  if (start < text.length) {
    Console.write(text.substring(start), false);
  }
}

function readFileText(path: string): string {
  const fd = FileSystem.open(path, "r");
  if (fd === null) {
    Console.error("Error: could not open file: " + path + "\n");
    abort();
    return ""; // unreachable
  }
  const text = (fd as Descriptor).readString();
  if (text === null) {
    Console.error("Error: could not read file: " + path + "\n");
    abort();
    return ""; // unreachable
  }
  return text as string;
}

