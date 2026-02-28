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

  // Approach C: collect file-level comments per source file.
  // Find the minimum mapped source line for each source index,
  // then gather all comments with line numbers below that minimum.
  const fileLevelComments = collectFileLevelComments(
    commentMap, lineToOffset, sourceEntries
  );
  const headerInjected = new Set<u32>();

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

        // Inject file-level comments before the first instruction from this file
        if (!headerInjected.has(srcIndex) && fileLevelComments.has(srcIndex)) {
          headerInjected.add(srcIndex);
          const fileComments = fileLevelComments.get(srcIndex);
          for (let fc: i32 = 0; fc < fileComments.length; fc++) {
            const fkey = fileComments[fc];
            if (!emittedComments.has(fkey)) {
              emittedComments.add(fkey);
              const commentText = commentMap.get(fkey);
              const watComment = convertToWatComment(commentText);
              const indent = getIndent(line);
              output.push(indent + watComment);
            }
          }
        }

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

// Collect file-level comments for each source file.
// A file-level comment is any comment with a line number below the
// minimum mapped source line for that file — i.e., comments that
// appear before any code that generates WASM instructions.
// Returns a map from sourceIndex to sorted array of comment keys.
function collectFileLevelComments(
  commentMap: Map<u64, string>,
  lineToOffset: Map<u32, u32>,
  sourceEntries: Array<SourceMapEntry>
): Map<u32, Array<u64>> {
  // Find the minimum mapped source line per source index
  const minMappedLine = new Map<u32, u32>();
  const watLineKeys = lineToOffset.keys();
  for (let j: i32 = 0; j < watLineKeys.length; j++) {
    const byteOffset = lineToOffset.get(watLineKeys[j]);
    const entry = lookupOffset(sourceEntries, byteOffset);
    if (entry !== null) {
      const e = entry as SourceMapEntry;
      const srcLine = e.sourceLine + 1; // 1-indexed
      if (!minMappedLine.has(e.sourceIndex)) {
        minMappedLine.set(e.sourceIndex, srcLine);
      } else {
        const cur = minMappedLine.get(e.sourceIndex);
        if (srcLine < cur) {
          minMappedLine.set(e.sourceIndex, srcLine);
        }
      }
    }
  }

  // Gather comments below the minimum mapped line for each file
  const result = new Map<u32, Array<u64>>();
  const commentKeys = commentMap.keys();
  for (let j: i32 = 0; j < commentKeys.length; j++) {
    const key = commentKeys[j];
    const srcIndex = <u32>(key >> 32);
    const line = <u32>(key & 0xFFFFFFFF);
    const minLine = minMappedLine.has(srcIndex) ? minMappedLine.get(srcIndex) : <u32>0;
    if (minMappedLine.has(srcIndex) && line < minLine) {
      if (!result.has(srcIndex)) {
        result.set(srcIndex, new Array<u64>());
      }
      result.get(srcIndex).push(key);
    }
  }

  // Sort each file's comments by line number (ascending)
  const srcIndices = result.keys();
  for (let j: i32 = 0; j < srcIndices.length; j++) {
    result.get(srcIndices[j]).sort(compareCommentKeys);
  }

  return result;
}

function compareCommentKeys(a: u64, b: u64): i32 {
  if (a < b) return -1;
  if (a > b) return 1;
  return 0;
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
