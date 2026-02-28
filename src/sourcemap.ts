// Source Map v3 parser.
// Decodes VLQ-encoded mappings from WASM source maps.
// For WASM source maps, generated line is always 0 and generated column
// is the byte offset into the WASM binary.

export class SourceMapEntry {
  generatedOffset: u32 = 0;
  sourceIndex: u32 = 0;
  sourceLine: u32 = 0;
  sourceColumn: u32 = 0;
}

export class SourceMap {
  sources: Array<string> = new Array<string>();
  entries: Array<SourceMapEntry> = new Array<SourceMapEntry>();
}

// --- Base64 VLQ ---

const BASE64_CHARS: string = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

function base64Decode(ch: i32): i32 {
  if (ch >= 65 && ch <= 90) return ch - 65;       // A-Z
  if (ch >= 97 && ch <= 122) return ch - 97 + 26;  // a-z
  if (ch >= 48 && ch <= 57) return ch - 48 + 52;   // 0-9
  if (ch == 43) return 62;                          // +
  if (ch == 47) return 63;                          // /
  return -1;
}

class VLQResult {
  value: i32 = 0;
  index: i32 = 0;
}

function decodeVLQ(mappings: string, index: i32): VLQResult {
  let shift: i32 = 0;
  let result: i32 = 0;
  let i = index;

  while (i < mappings.length) {
    const digit = base64Decode(mappings.charCodeAt(i));
    i++;
    const continuation = digit & 32;
    result |= (digit & 31) << shift;
    shift += 5;
    if (!continuation) break;
  }

  // Sign is in LSB
  const negate = result & 1;
  result >>= 1;
  if (negate) result = -result;

  const out = new VLQResult();
  out.value = result;
  out.index = i;
  return out;
}

// --- Minimal JSON field extraction ---

function extractJsonStringField(json: string, field: string): string {
  const key = "\"" + field + "\"";
  let pos = json.indexOf(key);
  if (pos < 0) return "";
  pos += key.length;

  // Skip whitespace and colon
  while (pos < json.length) {
    const ch = json.charCodeAt(pos);
    if (ch == 58 || ch == 32 || ch == 9 || ch == 10 || ch == 13) { // ':', ' ', '\t', '\n', '\r'
      pos++;
    } else {
      break;
    }
  }

  if (pos >= json.length || json.charCodeAt(pos) != 34) return ""; // expect '"'
  pos++; // skip opening quote

  let end = pos;
  while (end < json.length && json.charCodeAt(end) != 34) {
    if (json.charCodeAt(end) == 92) { // backslash escape
      end += 2;
    } else {
      end++;
    }
  }

  return json.substring(pos, end);
}

function extractJsonStringArray(json: string, field: string): Array<string> {
  const result = new Array<string>();
  const key = "\"" + field + "\"";
  let pos = json.indexOf(key);
  if (pos < 0) return result;
  pos += key.length;

  // Skip to '['
  while (pos < json.length && json.charCodeAt(pos) != 91) pos++; // '['
  if (pos >= json.length) return result;
  pos++; // skip '['

  while (pos < json.length) {
    // Skip whitespace and commas
    const ch = json.charCodeAt(pos);
    if (ch == 32 || ch == 9 || ch == 10 || ch == 13 || ch == 44) { // ' ', '\t', '\n', '\r', ','
      pos++;
      continue;
    }
    if (ch == 93) break; // ']'

    if (ch == 34) { // '"'
      pos++; // skip opening quote
      let end = pos;
      while (end < json.length && json.charCodeAt(end) != 34) {
        if (json.charCodeAt(end) == 92) {
          end += 2;
        } else {
          end++;
        }
      }
      result.push(json.substring(pos, end));
      pos = end + 1; // skip closing quote
    } else {
      pos++;
    }
  }

  return result;
}

// --- Main parser ---

function parseMappingsComparator(a: SourceMapEntry, b: SourceMapEntry): i32 {
  return <i32>a.generatedOffset - <i32>b.generatedOffset;
}

export function parseSourceMap(json: string): SourceMap {
  const sourceMap = new SourceMap();
  sourceMap.sources = extractJsonStringArray(json, "sources");

  const mappings = extractJsonStringField(json, "mappings");
  if (mappings.length == 0) return sourceMap;

  // State: all values are delta-encoded
  let genColumn: i32 = 0;
  let srcIndex: i32 = 0;
  let srcLine: i32 = 0;
  let srcColumn: i32 = 0;

  let i: i32 = 0;
  while (i < mappings.length) {
    const ch = mappings.charCodeAt(i);

    if (ch == 59) { // ';' — next generated line (not used for WASM source maps)
      i++;
      genColumn = 0;
      continue;
    }

    if (ch == 44) { // ',' — next segment
      i++;
      continue;
    }

    // Decode a segment: 1, 4, or 5 VLQ values
    const vlq1 = decodeVLQ(mappings, i);
    genColumn += vlq1.value;
    i = vlq1.index;

    if (i >= mappings.length || mappings.charCodeAt(i) == 44 || mappings.charCodeAt(i) == 59) {
      // 1-value segment — generated column only, no source mapping
      continue;
    }

    const vlq2 = decodeVLQ(mappings, i);
    srcIndex += vlq2.value;
    i = vlq2.index;

    const vlq3 = decodeVLQ(mappings, i);
    srcLine += vlq3.value;
    i = vlq3.index;

    const vlq4 = decodeVLQ(mappings, i);
    srcColumn += vlq4.value;
    i = vlq4.index;

    // Optional 5th value (name index) — skip if present
    if (i < mappings.length && mappings.charCodeAt(i) != 44 && mappings.charCodeAt(i) != 59) {
      const vlq5 = decodeVLQ(mappings, i);
      i = vlq5.index;
    }

    const entry = new SourceMapEntry();
    entry.generatedOffset = <u32>genColumn;
    entry.sourceIndex = <u32>srcIndex;
    entry.sourceLine = <u32>srcLine;
    entry.sourceColumn = <u32>srcColumn;
    sourceMap.entries.push(entry);
  }

  sourceMap.entries.sort(parseMappingsComparator);
  return sourceMap;
}

// Binary search: find the source map entry for a given WASM byte offset.
// Returns the entry with the largest generatedOffset <= the given offset,
// or null if no entry matches.
export function lookupOffset(entries: Array<SourceMapEntry>, offset: u32): SourceMapEntry | null {
  if (entries.length == 0) return null;

  let lo: i32 = 0;
  let hi: i32 = entries.length - 1;

  // If offset is before the first entry, no match
  if (offset < entries[0].generatedOffset) return null;

  while (lo < hi) {
    const mid = lo + ((hi - lo + 1) >> 1);
    if (entries[mid].generatedOffset <= offset) {
      lo = mid;
    } else {
      hi = mid - 1;
    }
  }

  return entries[lo];
}
