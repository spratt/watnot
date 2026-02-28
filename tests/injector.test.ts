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

// --- scan-upward tests ---

test("scan-upward: collects comment two lines above instruction", () => {
  // Source file layout:
  //   line 1: // doc comment
  //   line 2: function signature (no instruction)
  //   line 3: first instruction (mapped)
  const watText = "(module\n  (nop)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  lineToOffset.set(2, 10);

  const smEntry = new SourceMapEntry();
  smEntry.generatedOffset = 10;
  smEntry.sourceIndex = 0;
  smEntry.sourceLine = 2; // 0-indexed → source line 3
  smEntry.sourceColumn = 0;
  const sourceEntries = new Array<SourceMapEntry>();
  sourceEntries.push(smEntry);

  // Comment on source line 1 (two lines above the instruction)
  const cMap = new Map<u64, string>();
  cMap.set(commentKey(0, 1), "// doc comment");

  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  expect(result.includes(";; doc comment")).equal(true);
});

test("scan-upward: collects multiple comments in source order", () => {
  // Source file:
  //   line 1: // first comment
  //   line 2: // second comment
  //   line 3: instruction (mapped)
  const watText = "(module\n  (nop)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  lineToOffset.set(2, 10);

  const smEntry = new SourceMapEntry();
  smEntry.generatedOffset = 10;
  smEntry.sourceIndex = 0;
  smEntry.sourceLine = 2; // 0-indexed → source line 3
  smEntry.sourceColumn = 0;
  const sourceEntries = new Array<SourceMapEntry>();
  sourceEntries.push(smEntry);

  const cMap = new Map<u64, string>();
  cMap.set(commentKey(0, 1), "// first");
  cMap.set(commentKey(0, 2), "// second");

  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  expect(result.includes(";; first")).equal(true);
  expect(result.includes(";; second")).equal(true);
  // First comment should appear before second
  const firstIdx = result.indexOf(";; first");
  const secondIdx = result.indexOf(";; second");
  expect(firstIdx < secondIdx).equal(true);
});

test("scan-upward: stops at another mapped line", () => {
  // Source file:
  //   line 5: // belongs to first instruction
  //   line 6: first instruction (mapped)
  //   line 7: // belongs to second instruction
  //   line 8: second instruction (mapped)
  const watText = "(module\n  (nop)\n  (nop)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  lineToOffset.set(2, 10);
  lineToOffset.set(3, 20);

  const e1 = new SourceMapEntry();
  e1.generatedOffset = 10;
  e1.sourceIndex = 0;
  e1.sourceLine = 5; // 0-indexed → source line 6
  e1.sourceColumn = 0;

  const e2 = new SourceMapEntry();
  e2.generatedOffset = 20;
  e2.sourceIndex = 0;
  e2.sourceLine = 7; // 0-indexed → source line 8
  e2.sourceColumn = 0;

  const sourceEntries = new Array<SourceMapEntry>();
  sourceEntries.push(e1);
  sourceEntries.push(e2);

  const cMap = new Map<u64, string>();
  cMap.set(commentKey(0, 5), "// for first");
  cMap.set(commentKey(0, 7), "// for second");

  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  expect(result.includes(";; for first")).equal(true);
  expect(result.includes(";; for second")).equal(true);
  // "for first" should appear before the first nop, "for second" before the second
  const firstIdx = result.indexOf(";; for first");
  const firstNop = result.indexOf("(nop)");
  const secondIdx = result.indexOf(";; for second");
  expect(firstIdx < firstNop).equal(true);
  expect(secondIdx > firstNop).equal(true);
});

// --- file-level injection tests ---

test("file-level injection: injects header comments before first instruction", () => {
  // Source file:
  //   line 1: // file header
  //   line 2: // description
  //   line 3-9: imports and declarations (no instructions)
  //   line 10: first instruction (mapped)
  const watText = "(module\n  (nop)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  lineToOffset.set(2, 10);

  const smEntry = new SourceMapEntry();
  smEntry.generatedOffset = 10;
  smEntry.sourceIndex = 0;
  smEntry.sourceLine = 9; // 0-indexed → source line 10
  smEntry.sourceColumn = 0;
  const sourceEntries = new Array<SourceMapEntry>();
  sourceEntries.push(smEntry);

  const cMap = new Map<u64, string>();
  cMap.set(commentKey(0, 1), "// file header");
  cMap.set(commentKey(0, 2), "// description");

  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  expect(result.includes(";; file header")).equal(true);
  expect(result.includes(";; description")).equal(true);
  // Header should appear before the nop
  const headerIdx = result.indexOf(";; file header");
  const nopIdx = result.indexOf("(nop)");
  expect(headerIdx < nopIdx).equal(true);
});

test("file-level injection: preserves order of header comments", () => {
  const watText = "(module\n  (nop)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  lineToOffset.set(2, 10);

  const smEntry = new SourceMapEntry();
  smEntry.generatedOffset = 10;
  smEntry.sourceIndex = 0;
  smEntry.sourceLine = 4; // 0-indexed → source line 5
  smEntry.sourceColumn = 0;
  const sourceEntries = new Array<SourceMapEntry>();
  sourceEntries.push(smEntry);

  const cMap = new Map<u64, string>();
  cMap.set(commentKey(0, 1), "// AAA first");
  cMap.set(commentKey(0, 2), "// BBB second");
  cMap.set(commentKey(0, 3), "// CCC third");

  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  const aIdx = result.indexOf(";; AAA first");
  const bIdx = result.indexOf(";; BBB second");
  const cIdx = result.indexOf(";; CCC third");
  expect(aIdx < bIdx).equal(true);
  expect(bIdx < cIdx).equal(true);
});

