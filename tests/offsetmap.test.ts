import { test, expect } from "assemblyscript-unittest-framework/assembly";
import { parseOffsetMap, buildLineToOffsetMap } from "../src/offsetmap";

test("parse single mapping", () => {
  const json = '{"version":1,"mappings":[{"watLine":3,"offset":42}]}';
  const entries = parseOffsetMap(json);
  expect(entries.length).equal(1);
  expect(entries[0].watLine).equal(3);
  expect(entries[0].offset).equal(42);
});

test("parse multiple mappings", () => {
  const json = '{"version":1,"mappings":[{"watLine":1,"offset":10},{"watLine":5,"offset":20}]}';
  const entries = parseOffsetMap(json);
  expect(entries.length).equal(2);
  expect(entries[0].watLine).equal(1);
  expect(entries[0].offset).equal(10);
  expect(entries[1].watLine).equal(5);
  expect(entries[1].offset).equal(20);
});

test("parse empty mappings array", () => {
  const json = '{"version":1,"mappings":[]}';
  const entries = parseOffsetMap(json);
  expect(entries.length).equal(0);
});

test("parse with no mappings key", () => {
  const json = '{"version":1}';
  const entries = parseOffsetMap(json);
  expect(entries.length).equal(0);
});

test("buildLineToOffsetMap creates correct map", () => {
  const json = '{"version":1,"mappings":[{"watLine":3,"offset":42},{"watLine":7,"offset":100}]}';
  const entries = parseOffsetMap(json);
  const map = buildLineToOffsetMap(entries);
  expect(map.has(3)).equal(true);
  expect(map.get(3)).equal(42);
  expect(map.has(7)).equal(true);
  expect(map.get(7)).equal(100);
  expect(map.has(1)).equal(false);
});
