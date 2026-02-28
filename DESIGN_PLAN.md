# watnot Implementation Plan

## Context

watnot has a DESIGN.md but no source code. This plan covers implementing the full pipeline: source comment extraction, source map parsing, offset map parsing, and comment injection.

## Resolved Design Decisions

1. **WAT output strategy** — Use external `wasm2wat` with `--offset-map` (from [our wabt fork](https://github.com/spratt/wabt/tree/byte_offsets)). The `--offset-map` flag produces a JSON file mapping WAT line numbers to WASM byte offsets, eliminating the need for watnot to parse the WASM binary or emit WAT itself.

2. **WAT format** — Folded S-expressions via `wasm2wat --fold-exprs`. The WAT output is produced externally; watnot only reads the resulting file line by line.

## Open Design Decisions

1. **JSON parsing** — Purpose-built minimal parser vs. `assemblyscript-json` npm package for parsing source map and offset map JSON.

---

## Phase 0: Project Scaffolding

- `package.json` with `assemblyscript@^0.27`, `as-wasi@^0.6.0`, `@assemblyscript/wasi-shim@^0.1`
- `asconfig.json` extending `@assemblyscript/wasi-shim/asconfig.json`
- `npm install`
- Compile with `--config node_modules/@assemblyscript/wasi-shim/asconfig.json` for WASI compatibility

## Phase 1: `src/comments.ts` — Source Comment Extractor

No dependencies. Walk source text character by character, tracking string literal state to avoid false matches.

```typescript
class SourceComment {
  line: u32 = 0;
  text: string = "";
}

export function extractComments(source: string): Array<SourceComment>
```

Extract `//` and `/* */` comments with their line numbers. Handle edge cases: comments inside strings, end-of-line comments, multi-line comments.

## Phase 2: `src/sourcemap.ts` — Source Map Parser

Two sub-components:

### 2a: Base64 VLQ Decoder

Decode the `mappings` string from the source map. VLQ uses base64 with continuation bits (bit 5) and sign in LSB.

```typescript
class VLQResult {
  value: i32 = 0;
  index: i32 = 0;
}

function decodeVLQ(mappings: string, index: i32): VLQResult
```

### 2b: Mappings Parser

Parse VLQ segments into entries. For WASM source maps, all segments are on "line 0" (comma-separated, no semicolons). Values are delta-encoded.

```typescript
class SourceMapEntry {
  generatedOffset: u32 = 0;  // byte offset in WASM binary
  sourceLine: u32 = 0;       // 0-indexed source line
  sourceColumn: u32 = 0;
  sourceIndex: u32 = 0;
}

export function parseSourceMap(json: string): Array<SourceMapEntry>
```

Requires a minimal JSON parser to extract the `mappings`, `sources`, and `names` fields.

## Phase 3: `src/offsetmap.ts` — Offset Map Parser

Parse the JSON offset map produced by `wasm2wat --offset-map`. The format is simple:

```json
{
  "version": 1,
  "mappings": [
    { "watLine": 4, "offset": 35 },
    ...
  ]
}
```

```typescript
class OffsetMapEntry {
  watLine: u32 = 0;
  offset: u32 = 0;
}

export function parseOffsetMap(json: string): Array<OffsetMapEntry>
```

Can share the JSON parser with Phase 2.

## Phase 4: `src/injector.ts` — Comment Injection

Combines offset map + source map + comment map → annotated WAT.

```typescript
export function injectComments(
  watText: string,
  offsetMap: Array<OffsetMapEntry>,
  sourceMap: Array<SourceMapEntry>,
  comments: Array<SourceComment>
): string
```

For each WAT line:
1. Look up the byte offset via the offset map
2. Binary search the source map for that byte offset to find the source line
3. Check whether that source line (or the line before) has a comment
4. If so, emit the comment as a `;;` WAT comment before the instruction line

Track emitted comments to avoid duplicates.

## Phase 5: `src/index.ts` — CLI Entry Point

Uses `as-wasi` for file I/O and argv. Reads the source file, source map, WAT file, and offset map. Runs the full pipeline and writes annotated WAT to stdout.

```
Usage: wasmtime --dir . watnot.wasm <source.ts> <source.wasm.map> <source.wat> <source.offsets.json>
```

## Phase 6: Testing and Bootstrapping

- Test fixtures: small `.ts` files with known comments
- End-to-end: compile fixture with `asc`, disassemble with `wasm2wat --offset-map`, run watnot, verify comments in output
- Bootstrap: run watnot on its own source

## Implementation Order

| Step | Module | Dependencies |
|------|--------|-------------|
| 0 | Scaffolding | — |
| 1 | `src/comments.ts` | scaffolding |
| 2 | `src/sourcemap.ts` | scaffolding |
| 3 | `src/offsetmap.ts` | scaffolding |
| 4 | `src/injector.ts` | `comments.ts`, `sourcemap.ts`, `offsetmap.ts` |
| 5 | `src/index.ts` | all modules |
| 6 | Tests | `index.ts` |

Steps 1, 2, and 3 are independent and can be developed in parallel.

## AssemblyScript Constraints

- All classes need field initializers
- No closures, no for..of, no anonymous object returns
- Sort comparators must be top-level functions
- `as-wasi` `readAll()` returns `u8[]`, needs copy to `Uint8Array`
- `String.UTF8.decodeUnsafe()` for UTF-8 byte buffers
- `abort()` instead of `process.exit()`
