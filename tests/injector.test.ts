import { test, expect } from "assemblyscript-unittest-framework/assembly";
import { injectComments, joinLines, commentKey } from "../src/injector";
import { SourceMapEntry } from "../src/sourcemap";

test("no mappings produces unchanged WAT", () => {
  const watText = "(module\n  (func $f)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  const sourceEntries = new Array<SourceMapEntry>();
  const cMap = new Map<u64, string>();
  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  expect(result).equal("(module\n  (func $f)\n)");
});

test("injects comment before matching WAT line", () => {
  const watText = "(module\n  (i32.const 1)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  lineToOffset.set(2, 10);

  const smEntry = new SourceMapEntry();
  smEntry.generatedOffset = 10;
  smEntry.sourceIndex = 0;
  smEntry.sourceLine = 2; // 0-indexed
  smEntry.sourceColumn = 0;
  const sourceEntries = new Array<SourceMapEntry>();
  sourceEntries.push(smEntry);

  // Comment on source line 3 (1-indexed) = sourceLine 2 (0-indexed) + 1
  const cMap = new Map<u64, string>();
  cMap.set(commentKey(0, 3), "// my comment");

  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  expect(result.includes(";; my comment")).equal(true);
});

test("convertToWatComment converts // to ;;", () => {
  const watText = "(module\n  (nop)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  lineToOffset.set(2, 10);

  const smEntry = new SourceMapEntry();
  smEntry.generatedOffset = 10;
  smEntry.sourceIndex = 0;
  smEntry.sourceLine = 0;
  smEntry.sourceColumn = 0;
  const sourceEntries = new Array<SourceMapEntry>();
  sourceEntries.push(smEntry);

  const cMap = new Map<u64, string>();
  cMap.set(commentKey(0, 1), "// hello world");

  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  expect(result.includes(";; hello world")).equal(true);
  expect(result.includes("//")).equal(false);
});

test("multi-file: only injects from matching sourceIndex", () => {
  const watText = "(module\n  (nop)\n  (nop)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  lineToOffset.set(2, 10);
  lineToOffset.set(3, 20);

  // WAT line 2 → byte offset 10 → sourceIndex 0, sourceLine 4
  const e1 = new SourceMapEntry();
  e1.generatedOffset = 10;
  e1.sourceIndex = 0;
  e1.sourceLine = 4; // 0-indexed, so source line 5
  e1.sourceColumn = 0;

  // WAT line 3 → byte offset 20 → sourceIndex 1, sourceLine 2
  const e2 = new SourceMapEntry();
  e2.generatedOffset = 20;
  e2.sourceIndex = 1;
  e2.sourceLine = 2; // 0-indexed, so source line 3
  e2.sourceColumn = 0;

  const sourceEntries = new Array<SourceMapEntry>();
  sourceEntries.push(e1);
  sourceEntries.push(e2);

  // Comment from file 0, line 5; comment from file 1, line 3
  const cMap = new Map<u64, string>();
  cMap.set(commentKey(0, 5), "// from file zero");
  cMap.set(commentKey(1, 3), "// from file one");

  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  expect(result.includes(";; from file zero")).equal(true);
  expect(result.includes(";; from file one")).equal(true);
});

test("multi-file: wrong sourceIndex does not match", () => {
  const watText = "(module\n  (nop)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  lineToOffset.set(2, 10);

  const smEntry = new SourceMapEntry();
  smEntry.generatedOffset = 10;
  smEntry.sourceIndex = 5;
  smEntry.sourceLine = 0;
  smEntry.sourceColumn = 0;
  const sourceEntries = new Array<SourceMapEntry>();
  sourceEntries.push(smEntry);

  // Comment keyed to sourceIndex 0, not 5
  const cMap = new Map<u64, string>();
  cMap.set(commentKey(0, 1), "// should not appear");

  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  expect(result.includes(";;")).equal(false);
});

test("commentKey encodes sourceIndex and line", () => {
  const k1 = commentKey(0, 1);
  const k2 = commentKey(0, 2);
  const k3 = commentKey(1, 1);
  // Different lines → different keys
  expect(k1 != k2).equal(true);
  // Different sourceIndex → different keys
  expect(k1 != k3).equal(true);
  // Same inputs → same key
  expect(commentKey(0, 1)).equal(k1);
});

// --- joinLines tests ---

test("joinLines with empty array", () => {
  const lines = new Array<string>();
  expect(joinLines(lines)).equal("");
});

test("joinLines with single line", () => {
  const lines = new Array<string>();
  lines.push("hello");
  expect(joinLines(lines)).equal("hello");
});

test("joinLines with two lines", () => {
  const lines = new Array<string>();
  lines.push("hello");
  lines.push("world");
  expect(joinLines(lines)).equal("hello\nworld");
});

test("joinLines with empty strings", () => {
  const lines = new Array<string>();
  lines.push("");
  lines.push("");
  lines.push("");
  expect(joinLines(lines)).equal("\n\n");
});

test("joinLines with many lines", () => {
  const lines = new Array<string>();
  for (let i = 0; i < 100; i++) {
    lines.push("line " + i.toString());
  }
  const result = joinLines(lines);
  expect(result.includes("line 0\nline 1")).equal(true);
  expect(result.includes("line 98\nline 99")).equal(true);
});

test("joinLines with large lines", () => {
  const lines = new Array<string>();
  let long = "";
  for (let i = 0; i < 200; i++) {
    long += "abcdefghij";
  }
  lines.push(long);
  lines.push(long);
  const result = joinLines(lines);
  expect(result.length).equal(long.length * 2 + 1);
});
