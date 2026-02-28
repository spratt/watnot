import { test, expect } from "assemblyscript-unittest-framework/assembly";
import { extractComments } from "../src/comments";

test("single-line comment", () => {
  const result = extractComments("// hello\ncode\n");
  expect(result.length).equal(1);
  expect(result[0].line).equal(1);
  expect(result[0].text).equal("// hello");
});

test("comment after code", () => {
  const result = extractComments("code\n// after\n");
  expect(result.length).equal(1);
  expect(result[0].line).equal(2);
  expect(result[0].text).equal("// after");
});

test("multi-line comment", () => {
  const result = extractComments("/* multi\nline */\ncode\n");
  expect(result.length).equal(1);
  expect(result[0].line).equal(1);
  expect(result[0].text).equal("/* multi\nline */");
});

test("multiple comments", () => {
  const result = extractComments("// first\ncode\n// second\n");
  expect(result.length).equal(2);
  expect(result[0].line).equal(1);
  expect(result[0].text).equal("// first");
  expect(result[1].line).equal(3);
  expect(result[1].text).equal("// second");
});

test("comment inside string should be ignored", () => {
  const result = extractComments('let s = "// not a comment";\n// real comment\n');
  expect(result.length).equal(1);
  expect(result[0].text).equal("// real comment");
});

test("no comments", () => {
  const result = extractComments("let x = 1;\nlet y = 2;\n");
  expect(result.length).equal(0);
});

test("empty input", () => {
  const result = extractComments("");
  expect(result.length).equal(0);
});
