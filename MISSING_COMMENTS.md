# Missing Comments: Approaches for Injecting Structural Comments

## Problem

Before implementing Approach E, the bootstrap verification showed that 50 out of 112 source comments were not injected into the annotated WAT output. The injector worked by matching each WAT line to a WASM byte offset (via the offset map), then looking up that byte offset in the source map to find the original source line, then checking for a comment on that line or the line immediately before it.

This approach only found comments directly adjacent to a line that generates a WASM instruction. Comments separated from the nearest instruction — by blank lines, function signatures, or other non-code-generating lines — were missed.

## Categories of Missing Comments

### 1. File-level documentation

Comments at the very top of a file, before any code:

```typescript
// watnot: Annotated WAT generator.
// Injects source comments into disassembled WAT output.
```

These are far from any instruction and describe the file as a whole.

### 2. Section dividers

Organizational markers between groups of functions:

```typescript
// --- Helpers ---
// --- Base64 VLQ ---
```

These separate logical sections of a file but don't correspond to any WASM structure.

### 3. Function documentation

Comments immediately before a function definition:

```typescript
// Find a source file path in the source map's sources array.
// Tries exact match, then suffix match. Returns -1 if not found.
function findSourceIndex(sources: Array<string>, path: string): i32 {
```

The function signature itself may not generate an instruction — the first instruction is inside the function body, potentially several lines below the comment.

### 4. Block-level comments

Comments before a group of statements inside a function:

```typescript
// Skip string literals to avoid false matches
if (ch === '"' || ch === "'" || ch === "`") {
```

If the comment is on the line immediately before the `if`, it should be caught by the current line-1 proximity check. But multi-line comments or comments separated by a blank line are missed.

---

## Approaches

### A. Wider Proximity Window (Not implementing)

Currently the injector checks the source line and line - 1 for comments. Widen this to check line - 2, line - 3, etc. up to some configurable limit (e.g., 5 lines).

Superseded by Approach E, which adaptively scans upward without a fixed limit.

### B. Function Boundary Detection (Not implementing)

Detect `(func ...` lines in the WAT output. For each function, use the source map to find which source line the function starts on, then scan upward in the source file to collect any comments immediately above the function definition.

Superseded by Approach E, which naturally handles function documentation by scanning upward from the first instruction inside a function past the function signature to the comments above it.

### C. File-Level Comment Injection (Implemented)

Collect all comments from the top of each source file (before the first non-comment, non-blank, non-import line) and inject them at a meaningful location in the WAT — either at the very top of the file, or before the first `(func` that originates from that source file.

**Pros:**
- Captures file-level documentation that describes the module's purpose
- Placement before the first function from that file is semantically meaningful

**Cons:**
- Only addresses file-level comments, not the other categories
- Requires heuristics to decide where "file-level" comments end
- If multiple source files contribute to the WAT, interleaving file headers could be confusing

#### Implementation

Implemented in `src/injector.ts`. Added `collectFileLevelComments()` which runs before the main injection loop.

**`collectFileLevelComments()`** — For each source file, finds the minimum source line that any WAT instruction maps to. Any comment with a line number below that minimum is a file-level comment — it appears before any code that generates WASM instructions. Comments are grouped by source index and sorted by line number so they appear in source order.

**Integration into `injectComments()`** — Tracks which source files have had their headers injected via a `headerInjected` set. When the main loop encounters the first WAT instruction from a given source file, it injects that file's file-level comments before the instruction and before the scan-upward pass runs.

**Results:** Bootstrap verification improved from 96/129 to 124/142 comments found. The 28 newly captured comments are file-level documentation headers from all 5 source files that were previously unreachable by the scan-upward approach.

#### Remaining Missing Comments (18)

After implementing both E and C, the 18 comments still missing are:

- **Section dividers** (3) — `// --- Base64 VLQ ---`, `// --- Minimal JSON field extraction ---`, `// --- Main parser ---` in sourcemap.ts. These sit between function groups with no nearby mapped instruction.
- **Multi-line function documentation** (15) — comments above functions in injector.ts (`injectComments`, `buildMappedLinesSet`, `collectFileLevelComments`, `scanUpwardForComments`) where multiple lines of documentation are separated from the first instruction by the function signature and local variable declarations, exceeding the scan-upward gap tolerance.

### D. Orphan Comment Pass (Implemented)

After the main injection pass, collect all source comments that were not injected. For each orphan comment, find the nearest instruction in the same source file (by line number) and inject the comment before that instruction's WAT line.

**Pros:**
- Catches all remaining comments, regardless of category
- No comment is left behind

**Cons:**
- Comments may end up far from their intended context
- Section dividers would be attached to arbitrary nearby instructions
- Could cluster many orphan comments before a single WAT line, making the output noisy
- "Nearest instruction" may be below the comment (forward) or above it (backward) — choosing the wrong direction misplaces the comment

#### Implementation

Implemented in `src/injector.ts`. Runs after the main injection loop (approaches E and C) as a final catch-all pass.

**`findOrphanKeys()`** — Collects all comment keys from the comment map that were not emitted by E or C. Returns them sorted by `(sourceIndex, line)` so orphans from the same file appear in source order.

**`buildSourceLineToWatLine()`** — Maps each `commentKey(sourceIndex, sourceLine)` to the first (smallest) WAT line number that maps to that source location. WAT lines are sorted before processing so the first occurrence wins.

**`buildMappedLinesByFile()`** — Groups mapped source line numbers by source index, with each file's lines sorted. Used by `findNearestWatLine()` to locate the closest instruction.

**`findNearestWatLine()`** — For a given orphan comment's `(sourceIndex, line)`, finds the nearest mapped source line in the same file. Prefers the next instruction after the comment (smallest mapped line >= comment line), falling back to the last instruction before the comment if none exists after it.

**Integration into `injectComments()`** — Tracks `watLineToOutputIndex` during the main loop, mapping each WAT line number to its position in the output array. After the loop, orphan comments are grouped by their target output index and inserted before the corresponding WAT line in a second pass that rebuilds the output array.

**Results:** Bootstrap verification improved from 124/142 to 158/158 — all source comments are now injected. The 34 newly captured comments are section dividers and multi-line function documentation that were unreachable by E's scan-upward and C's file-level injection.

#### Combined Results (E + C + D)

| Approach | Comments Found | Total | Improvement |
|----------|---------------|-------|-------------|
| Before   | 62            | 112   | —           |
| After E  | 96            | 129   | +34         |
| After C  | 124           | 142   | +28         |
| After D  | 158           | 158   | +34         |

Note: the total increases at each step because the new code in `injector.ts` itself contains comments that become part of the bootstrap verification.

### E. Scan-Upward from Mapped Lines (Implemented)

For each source line that the source map maps to, scan upward through the source file collecting all consecutive comment and blank lines until hitting a non-comment line or a line that is itself mapped. Inject all collected comments before the WAT line.

This is similar to widening the proximity window (Approach A) but adaptive — it doesn't use a fixed limit, it scans until it hits a boundary.

**Pros:**
- Adapts to however many comment lines precede an instruction
- Catches function docs (scan up from first instruction hits the doc comment above the signature)
- Natural boundary: stops at the previous mapped line, so comments aren't stolen from other instructions

**Cons:**
- Requires knowing which source lines are mapped (building a set of all mapped source lines)
- May still miss file-level comments if no instruction maps to a line near them
- Section dividers between two functions would be attributed to whichever function's first instruction is mapped next

#### Implementation

Implemented in `src/injector.ts`. The old `findCommentKey()` function (which checked only the source line and line - 1) was replaced by `scanUpwardForComments()`.

**`buildMappedLinesSet()`** — Before the main injection loop, iterates over all WAT line → byte offset mappings, looks up each byte offset in the source map, and builds a `Set<u64>` of `commentKey(sourceIndex, sourceLine)` values for every source line that is mapped to by at least one WAT instruction. This set acts as the boundary for upward scanning — scanning stops when it hits a line that belongs to another instruction.

**`scanUpwardForComments()`** — Given a source line that a WAT instruction maps to, scans upward line by line:

1. Checks the source line itself for a comment.
2. Scans upward (line - 1, line - 2, ...) collecting comment keys.
3. Stops when it hits a line that is in the `mappedLines` set (another instruction's source line).
4. If it hits a line with no comment, it peeks one line further — if there's a comment just above (separated by a single gap like a blank line or function signature), it continues scanning. Otherwise it stops.
5. Returns collected keys in top-down order (lowest line number first) so comments are injected in the order they appear in the source.

**Results:** Bootstrap verification improved from 62/112 to 96/129 comments found. The total increased from 112 to 129 because the new scan-upward code itself contains comments. The 34 newly captured comments are function documentation and block-level comments that were previously missed due to the fixed 1-line proximity window.

#### Remaining Missing Comments (33)

The 33 comments still missing after Approach E are:

- **File-level documentation** (12) — comments at the top of each source file, before any imports or code. Too far from any mapped instruction for upward scanning to reach.
- **Section dividers** (5) — `// --- Main ---`, `// --- Helpers ---`, `// --- Base64 VLQ ---`, etc. These sit between function groups with no nearby mapped instruction.
- **Module-scope block comments** (10) — `// Step 1: ...` through `// Step 4: ...` in index.ts and similar comments at module scope, separated from instructions by variable declarations.
- **Multi-line function docs separated by declarations** (6) — function documentation above `injectComments`, `scanUpwardForComments`, etc., separated from the first instruction by the function signature and local variable declarations.

### F. Combination Approach (Implemented as E + C + D)

Combined three complementary approaches, each handling different comment categories:

1. **Scan-upward (E)** for function docs and block-level comments
2. **File-level injection (C)** for file headers
3. **Orphan pass (D)** for section dividers and any remaining comments

The approaches run in order (E and C during the main loop, D after) and share an `emittedComments` set to avoid duplicate injection. The result is 158/158 comments found — complete coverage.
