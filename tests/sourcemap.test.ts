import { test, expect } from "assemblyscript-unittest-framework/assembly";
import { parseSourceMap, lookupOffset, SourceMapEntry } from "../src/sourcemap";

test("parse empty mappings", () => {
  const json = '{"version":3,"sources":["index.ts"],"mappings":""}';
  const sm = parseSourceMap(json);
  expect(sm.sources.length).equal(1);
  expect(sm.sources[0]).equal("index.ts");
  expect(sm.entries.length).equal(0);
});

test("parse sources array", () => {
  const json = '{"version":3,"sources":["a.ts","b.ts"],"mappings":""}';
  const sm = parseSourceMap(json);
  expect(sm.sources.length).equal(2);
  expect(sm.sources[0]).equal("a.ts");
  expect(sm.sources[1]).equal("b.ts");
});

test("parse single VLQ segment", () => {
  // "A" = 0, so genCol=0
  // "AAAA" = genCol delta=0, srcIdx delta=0, srcLine delta=0, srcCol delta=0
  const json = '{"version":3,"sources":["index.ts"],"mappings":"AAAA"}';
  const sm = parseSourceMap(json);
  expect(sm.entries.length).equal(1);
  expect(sm.entries[0].generatedOffset).equal(0);
  expect(sm.entries[0].sourceIndex).equal(0);
  expect(sm.entries[0].sourceLine).equal(0);
  expect(sm.entries[0].sourceColumn).equal(0);
});

test("parse multiple comma-separated segments", () => {
  // CAAC: C=base64(2), VLQ value=1; A=base64(0), VLQ value=0
  // So CAAC = genCol+1, srcIdx+0, srcLine+0, srcCol+1
  const json = '{"version":3,"sources":["index.ts"],"mappings":"AAAA,CAAC"}';
  const sm = parseSourceMap(json);
  expect(sm.entries.length).equal(2);
  expect(sm.entries[0].generatedOffset).equal(0);
  expect(sm.entries[0].sourceLine).equal(0);
  // Second entry: genCol=0+1=1, srcIdx=0, srcLine=0+0=0, srcCol=0+1=1
  expect(sm.entries[1].generatedOffset).equal(1);
  expect(sm.entries[1].sourceLine).equal(0);
  expect(sm.entries[1].sourceColumn).equal(1);
});

test("lookupOffset returns null for empty entries", () => {
  const entries = new Array<SourceMapEntry>();
  const result = lookupOffset(entries, 5);
  expect(result).isNull();
});

test("lookupOffset returns null when offset is before first entry", () => {
  const entries = new Array<SourceMapEntry>();
  const e = new SourceMapEntry();
  e.generatedOffset = 10;
  e.sourceLine = 5;
  entries.push(e);
  const result = lookupOffset(entries, 5);
  expect(result).isNull();
});

test("lookupOffset finds exact match", () => {
  const entries = new Array<SourceMapEntry>();
  const e = new SourceMapEntry();
  e.generatedOffset = 10;
  e.sourceLine = 5;
  entries.push(e);
  const result = lookupOffset(entries, 10);
  expect(result).not.isNull();
  expect((result as SourceMapEntry).sourceLine).equal(5);
});

test("lookupOffset finds closest entry not exceeding offset", () => {
  const entries = new Array<SourceMapEntry>();
  const e1 = new SourceMapEntry();
  e1.generatedOffset = 10;
  e1.sourceLine = 5;
  entries.push(e1);
  const e2 = new SourceMapEntry();
  e2.generatedOffset = 20;
  e2.sourceLine = 10;
  entries.push(e2);
  const result = lookupOffset(entries, 15);
  expect(result).not.isNull();
  expect((result as SourceMapEntry).sourceLine).equal(5);
});
