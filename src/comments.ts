// Comment extractor: parses AssemblyScript source and extracts comments
// with their line numbers.

export class SourceComment {
  line: u32 = 0;
  text: string = "";
}

export function extractComments(source: string): Array<SourceComment> {
  const comments = new Array<SourceComment>();
  let i: i32 = 0;
  let line: u32 = 1;
  const len: i32 = source.length;

  while (i < len) {
    const ch = source.charCodeAt(i);

    // Track line numbers
    if (ch == 10) { // '\n'
      line++;
      i++;
      continue;
    }

    // Skip string literals to avoid false matches
    if (ch == 34 || ch == 39 || ch == 96) { // '"', "'", '`'
      i = skipStringLiteral(source, i, len);
      continue;
    }

    // Check for comments
    if (ch == 47 && i + 1 < len) { // '/'
      const next = source.charCodeAt(i + 1);

      if (next == 47) { // '//' single-line comment
        const start = i;
        i += 2;
        while (i < len && source.charCodeAt(i) != 10) {
          i++;
        }
        const comment = new SourceComment();
        comment.line = line;
        comment.text = source.substring(start, i);
        comments.push(comment);
        continue;
      }

      if (next == 42) { // '/*' multi-line comment
        const startLine = line;
        const start = i;
        i += 2;
        while (i + 1 < len) {
          if (source.charCodeAt(i) == 10) {
            line++;
          }
          if (source.charCodeAt(i) == 42 && source.charCodeAt(i + 1) == 47) {
            i += 2;
            break;
          }
          i++;
        }
        const comment = new SourceComment();
        comment.line = startLine;
        comment.text = source.substring(start, i);
        comments.push(comment);
        continue;
      }
    }

    i++;
  }

  return comments;
}

function skipStringLiteral(source: string, start: i32, len: i32): i32 {
  const quote = source.charCodeAt(start);
  let i = start + 1;
  while (i < len) {
    const ch = source.charCodeAt(i);
    if (ch == 92) { // '\\' escape
      i += 2;
      continue;
    }
    if (ch == quote) {
      return i + 1;
    }
    if (ch == 10 && quote != 96) { // newline ends non-template strings
      return i;
    }
    i++;
  }
  return i;
}
