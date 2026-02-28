// dwarf_test.ts
// Usage: wasmtime --dir . dwarf_test.wasm -- <input.wasm>
//
// Reads a WASM binary, parses its .debug_line section,
// and emits the line number matrix as JSON to stdout.

import { CommandLine, Console, FileSystem, Descriptor } from "as-wasi/assembly";
import { parseDebugLine, DebugLineInfo } from "./dwarf";

// Helper to escape a string for JSON output
function jsonString(s: string): string {
  let result = '"';
  for (let i = 0; i < s.length; i++) {
    const c = s.charCodeAt(i);
    if (c === 0x5c) {       // backslash
      result += "\\\\";
    } else if (c === 0x22) { // double quote
      result += '\\"';
    } else if (c === 0x0a) { // newline
      result += "\\n";
    } else if (c === 0x0d) { // carriage return
      result += "\\r";
    } else if (c === 0x09) { // tab
      result += "\\t";
    } else {
      result += String.fromCharCode(c);
    }
  }
  result += '"';
  return result;
}

// Read the input file path from argv[1]
const args = CommandLine.all;
if (args.length < 2) {
  Console.error("Usage: dwarf_test <input.wasm>");
  abort();
}
const path = args[1];

// Open and read the binary file
const fdOrNull = FileSystem.open(path, "r");
if (fdOrNull === null) {
  Console.error("Error: could not open file: " + path);
  abort();
}
const fd = fdOrNull as Descriptor;

const rawBytesOrNull = fd.readAll();
fd.close();

if (rawBytesOrNull === null) {
  Console.error("Error: could not read file: " + path);
  abort();
}
const rawBytes = rawBytesOrNull as u8[];

// Convert u8[] to Uint8Array for parseDebugLine
const wasmBytes = new Uint8Array(rawBytes.length);
for (let i = 0; i < rawBytes.length; i++) {
  wasmBytes[i] = unchecked(rawBytes[i]);
}

// Parse
const infoOrNull = parseDebugLine(wasmBytes);
if (infoOrNull === null) {
  Console.error("No .debug_line section found in " + path);
  abort();
}
const info = infoOrNull as DebugLineInfo;

// Emit JSON
Console.log("{");
Console.log("  \"file\": " + jsonString(path) + ",");

// File table
Console.log("  \"files\": [");
for (let i = 1; i < info.fileNames.length; i++) {
  const comma = i < info.fileNames.length - 1 ? "," : "";
  Console.log("    " + jsonString(info.fileNames[i]) + comma);
}
Console.log("  ],");

// Line number matrix
Console.log("  \"entries\": [");
for (let i = 0; i < info.entries.length; i++) {
  const e = info.entries[i];
  const comma = i < info.entries.length - 1 ? "," : "";
  Console.log(
    "    { \"address\": " + e.address.toString() +
    ", \"file\": " + e.fileIndex.toString() +
    ", \"line\": " + e.line.toString() +
    ", \"column\": " + e.column.toString() +
    ", \"isStmt\": " + (e.isStmt ? "true" : "false") +
    ", \"endSequence\": " + (e.endSequence ? "true" : "false") +
    " }" + comma
  );
}
Console.log("  ]");
Console.log("}");
