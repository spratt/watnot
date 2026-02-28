import { findCustomSection } from "./dwarf/section";
import { parseHeader } from "./dwarf/header";
import { executeLineNumberProgram, LineEntry } from "./dwarf/program";

export { LineEntry } from "./dwarf/program";

/** Comparator for sorting LineEntry by address ascending. */
function compareByAddress(a: LineEntry, b: LineEntry): i32 {
  if (a.address < b.address) return -1;
  if (a.address > b.address) return 1;
  return 0;
}

/** The parsed result of a .debug_line section. */
export class DebugLineInfo {
  /** Ordered list of source file names, 1-indexed (index 0 is unused). */
  fileNames: Array<string> = new Array<string>();

  /** The line number matrix, sorted by address ascending. */
  entries: Array<LineEntry> = new Array<LineEntry>();

  /**
   * Given a Code-section-relative byte offset, return the LineEntry
   * whose address is the largest address <= the given offset.
   * Returns null if no entry is found.
   */
  lookup(offset: u32): LineEntry | null {
    const entries = this.entries;
    if (entries.length === 0) return null;

    let lo: i32 = 0;
    let hi: i32 = entries.length - 1;
    let result: LineEntry | null = null;

    while (lo <= hi) {
      const mid = lo + ((hi - lo) >> 1);
      if (entries[mid].address <= offset) {
        result = entries[mid];
        lo = mid + 1;
      } else {
        hi = mid - 1;
      }
    }

    return result;
  }
}

/**
 * Parse the .debug_line custom section from a WASM binary.
 *
 * @param wasmBytes  The full WASM binary as a byte array
 * @returns          Parsed DebugLineInfo, or null if no .debug_line section found
 */
export function parseDebugLine(wasmBytes: Uint8Array): DebugLineInfo | null {
  const section = findCustomSection(wasmBytes, ".debug_line");
  if (section === null) return null;

  const allEntries = new Array<LineEntry>();
  const allFileNames = new Array<string>();
  allFileNames.push(""); // placeholder at index 0

  let offset = section.contentOffset;
  const endOffset = section.contentOffset + section.contentLength;

  // Handle multiple compilation units
  while (offset < endOffset) {
    const header = parseHeader(wasmBytes, offset);
    if (header === null) return null;

    const entries = executeLineNumberProgram(
      wasmBytes,
      header.programOffset,
      header.unitEndOffset,
      header
    );

    // Merge file names, adjusting fileIndex in entries
    const fileIndexOffset = <u32>(allFileNames.length - 1); // -1 because both have placeholder at 0
    for (let i = 1; i < header.fileNames.length; i++) {
      allFileNames.push(header.fileNames[i]);
    }

    // Adjust fileIndex values if this is not the first compilation unit
    if (fileIndexOffset > 0) {
      for (let i = 0; i < entries.length; i++) {
        entries[i].fileIndex += fileIndexOffset;
      }
    }

    for (let i = 0; i < entries.length; i++) {
      allEntries.push(entries[i]);
    }

    offset = header.unitEndOffset;
  }

  allEntries.sort(compareByAddress);

  const info = new DebugLineInfo();
  info.fileNames = allFileNames;
  info.entries = allEntries;
  return info;
}