test("file-level injection: multi-file headers go to correct files", () => {
  // Two files, each with a header comment, each with one instruction
  const watText = "(module\n  (nop)\n  (nop)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  lineToOffset.set(2, 10);
  lineToOffset.set(3, 20);

  const e1 = new SourceMapEntry();
  e1.generatedOffset = 10;
  e1.sourceIndex = 0;
  e1.sourceLine = 4; // 0-indexed → source line 5
  e1.sourceColumn = 0;

  const e2 = new SourceMapEntry();
  e2.generatedOffset = 20;
  e2.sourceIndex = 1;
  e2.sourceLine = 4; // 0-indexed → source line 5
  e2.sourceColumn = 0;

  const sourceEntries = new Array<SourceMapEntry>();
  sourceEntries.push(e1);
  sourceEntries.push(e2);

  // File 0 header on line 1, file 1 header on line 1
  const cMap = new Map<u64, string>();
  cMap.set(commentKey(0, 1), "// header file zero");
  cMap.set(commentKey(1, 1), "// header file one");

  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  expect(result.includes(";; header file zero")).equal(true);
  expect(result.includes(";; header file one")).equal(true);
});

// --- orphan pass tests ---

test("orphan pass: injects comment far from any mapped line", () => {
  // Source file:
  //   line 1: // section divider (orphan - far from instruction)
  //   lines 2-9: blank/code
  //   line 10: instruction (mapped)
  //   lines 11-19: blank/code
  //   line 20: // orphan comment
  //   lines 21-29: blank/code
  //   line 30: instruction (mapped)
  const watText = "(module\n  (nop)\n  (nop)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  lineToOffset.set(2, 10);
  lineToOffset.set(3, 20);

  const e1 = new SourceMapEntry();
  e1.generatedOffset = 10;
  e1.sourceIndex = 0;
  e1.sourceLine = 9; // 0-indexed → source line 10
  e1.sourceColumn = 0;

  const e2 = new SourceMapEntry();
  e2.generatedOffset = 20;
  e2.sourceIndex = 0;
  e2.sourceLine = 29; // 0-indexed → source line 30
  e2.sourceColumn = 0;

  const sourceEntries = new Array<SourceMapEntry>();
  sourceEntries.push(e1);
  sourceEntries.push(e2);

  // Orphan on line 20, between two mapped lines (10 and 30)
  const cMap = new Map<u64, string>();
  cMap.set(commentKey(0, 20), "// orphan divider");

  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  expect(result.includes(";; orphan divider")).equal(true);
});

test("orphan pass: prefers next instruction after comment", () => {
  // Orphan on line 15, mapped instructions on lines 10 and 20
  // Should attach to line 20's instruction (next after), not line 10 (before)
  const watText = "(module\n  (i32.const 1)\n  (i32.const 2)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  lineToOffset.set(2, 10);
  lineToOffset.set(3, 20);

  const e1 = new SourceMapEntry();
  e1.generatedOffset = 10;
  e1.sourceIndex = 0;
  e1.sourceLine = 9; // source line 10
  e1.sourceColumn = 0;

  const e2 = new SourceMapEntry();
  e2.generatedOffset = 20;
  e2.sourceIndex = 0;
  e2.sourceLine = 19; // source line 20
  e2.sourceColumn = 0;

  const sourceEntries = new Array<SourceMapEntry>();
  sourceEntries.push(e1);
  sourceEntries.push(e2);

  const cMap = new Map<u64, string>();
  cMap.set(commentKey(0, 15), "// between instructions");

  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  expect(result.includes(";; between instructions")).equal(true);
  // Should appear before i32.const 2, not before i32.const 1
  const commentIdx = result.indexOf(";; between instructions");
  const const2Idx = result.indexOf("(i32.const 2)");
  const const1Idx = result.indexOf("(i32.const 1)");
  expect(commentIdx > const1Idx).equal(true);
  expect(commentIdx < const2Idx).equal(true);
});

test("orphan pass: falls back to previous instruction when no next", () => {
  // Orphan on line 25, only mapped instruction on line 10
  const watText = "(module\n  (nop)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  lineToOffset.set(2, 10);

  const smEntry = new SourceMapEntry();
  smEntry.generatedOffset = 10;
  smEntry.sourceIndex = 0;
  smEntry.sourceLine = 9; // source line 10
  smEntry.sourceColumn = 0;
  const sourceEntries = new Array<SourceMapEntry>();
  sourceEntries.push(smEntry);

  const cMap = new Map<u64, string>();
  cMap.set(commentKey(0, 25), "// trailing comment");

  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  expect(result.includes(";; trailing comment")).equal(true);
});

test("orphan pass: does not duplicate scan-upward comments", () => {
  // Comment on line 2, instruction on line 3 — scan-upward handles it
  // Orphan pass should NOT re-inject it
  const watText = "(module\n  (nop)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  lineToOffset.set(2, 10);

  const smEntry = new SourceMapEntry();
  smEntry.generatedOffset = 10;
  smEntry.sourceIndex = 0;
  smEntry.sourceLine = 2; // 0-indexed → source line 3
  smEntry.sourceColumn = 0;
  const sourceEntries = new Array<SourceMapEntry>();
  sourceEntries.push(smEntry);

  const cMap = new Map<u64, string>();
  cMap.set(commentKey(0, 2), "// adjacent comment");

  const result = injectComments(watText, lineToOffset, sourceEntries, cMap);
  // Should appear exactly once
  const first = result.indexOf(";; adjacent comment");
  const second = result.indexOf(";; adjacent comment", first + 1);
  expect(first >= 0).equal(true);
  expect(second).equal(-1);
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
