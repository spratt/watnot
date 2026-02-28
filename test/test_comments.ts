// Unit tests for src/comments.ts
import { Console } from "as-wasi/assembly";
import { extractComments } from "../src/comments";

let passed: i32 = 0;
let failed: i32 = 0;

function assert_eq(actual: string, expected: string, label: string): void {
  if (actual == expected) {
    passed++;
  } else {
    failed++;
    Console.error("FAIL: " + label);
    Console.error("  expected: " + expected);
    Console.error("  actual:   " + actual);
  }
}

function assert_eq_u32(actual: u32, expected: u32, label: string): void {
  if (actual == expected) {
    passed++;
  } else {
    failed++;
    Console.error("FAIL: " + label);
    Console.error("  expected: " + expected.toString());
    Console.error("  actual:   " + actual.toString());
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

// Test 1: Single-line comment
const src1 = "// hello\ncode\n";
const c1 = extractComments(src1);
assert_eq_i32(c1.length, 1, "single-line: count");
assert_eq_u32(c1[0].line, 1, "single-line: line");
assert_eq(c1[0].text, "// hello", "single-line: text");

// Test 2: Comment after code
const src2 = "code\n// after\n";
const c2 = extractComments(src2);
assert_eq_i32(c2.length, 1, "after-code: count");
assert_eq_u32(c2[0].line, 2, "after-code: line");
assert_eq(c2[0].text, "// after", "after-code: text");

// Test 3: Multi-line comment
const src3 = "/* multi\nline */\ncode\n";
const c3 = extractComments(src3);
assert_eq_i32(c3.length, 1, "multi-line: count");
assert_eq_u32(c3[0].line, 1, "multi-line: line");
assert_eq(c3[0].text, "/* multi\nline */", "multi-line: text");

// Test 4: Multiple comments
const src4 = "// first\ncode\n// second\n";
const c4 = extractComments(src4);
assert_eq_i32(c4.length, 2, "multiple: count");
assert_eq_u32(c4[0].line, 1, "multiple: first line");
assert_eq(c4[0].text, "// first", "multiple: first text");
assert_eq_u32(c4[1].line, 3, "multiple: second line");
assert_eq(c4[1].text, "// second", "multiple: second text");

// Test 5: Comment inside string should be ignored
const src5 = 'let s = "// not a comment";\n// real comment\n';
const c5 = extractComments(src5);
assert_eq_i32(c5.length, 1, "string-skip: count");
assert_eq(c5[0].text, "// real comment", "string-skip: text");

// Test 6: No comments
const src6 = "let x = 1;\nlet y = 2;\n";
const c6 = extractComments(src6);
assert_eq_i32(c6.length, 0, "no-comments: count");

// Test 7: Empty input
const src7 = "";
const c7 = extractComments(src7);
assert_eq_i32(c7.length, 0, "empty: count");

// Summary
Console.write("comments: " + passed.toString() + " passed, " + failed.toString() + " failed");
if (failed > 0) abort();
