import { readUleb128, readSleb128 } from "./leb128";
import { DebugLineHeader } from "./header";

/** A single entry in the DWARF line number matrix. */
export class LineEntry {
  /** Code-section-relative byte offset. */
  address: u32 = 0;
  /** 1-based index into the file names table. */
  fileIndex: u32 = 0;
  /** Source line number (1-based). */
  line: u32 = 0;
  /** Source column (0 = unknown). */
  column: u32 = 0;
  /** Whether this is a recommended breakpoint location. */
  isStmt: bool = false;
  /** Whether this row marks the end of a sequence. */
  endSequence: bool = false;
}

// Standard opcode numbers
const DW_LNS_COPY: u8 = 1;
const DW_LNS_ADVANCE_PC: u8 = 2;
const DW_LNS_ADVANCE_LINE: u8 = 3;
const DW_LNS_SET_FILE: u8 = 4;
const DW_LNS_SET_COLUMN: u8 = 5;
const DW_LNS_NEGATE_STMT: u8 = 6;
const DW_LNS_SET_BASIC_BLOCK: u8 = 7;
const DW_LNS_CONST_ADD_PC: u8 = 8;
const DW_LNS_FIXED_ADVANCE_PC: u8 = 9;

// Extended opcode numbers
const DW_LNE_END_SEQUENCE: u8 = 1;
const DW_LNE_SET_ADDRESS: u8 = 2;
const DW_LNE_DEFINE_FILE: u8 = 3;

/**
 * Execute the DWARF line number program and produce the line number matrix.
 *
 * @param bytes      The byte array containing the program
 * @param offset     Start of the line number program
 * @param endOffset  End of the compilation unit (exclusive)
 * @param header     The parsed .debug_line header
 * @returns          Array of LineEntry rows in emission order
 */
export function executeLineNumberProgram(
  bytes: Uint8Array,
  offset: u32,
  endOffset: u32,
  header: DebugLineHeader
): Array<LineEntry> {
  const entries = new Array<LineEntry>();
  const view = new DataView(bytes.buffer, bytes.byteOffset, bytes.byteLength);

  // State machine registers
  let address: u32 = 0;
  let file: u32 = 1;
  let line: u32 = 1;
  let column: u32 = 0;
  let isStmt: bool = header.defaultIsStmt;
  let endSequence: bool = false;

  const opcodeBase = header.opcodeBase;
  const lineBase = <i32>header.lineBase;
  const lineRange = <u32>header.lineRange;
  const minInstrLen = <u32>header.minimumInstructionLength;

  while (offset < endOffset) {
    const opcode = bytes[offset];
    offset++;

    if (opcode === 0) {
      // Extended opcode
      const extLenResult = readUleb128(bytes, offset);
      offset = extLenResult.nextOffset;
      const extLen = extLenResult.value;
      const extEnd = offset + extLen;

      const extOpcode = bytes[offset];
      offset++;

      if (extOpcode === DW_LNE_END_SEQUENCE) {
        endSequence = true;
        emitRow(entries, address, file, line, column, isStmt, endSequence);
        // Reset state machine
        address = 0;
        file = 1;
        line = 1;
        column = 0;
        isStmt = header.defaultIsStmt;
        endSequence = false;
      } else if (extOpcode === DW_LNE_SET_ADDRESS) {
        address = view.getUint32(offset, true);
        offset += 4;
      } else if (extOpcode === DW_LNE_DEFINE_FILE) {
        // Read file name entry (same format as header file entries)
        // Rarely used; skip past it
        offset = extEnd;
      } else {
        // Unknown extended opcode — skip
        offset = extEnd;
      }
    } else if (opcode < opcodeBase) {
      // Standard opcode
      if (opcode === DW_LNS_COPY) {
        emitRow(entries, address, file, line, column, isStmt, endSequence);
      } else if (opcode === DW_LNS_ADVANCE_PC) {
        const operand = readUleb128(bytes, offset);
        offset = operand.nextOffset;
        address += operand.value * minInstrLen;
      } else if (opcode === DW_LNS_ADVANCE_LINE) {
        const operand = readSleb128(bytes, offset);
        offset = operand.nextOffset;
        line = <u32>(<i32>line + operand.value);
      } else if (opcode === DW_LNS_SET_FILE) {
        const operand = readUleb128(bytes, offset);
        offset = operand.nextOffset;
        file = operand.value;
      } else if (opcode === DW_LNS_SET_COLUMN) {
        const operand = readUleb128(bytes, offset);
        offset = operand.nextOffset;
        column = operand.value;
      } else if (opcode === DW_LNS_NEGATE_STMT) {
        isStmt = !isStmt;
      } else if (opcode === DW_LNS_SET_BASIC_BLOCK) {
        // No-op for our purposes
      } else if (opcode === DW_LNS_CONST_ADD_PC) {
        // Same as special opcode 255's address advance
        const adjustedOpcode = <u32>(255 - opcodeBase);
        address += (adjustedOpcode / lineRange) * minInstrLen;
      } else if (opcode === DW_LNS_FIXED_ADVANCE_PC) {
        address += <u32>view.getUint16(offset, true);
        offset += 2;
      } else {
        // Unknown standard opcode — skip its operands using the lengths table
        const numOperands = <u32>header.standardOpcodeLengths[opcode - 1];
        for (let i: u32 = 0; i < numOperands; i++) {
          const skip = readUleb128(bytes, offset);
          offset = skip.nextOffset;
        }
      }
    } else {
      // Special opcode
      const adjustedOpcode = <u32>(opcode - opcodeBase);
      address += (adjustedOpcode / lineRange) * minInstrLen;
      line = <u32>(<i32>line + lineBase + <i32>(adjustedOpcode % lineRange));
      emitRow(entries, address, file, line, column, isStmt, endSequence);
    }
  }

  return entries;
}

/** Push a new LineEntry row into the entries array. */
function emitRow(
  entries: Array<LineEntry>,
  address: u32,
  file: u32,
  line: u32,
  column: u32,
  isStmt: bool,
  endSequence: bool
): void {
  const entry = new LineEntry();
  entry.address = address;
  entry.fileIndex = file;
  entry.line = line;
  entry.column = column;
  entry.isStmt = isStmt;
  entry.endSequence = endSequence;
  entries.push(entry);
}
