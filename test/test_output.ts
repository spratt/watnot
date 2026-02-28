// Focused test: does writeOutput produce correct output?
// Run with: wasmtime build/test_output.wasm
// Then compare stdout to expected output.

import { Console } from "as-wasi/assembly";
import { joinLines } from "../src/injector";

// Test 1: Build a multi-line string and write it using the same
// writeOutput logic from src/index.ts
const lines = new Array<string>();
lines.push("(module");
lines.push("  ;; this is a comment");
lines.push("  (func $add (param i32 i32) (result i32))");
lines.push("    (local.get 0)");
lines.push("    (local.get 1)");
lines.push("    (i32.add)");
lines.push("  )");
lines.push(")");

const text = joinLines(lines);

// Verify the string in memory is correct before output
Console.write("=== VERIFY STRING ===");
Console.write("length: " + text.length.toString());
Console.write("line count: " + text.split("\n").length.toString());

// Verify each line
const splitBack = text.split("\n");
for (let i = 0; i < splitBack.length; i++) {
  Console.write("line[" + i.toString() + "]: \"" + splitBack[i] + "\"");
}

Console.write("=== WRITE OUTPUT ===");

// This is the exact writeOutput function from src/index.ts
let start: i32 = 0;
for (let i: i32 = 0; i < text.length; i++) {
  if (text.charCodeAt(i) == 10) {
    Console.write(text.substring(start, i));
    start = i + 1;
  }
}
if (start < text.length) {
  Console.write(text.substring(start), false);
}

Console.write("");
Console.write("=== DONE ===");
