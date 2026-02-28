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

        // Check for comment on this source line or the line before
        const key = findCommentKey(commentMap, srcIndex, sourceLine);
        if (key > 0 && !emittedComments.has(key)) {
          emittedComments.add(key);
          const commentText = commentMap.get(key);
          const watComment = convertToWatComment(commentText);
          const indent = getIndent(line);
          output.push(indent + watComment);
        }
      }
    }

    output.push(line);
  }

  return joinLines(output);
}

// Find a comment on the given source line or the line immediately before it.
// Returns the comment key, or 0 if none found.
function findCommentKey(commentMap: Map<u64, string>, sourceIndex: u32, sourceLine: u32): u64 {
  const key1 = commentKey(sourceIndex, sourceLine);
  if (commentMap.has(key1)) return key1;
  if (sourceLine > 1) {
    const key2 = commentKey(sourceIndex, sourceLine - 1);
    if (commentMap.has(key2)) return key2;
  }
  return 0;
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
