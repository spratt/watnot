import { test, expect } from "assemblyscript-unittest-framework/assembly";
import { injectComments, joinLines } from "../src/injector";
import { SourceComment } from "../src/comments";
import { SourceMapEntry } from "../src/sourcemap";

test("no mappings produces unchanged WAT", () => {
  const watText = "(module\n  (func $f)\n)\n";
  const lineToOffset = new Map<u32, u32>();
  const sourceEntries = new Array<SourceMapEntry>();
  const comments = new Array<SourceComment>();
  const result = injectComments(watText, lineToOffset, sourceEntries, comments);
  expect(result).equal("(module\n  (func $f)\n)");
});

test("injects comment before matching WAT line", () => {
  // WAT line 2 maps to byte offset 10
  // Source map: byte offset 10 → source line 2 (0-indexed)
  // Comment on source line 3 (1-indexed) = source map line 2 (0-indexed) + 1
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

  const comment = new SourceComment();
  comment.line = 3; // 1-indexed, matches sourceLine 2 (0-indexed) + 1
  comment.text = "// my comment";
  const comments = new Array<SourceComment>();
  comments.push(comment);

  const result = injectComments(watText, lineToOffset, sourceEntries, comments);
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

  const comment = new SourceComment();
  comment.line = 1;
  comment.text = "// hello world";
  const comments = new Array<SourceComment>();
  comments.push(comment);

  const result = injectComments(watText, lineToOffset, sourceEntries, comments);
  expect(result.includes(";; hello world")).equal(true);
  expect(result.includes("//")).equal(false);
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
