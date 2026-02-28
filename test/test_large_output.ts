// Test: joinLines + writeOutput at scale to reproduce garbled output.
// Run with: ~/.wasmtime/bin/wasmtime build/test_large_output.wasm

import { Console } from "as-wasi/assembly";
import { joinLines } from "../src/injector";

// Build a WAT-like string with 500 lines (realistic for a small WASM module)
const lines = new Array<string>();
lines.push("(module");
for (let i = 0; i < 498; i++) {
  lines.push("  (i32.const " + i.toString() + ")");
}
lines.push(")");

Console.error("step 1: joinLines with " + lines.length.toString() + " lines");
const text = joinLines(lines);

Console.error("step 2: joined length = " + text.length.toString());
const splitBack = text.split("\n");
Console.error("step 3: split back to " + splitBack.length.toString() + " lines");

// Verify first and last lines
Console.error("first line: " + splitBack[0]);
Console.error("last line: " + splitBack[splitBack.length - 1]);

// Check for corruption in the joined string
let corrupted = false;
for (let i = 0; i < text.length; i++) {
  const ch = text.charCodeAt(i);
  if (ch != 10 && ch != 13 && (ch < 32 || ch > 126)) {
    Console.error("CORRUPTION at index " + i.toString() + ": charCode=" + ch.toString());
    corrupted = true;
    break;
  }
}

if (!corrupted) {
  Console.error("step 4: no corruption in joined string");
}

// Now write using writeOutput pattern
Console.error("step 5: writing output via writeOutput pattern");
let start: i32 = 0;
for (let i: i32 = 0; i < text.length; i++) {
  if (text.charCodeAt(i) == 10) {
    Console.write(text.substring(start, i + 1), false);
    start = i + 1;
  }
}
if (start < text.length) {
  Console.write(text.substring(start), false);
}

Console.error("step 6: done");
