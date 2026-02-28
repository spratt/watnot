// watnot: Annotated WAT generator.
// Injects source comments into disassembled WAT output.
//
// Usage:
//   wasmtime --dir . watnot.wasm <source.wasm.map> <source.wat> <source.offsets.json> <source1.ts> [source2.ts] ...

import { CommandLine, Console, FileSystem, Descriptor } from "as-wasi/assembly";
import { extractComments } from "./comments";
import { parseSourceMap } from "./sourcemap";
import { parseOffsetMap, buildLineToOffsetMap } from "./offsetmap";
import { injectComments, commentKey } from "./injector";

// --- Main ---

const args = CommandLine.all;

if (args.length < 5) {
  Console.error(
    "Usage: watnot <source.wasm.map> <source.wat> <source.offsets.json> <source1.ts> [source2.ts] ...\n"
  );
  abort();
}

const sourceMapPath = args[1];
const watPath = args[2];
const offsetMapPath = args[3];

// Step 1: Parse source map and offset map
const sourceMapJson = readFileText(sourceMapPath);
const sourceMap = parseSourceMap(sourceMapJson);
const watText = readFileText(watPath);
const offsetMapJson = readFileText(offsetMapPath);
const offsetEntries = parseOffsetMap(offsetMapJson);
const lineToOffset = buildLineToOffsetMap(offsetEntries);

// Step 2: Extract comments from each source file
const cMap = new Map<u64, string>();

for (let a: i32 = 4; a < args.length; a++) {
  const sourcePath = args[a];
  const srcIndex = findSourceIndex(sourceMap.sources, sourcePath);
  if (srcIndex < 0) {
    Console.error("Warning: " + sourcePath + " not found in source map, skipping\n");
    continue;
  }
  const sourceText = readFileText(sourcePath);
  const comments = extractComments(sourceText);
  for (let c: i32 = 0; c < comments.length; c++) {
    const key = commentKey(<u32>srcIndex, comments[c].line);
    cMap.set(key, comments[c].text);
  }
}

// Step 3: Inject comments into WAT
const annotatedWat = injectComments(
  watText,
  lineToOffset,
  sourceMap.entries,
  cMap
);

// Step 4: Write output to stdout
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

// Find a source file path in the source map's sources array.
// Tries exact match, then suffix match. Returns -1 if not found.
function findSourceIndex(sources: Array<string>, path: string): i32 {
  const normalized = path.startsWith("./") ? path.substring(2) : path;
  // Exact match
  for (let i: i32 = 0; i < sources.length; i++) {
    if (sources[i] == normalized) return i;
  }
  // Suffix match
  for (let i: i32 = 0; i < sources.length; i++) {
    if (sources[i].endsWith(normalized)) return i;
  }
  return -1;
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

