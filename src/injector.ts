// Comment injector: combines offset map + source map + comments
// to produce annotated WAT output.

import { SourceMapEntry, lookupOffset } from "./sourcemap";

// Encode (sourceIndex, line) into a single u64 key.
export function commentKey(sourceIndex: u32, line: u32): u64 {
  return (<u64>sourceIndex << 32) | <u64>line;
}

// Inject source comments into WAT text.
// lineToOffset: Map from WAT line number → WASM byte offset
// sourceEntries: sorted source map entries (byte offset → source location)
// commentMap: Map from commentKey(sourceIndex, line) → comment text
export function injectComments(
  watText: string,
  lineToOffset: Map<u32, u32>,
  sourceEntries: Array<SourceMapEntry>,
  commentMap: Map<u64, string>
): string {
  const watLines = splitLines(watText);
  const output = new Array<string>();
  const emittedComments = new Set<u64>();

  // Build a set of mapped source lines so scan-upward knows
  // where to stop (at another instruction's source line).
  const mappedLines = buildMappedLinesSet(lineToOffset, sourceEntries);

  for (let i: i32 = 0; i < watLines.length; i++) {
    const watLine = <u32>(i + 1); // 1-based
    const line = watLines[i];

    if (lineToOffset.has(watLine)) {
      const byteOffset = lineToOffset.get(watLine);
      const entry = lookupOffset(sourceEntries, byteOffset);

      if (entry !== null) {
        const e = entry as SourceMapEntry;
        const srcIndex = e.sourceIndex;
        const sourceLine = e.sourceLine + 1; // source map lines are 0-indexed

        // Scan upward to collect all comments above this instruction
        const keys = scanUpwardForComments(commentMap, mappedLines, srcIndex, sourceLine);
        for (let k: i32 = 0; k < keys.length; k++) {
          const key = keys[k];
          if (!emittedComments.has(key)) {
            emittedComments.add(key);
            const commentText = commentMap.get(key);
            const watComment = convertToWatComment(commentText);
            const indent = getIndent(line);
            output.push(indent + watComment);
          }
        }
      }
    }

    output.push(line);
  }

  return joinLines(output);
}

// Build a set of (sourceIndex, sourceLine) keys for all source lines
// that are mapped to by any WAT instruction via the source map.
function buildMappedLinesSet(
  lineToOffset: Map<u32, u32>,
  sourceEntries: Array<SourceMapEntry>
): Set<u64> {
  const mapped = new Set<u64>();
  const watLines = lineToOffset.keys();
  for (let i: i32 = 0; i < watLines.length; i++) {
    const byteOffset = lineToOffset.get(watLines[i]);
    const entry = lookupOffset(sourceEntries, byteOffset);
    if (entry !== null) {
      const e = entry as SourceMapEntry;
      const key = commentKey(e.sourceIndex, e.sourceLine + 1);
      mapped.add(key);
    }
  }
  return mapped;
}

// Scan upward from the given source line to find all comment keys.
// Stops when it hits a line that is mapped to another instruction
// (present in mappedLines) or when it runs out of comments to collect.
// Returns keys in top-down order (lowest line number first).
function scanUpwardForComments(
  commentMap: Map<u64, string>,
  mappedLines: Set<u64>,
  sourceIndex: u32,
  sourceLine: u32
): Array<u64> {
  const keys = new Array<u64>();

  // Check the source line itself
  const selfKey = commentKey(sourceIndex, sourceLine);
  if (commentMap.has(selfKey)) {
    keys.push(selfKey);
  }

  // Scan upward from sourceLine - 1
  let line = sourceLine;
  while (line > 1) {
    line--;
    const key = commentKey(sourceIndex, line);
    const isMapped = mappedLines.has(key);
    if (isMapped) {
      // Hit another mapped instruction's line — stop
      break;
    }
    if (commentMap.has(key)) {
      keys.push(key);
    } else {
      // No comment on this line — could be blank or code.
      // Keep scanning past gaps (blank lines between comments
      // and the instruction), but limit gap size to avoid
      // reaching unrelated comments far above.
      // Allow up to 2 consecutive non-comment lines as gaps
      // (e.g., blank line + function signature).
      const nextLine = line - 1;
      if (nextLine >= 1) {
        const nextKey = commentKey(sourceIndex, nextLine);
        if (commentMap.has(nextKey) && !mappedLines.has(nextKey)) {
          // There's a comment just above this gap — keep scanning
          continue;
        }
      }
      break;
    }
  }

  // Reverse to get top-down order
  if (keys.length > 1) {
    const reversed = new Array<u64>();
    for (let i: i32 = keys.length - 1; i >= 0; i--) {
      reversed.push(keys[i]);
    }
    return reversed;
  }
  return keys;
}

// Convert a source comment to a WAT comment.
// "// foo" → ";; foo"
// "/* foo */" → ";; foo"
function convertToWatComment(text: string): string {
  let s = text.trim();
  if (s.startsWith("//")) {
    return ";;" + s.substring(2);
  }
  if (s.startsWith("/*") && s.endsWith("*/")) {
    const inner = s.substring(2, s.length - 2).trim();
    return ";; " + inner;
  }
  return ";; " + s;
}

function getIndent(line: string): string {
  let i: i32 = 0;
  while (i < line.length) {
    const ch = line.charCodeAt(i);
    if (ch == 32 || ch == 9) { // space or tab
      i++;
    } else {
      break;
    }
  }
  return line.substring(0, i);
}

function splitLines(text: string): Array<string> {
  const lines = new Array<string>();
  let start: i32 = 0;
  for (let i: i32 = 0; i < text.length; i++) {
    if (text.charCodeAt(i) == 10) { // '\n'
      lines.push(text.substring(start, i));
      start = i + 1;
    }
  }
  if (start < text.length) {
    lines.push(text.substring(start));
  }
  return lines;
}

export function joinLines(lines: Array<string>): string {
  let result = "";
  for (let i: i32 = 0; i < lines.length; i++) {
    if (i > 0) result += "\n";
    result += lines[i];
  }
  return result;
}
