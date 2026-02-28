# Multi-File Support Plan

## Problem

watnot currently accepts a single source file for comment extraction. However, source maps reference multiple source files. When compiling `src/index.ts`, the source map lists 28 files — 5 are our own modules (`src/index.ts`, `src/comments.ts`, `src/sourcemap.ts`, `src/offsetmap.ts`, `src/injector.ts`) and 23 are AssemblyScript standard library files (`~lib/...`).

The injector already tracks `sourceIndex` in each `SourceMapEntry`, but currently ignores it. When a WAT line maps to a byte offset that corresponds to `src/comments.ts` (sourceIndex 20), the injector looks up the source line in the comment map — which only contains comments from `src/index.ts`. The line numbers don't correspond, so no comment is injected.

This is why the bootstrap test produces zero injected comments: most WAT instructions map to library code, and the few that map to our source files may map to modules other than the one we provided.

## Design

### CLI Change

Accept multiple source files instead of one:

```
wasmtime --dir . watnot.wasm \
  <source.wasm.map> <source.wat> <source.offsets.json> \
  <source1.ts> [source2.ts] ...
```

The source map and WAT/offset-map files come first, then one or more source files. The source map's `sources` array tells us which files are referenced; the user provides the ones they want comments extracted from.

### Source File Matching

The source map `sources` array contains paths like `src/index.ts`, `src/comments.ts`, `~lib/rt/tlsf.ts`. We need to match the user-provided file paths to entries in this array.

Strategy:
1. For each user-provided source file, find its index in the source map's `sources` array by matching the path suffix (e.g., `src/index.ts` matches `src/index.ts`)
2. Extract comments from that file, keyed by `(sourceIndex, line)`
3. When injecting, use the `sourceIndex` from the `SourceMapEntry` to look up comments in the correct file's comment map

### Data Structure Changes

Current comment map: `Map<u32, string>` (line → comment text)

New comment map: `Map<u64, string>` where the key encodes both source index and line:

```typescript
function commentKey(sourceIndex: u32, line: u32): u64 {
  return (<u64>sourceIndex << 32) | <u64>line;
}
```

### Module Changes

#### `src/index.ts`
- Parse new argument order: `wasm.map`, `wat`, `offsets.json`, then one or more `.ts` files
- For each source file:
  - Find its index in the source map's `sources` array
  - Call `extractComments()` on it
  - Store comments keyed by `(sourceIndex, line)`

#### `src/sourcemap.ts`
- `parseSourceMap()` already populates `sourceIndex` on each entry — no change needed
- Export the `sources` array (already done via `SourceMap.sources`)

#### `src/injector.ts`
- `injectComments()` signature changes: accept the new `Map<u64, string>` comment map
- When looking up comments, use `commentKey(entry.sourceIndex, sourceLine)` instead of just `sourceLine`
- `findCommentLine()` checks both `(sourceIndex, line)` and `(sourceIndex, line - 1)`

#### `src/comments.ts`
- No change needed — it extracts comments from a single file as before

### Path Matching

The source map `sources` array may use relative paths from the compilation root. The user provides paths relative to cwd. Matching strategy:

1. Normalize both paths (strip leading `./`)
2. Try exact match first
3. Fall back to suffix match (e.g., user provides `src/index.ts`, source map has `src/index.ts`)
4. If no match, skip the file with a warning

### Bootstrap Command

After this change, the bootstrap command becomes:

```bash
wasmtime --dir . build/watnot.wasm \
  build/watnot.wasm.map build/watnot.wat build/watnot.offsets.json \
  src/index.ts src/comments.ts src/sourcemap.ts \
  src/offsetmap.ts src/injector.ts \
  > build/watnot-annotated.wat
```

## Implementation Order

1. Change argument parsing in `src/index.ts`
2. Add source index matching (find source file in `sources` array)
3. Change comment map key to `(sourceIndex, line)`
4. Update `src/injector.ts` to use composite key
5. Update unit tests
6. Run bootstrap with all source files
