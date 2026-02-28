import { readUleb128 } from "./leb128";

/** Result of reading a null-terminated UTF-8 string from a byte buffer. */
class StringReadResult {
  value: string = "";
  nextOffset: u32 = 0;
}

/** Parsed .debug_line section header for one compilation unit. */
export class DebugLineHeader {
  unitLength: u32 = 0;
  version: u16 = 0;
  headerLength: u32 = 0;
  minimumInstructionLength: u8 = 0;
  defaultIsStmt: bool = false;
  lineBase: i8 = 0;
  lineRange: u8 = 0;
  opcodeBase: u8 = 0;
  standardOpcodeLengths: Uint8Array = new Uint8Array(0);
  includeDirectories: Array<string> = new Array<string>();
  /** 1-indexed; fileNames[0] is a placeholder empty string. */
  fileNames: Array<string> = new Array<string>();
  /** Byte offset where the line number program begins. */
  programOffset: u32 = 0;
  /** Byte offset where this compilation unit ends. */
  unitEndOffset: u32 = 0;
}

/**
 * Read a null-terminated UTF-8 string from bytes starting at offset.
 * Returns the decoded string and the offset after the null terminator.
 */
function readNullTerminatedString(bytes: Uint8Array, offset: u32): StringReadResult {
  const start = offset;
  while (offset < <u32>bytes.length && bytes[offset] !== 0) {
    offset++;
  }
  const len = offset - start;
  const result = new StringReadResult();

  if (len === 0) {
    result.value = "";
  } else {
    const ptr = changetype<usize>(bytes.buffer) + <usize>bytes.byteOffset + <usize>start;
    result.value = String.UTF8.decodeUnsafe(ptr, len, false);
  }

  // Skip past the null terminator
  result.nextOffset = offset + 1;
  return result;
}

/**
 * Parse a .debug_line header from the given bytes at the specified offset.
 *
 * @param bytes   The raw bytes of the .debug_line section (or the full WASM binary
 *                if offset points into it)
 * @param offset  Byte offset where the compilation unit header starts
 * @returns       Parsed header, or null if the format is unsupported
 */
export function parseHeader(bytes: Uint8Array, offset: u32): DebugLineHeader | null {
  const view = new DataView(bytes.buffer, bytes.byteOffset, bytes.byteLength);

  const header = new DebugLineHeader();

  // unit_length (4 bytes, little-endian)
  header.unitLength = view.getUint32(offset, true);
  offset += 4;
  header.unitEndOffset = offset + header.unitLength;

  // version (2 bytes)
  header.version = view.getUint16(offset, true);
  offset += 2;
  if (header.version !== 4) return null; // Only DWARF v4 supported

  // header_length (4 bytes)
  header.headerLength = view.getUint32(offset, true);
  offset += 4;
  header.programOffset = offset + header.headerLength;

  // minimum_instruction_length (1 byte)
  header.minimumInstructionLength = bytes[offset];
  offset++;

  // maximum_ops_per_instruction (1 byte, DWARF 4+, always 1 for WASM — skip)
  offset++;

  // default_is_stmt (1 byte)
  header.defaultIsStmt = bytes[offset] !== 0;
  offset++;

  // line_base (1 byte, signed)
  header.lineBase = <i8>bytes[offset];
  offset++;

  // line_range (1 byte)
  header.lineRange = bytes[offset];
  offset++;

  // opcode_base (1 byte)
  header.opcodeBase = bytes[offset];
  offset++;

  // standard_opcode_lengths (opcode_base - 1 bytes)
  const numStdOpcodes = <u32>(header.opcodeBase - 1);
  header.standardOpcodeLengths = new Uint8Array(numStdOpcodes);
  for (let i: u32 = 0; i < numStdOpcodes; i++) {
    header.standardOpcodeLengths[i] = bytes[offset + i];
  }
  offset += numStdOpcodes;

  // include_directories: sequence of null-terminated strings, terminated by empty string
  header.includeDirectories = new Array<string>();
  while (offset < <u32>bytes.length && bytes[offset] !== 0) {
    const strResult = readNullTerminatedString(bytes, offset);
    header.includeDirectories.push(strResult.value);
    offset = strResult.nextOffset;
  }
  offset++; // Skip the terminating null byte

  // file_names: sequence of file entries, terminated by a null byte
  // Index 0 is a placeholder (unused) to keep 1-based indexing
  header.fileNames = new Array<string>();
  header.fileNames.push(""); // placeholder at index 0

  while (offset < <u32>bytes.length && bytes[offset] !== 0) {
    // Read file name (null-terminated string)
    const nameResult = readNullTerminatedString(bytes, offset);
    offset = nameResult.nextOffset;

    // Read directory_index (uleb128, ignored)
    const dirResult = readUleb128(bytes, offset);
    offset = dirResult.nextOffset;

    // Read modification_time (uleb128, ignored)
    const timeResult = readUleb128(bytes, offset);
    offset = timeResult.nextOffset;

    // Read file_length (uleb128, ignored)
    const lenResult = readUleb128(bytes, offset);
    offset = lenResult.nextOffset;

    header.fileNames.push(nameResult.value);
  }
  offset++; // Skip the terminating null byte

  return header;
}
