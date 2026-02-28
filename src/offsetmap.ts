// Offset map parser: reads the JSON output of wasm2wat --offset-map.
// Format: { "version": 1, "mappings": [{ "watLine": N, "offset": M }, ...] }

export class OffsetMapEntry {
  watLine: u32 = 0;
  offset: u32 = 0;
}

export function parseOffsetMap(json: string): Array<OffsetMapEntry> {
  const entries = new Array<OffsetMapEntry>();

  // Find the "mappings" array
  const key = "\"mappings\"";
  let pos = json.indexOf(key);
  if (pos < 0) return entries;
  pos += key.length;

  // Skip to '['
  while (pos < json.length && json.charCodeAt(pos) != 91) pos++; // '['
  if (pos >= json.length) return entries;
  pos++; // skip '['

  // Parse each { "watLine": N, "offset": M } object
  while (pos < json.length) {
    const ch = json.charCodeAt(pos);
    if (ch == 93) break; // ']'

    if (ch == 123) { // '{'
      pos++; // skip '{'
      const entry = new OffsetMapEntry();
      let foundWatLine = false;
      let foundOffset = false;

      while (pos < json.length && json.charCodeAt(pos) != 125) { // '}'
        // Look for "watLine" or "offset" keys
        if (json.charCodeAt(pos) == 34) { // '"'
          pos++; // skip opening quote
          let keyEnd = pos;
          while (keyEnd < json.length && json.charCodeAt(keyEnd) != 34) keyEnd++;
          const fieldName = json.substring(pos, keyEnd);
          pos = keyEnd + 1; // skip closing quote

          // Skip to ':'
          while (pos < json.length && json.charCodeAt(pos) != 58) pos++;
          pos++; // skip ':'

          // Skip whitespace
          while (pos < json.length) {
            const wch = json.charCodeAt(pos);
            if (wch == 32 || wch == 9 || wch == 10 || wch == 13) {
              pos++;
            } else {
              break;
            }
          }

          // Parse integer value
          const numResult = parseInteger(json, pos);
          pos = numResult.index;

          if (fieldName == "watLine") {
            entry.watLine = <u32>numResult.value;
            foundWatLine = true;
          } else if (fieldName == "offset") {
            entry.offset = <u32>numResult.value;
            foundOffset = true;
          }
        } else {
          pos++;
        }
      }

      if (pos < json.length) pos++; // skip '}'

      if (foundWatLine && foundOffset) {
        entries.push(entry);
      }
    } else {
      pos++;
    }
  }

  return entries;
}

class ParseIntResult {
  value: i32 = 0;
  index: i32 = 0;
}

function parseInteger(s: string, start: i32): ParseIntResult {
  let i = start;
  let negative = false;
  if (i < s.length && s.charCodeAt(i) == 45) { // '-'
    negative = true;
    i++;
  }
  let value: i32 = 0;
  while (i < s.length) {
    const ch = s.charCodeAt(i);
    if (ch >= 48 && ch <= 57) { // '0'-'9'
      value = value * 10 + (ch - 48);
      i++;
    } else {
      break;
    }
  }
  const result = new ParseIntResult();
  result.value = negative ? -value : value;
  result.index = i;
  return result;
}

// Build a map from WAT line number to WASM byte offset for fast lookup.
// Returns a Map<u32, u32> where key is watLine and value is offset.
export function buildLineToOffsetMap(entries: Array<OffsetMapEntry>): Map<u32, u32> {
  const map = new Map<u32, u32>();
  for (let i: i32 = 0; i < entries.length; i++) {
    map.set(entries[i].watLine, entries[i].offset);
  }
  return map;
}
