// Test harness: runs in wasmtime to reproduce garbled output bug.
// Tests the full pipeline (minus file I/O) at realistic scale.

import { Console } from "as-wasi/assembly";
import { extractComments } from "../src/comments";
import { parseSourceMap } from "../src/sourcemap";
import { parseOffsetMap, buildLineToOffsetMap } from "../src/offsetmap";
import { injectComments, joinLines } from "../src/injector";

let passed: i32 = 0;
let failed: i32 = 0;

function assert_eq(actual: string, expected: string, label: string): void {
  if (actual == expected) {
    passed++;
  } else {
    failed++;
    Console.error("FAIL: " + label);
    Console.error("  expected length: " + expected.length.toString());
    Console.error("  actual length:   " + actual.length.toString());
    // Show first difference
    const minLen = actual.length < expected.length ? actual.length : expected.length;
    for (let i = 0; i < minLen; i++) {
      if (actual.charCodeAt(i) != expected.charCodeAt(i)) {
        Console.error("  first diff at index: " + i.toString());
        const start = i > 20 ? i - 20 : 0;
        const end = i + 20 < actual.length ? i + 20 : actual.length;
        Console.error("  actual[" + start.toString() + ".." + end.toString() + "]:   " + actual.substring(start, end));
        const eEnd = i + 20 < expected.length ? i + 20 : expected.length;
        Console.error("  expected[" + start.toString() + ".." + eEnd.toString() + "]: " + expected.substring(start, eEnd));
        break;
      }
    }
    if (actual.length != expected.length && actual.length <= minLen) {
      Console.error("  actual is shorter than expected");
    } else if (actual.length != expected.length) {
      Console.error("  actual is longer than expected");
    }
  }
}

function assert_eq_i32(actual: i32, expected: i32, label: string): void {
  if (actual == expected) {
    passed++;
  } else {
    failed++;
    Console.error("FAIL: " + label);
    Console.error("  expected: " + expected.toString());
    Console.error("  actual:   " + actual.toString());
  }
}

// --- Test 1: joinLines at scale ---

const lines100 = new Array<string>();
for (let i = 0; i < 100; i++) {
  lines100.push("  (i32.const " + i.toString() + ")");
}
const joined100 = joinLines(lines100);
assert_eq_i32(joined100.split("\n").length, 100, "joinLines 100 lines: line count");

// --- Test 2: joinLines at WAT-realistic scale (1000 lines) ---

const lines1k = new Array<string>();
for (let i = 0; i < 1000; i++) {
  lines1k.push("  (i32.const " + i.toString() + ")");
}
const joined1k = joinLines(lines1k);
assert_eq_i32(joined1k.split("\n").length, 1000, "joinLines 1000 lines: line count");
// Check first and last lines survived
const split1k = joined1k.split("\n");
assert_eq(split1k[0], "  (i32.const 0)", "joinLines 1000: first line");
assert_eq(split1k[999], "  (i32.const 999)", "joinLines 1000: last line");

// --- Test 3: splitLines → joinLines roundtrip ---

let watBlock = "";
for (let i = 0; i < 500; i++) {
  watBlock += "  (i32.const " + i.toString() + ")\n";
}
// Remove trailing newline for fair comparison
const watTrimmed = watBlock.substring(0, watBlock.length - 1);
const roundtrip = joinLines(watTrimmed.split("\n"));
assert_eq(roundtrip, watTrimmed, "splitLines/joinLines roundtrip 500 lines");

// --- Test 4: injectComments with realistic data ---

// Build a small WAT-like text (50 lines)
let watText = "(module\n";
for (let i = 0; i < 48; i++) {
  watText += "  (i32.const " + i.toString() + ")\n";
}
watText += ")\n";

// Offset map: every other WAT line maps to a byte offset
const offsetJson = '{"version":1,"mappings":[';
let mappings = "";
for (let i: i32 = 0; i < 48; i++) {
  if (i > 0) mappings += ",";
  const watLine = i + 2; // lines 2-49
  const offset = (i + 1) * 4;
  mappings += '{"watLine":' + watLine.toString() + ',"offset":' + offset.toString() + '}';
}
const fullOffsetJson = offsetJson + mappings + "]}";

// Source map: each byte offset maps to a source line
let smMappings = "";
for (let i: i32 = 0; i < 48; i++) {
  if (i > 0) smMappings += ",";
  // Encode: genCol=(i+1)*4, srcIdx=0, srcLine=i, srcCol=0
  // For simplicity, just use AAAA for the first, then deltas
  smMappings += "AAAA"; // This won't give correct offsets, but tests the pipeline
}
const smJson = '{"version":3,"sources":["test.ts"],"mappings":"' + smMappings + '"}';

// Source with comments
let sourceText = "";
for (let i: i32 = 0; i < 48; i++) {
  if (i % 5 == 0) {
    sourceText += "// comment on line " + (i + 1).toString() + "\n";
  } else {
    sourceText += "let x = " + i.toString() + ";\n";
  }
}

const comments = extractComments(sourceText);
const sourceMap = parseSourceMap(smJson);
const offsetEntries = parseOffsetMap(fullOffsetJson);
const lineToOffset = buildLineToOffsetMap(offsetEntries);

const result = injectComments(watText, lineToOffset, sourceMap.entries, comments);

// The result should contain more lines than the original (injected comments)
const resultLines = result.split("\n");
const originalLines = watText.split("\n");

// Basic sanity: result should not be empty
assert_eq_i32(result.length > 0 ? 1 : 0, 1, "injectComments result is not empty");

// Result should contain original WAT content
assert_eq(resultLines[0], "(module", "injectComments: first line preserved");

// Result should be valid text (no garbled characters)
let hasGarbled: bool = false;
for (let i = 0; i < result.length; i++) {
  const ch = result.charCodeAt(i);
  // Check for non-printable, non-whitespace characters
  if (ch != 10 && ch != 13 && ch != 9 && (ch < 32 || ch > 126)) {
    hasGarbled = true;
    Console.error("  garbled char at index " + i.toString() + ": charCode=" + ch.toString());
    break;
  }
}
assert_eq_i32(hasGarbled ? 1 : 0, 0, "injectComments: no garbled characters");

// --- Test 5: Console.write output test ---
// Write a known string to stdout line by line (like writeOutput does)
const testOutput = "LINE_ONE\nLINE_TWO\nLINE_THREE";
let start: i32 = 0;
for (let i: i32 = 0; i < testOutput.length; i++) {
  if (testOutput.charCodeAt(i) == 10) {
    Console.write(testOutput.substring(start, i));
    start = i + 1;
  }
}
if (start < testOutput.length) {
  Console.write(testOutput.substring(start), false);
}

// Summary
Console.write("");
Console.write("pipeline: " + passed.toString() + " passed, " + failed.toString() + " failed");
if (failed > 0) abort();
