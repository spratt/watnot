// Comment injector: combines offset map + source map + comments
// to produce annotated WAT output.

import { SourceComment } from "./comments";
import { SourceMapEntry, lookupOffset } from "./sourcemap";

// Inject source comments into WAT text.
// lineToOffset: Map from WAT line number → WASM byte offset
// sourceEntries: sorted source map entries (byte offset → source location)
// comments: extracted source comments with line numbers
export function injectComments(
  watText: string,
  lineToOffset: Map<u32, u32>,
  sourceEntries: Array<SourceMapEntry>,
  comments: Array<SourceComment>
): string {
  // Build comment lookup: source line → comment text
  const commentMap = new Map<u32, string>();
  for (let i: i32 = 0; i < comments.length; i++) {
    commentMap.set(comments[i].line, comments[i].text);
  }

  const watLines = splitLines(watText);
  const output = new Array<string>();
  const emittedComments = new Set<u32>();

  for (let i: i32 = 0; i < watLines.length; i++) {
    const watLine = <u32>(i + 1); // 1-based
    const line = watLines[i];

    if (lineToOffset.has(watLine)) {
      const byteOffset = lineToOffset.get(watLine);
      const entry = lookupOffset(sourceEntries, byteOffset);

      if (entry !== null) {
        const sourceLine = (entry as SourceMapEntry).sourceLine + 1; // source map lines are 0-indexed

        // Check for comment on this source line or the line before
        const commentLine = findCommentLine(commentMap, sourceLine);
        if (commentLine > 0 && !emittedComments.has(commentLine)) {
          emittedComments.add(commentLine);
          const commentText = commentMap.get(commentLine);
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
// Returns the line number of the comment, or 0 if none found.
function findCommentLine(commentMap: Map<u32, string>, sourceLine: u32): u32 {
  if (commentMap.has(sourceLine)) return sourceLine;
  if (sourceLine > 1 && commentMap.has(sourceLine - 1)) return sourceLine - 1;
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
