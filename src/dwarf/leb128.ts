/** Result of decoding an unsigned LEB128 integer. */
export class Uleb128Result {
  value: u32 = 0;
  nextOffset: u32 = 0;
}

/** Result of decoding a signed LEB128 integer. */
export class Sleb128Result {
  value: i32 = 0;
  nextOffset: u32 = 0;
}

/**
 * Read an unsigned LEB128 integer from bytes at the given offset.
 * Returns the decoded value and the offset after the last byte consumed.
 */
export function readUleb128(bytes: Uint8Array, offset: u32): Uleb128Result {
  let result: u32 = 0;
  let shift: u32 = 0;
  let byte: u8;

  do {
    byte = bytes[offset];
    offset++;
    result |= (<u32>(byte & 0x7f)) << shift;
    shift += 7;
  } while ((byte & 0x80) !== 0 && shift < 35);

  const r = new Uleb128Result();
  r.value = result;
  r.nextOffset = offset;
  return r;
}

/**
 * Read a signed LEB128 integer from bytes at the given offset.
 * Returns the decoded value and the offset after the last byte consumed.
 */
export function readSleb128(bytes: Uint8Array, offset: u32): Sleb128Result {
  let result: i32 = 0;
  let shift: u32 = 0;
  let byte: u8;

  do {
    byte = bytes[offset];
    offset++;
    result |= (<i32>(byte & 0x7f)) << shift;
    shift += 7;
  } while ((byte & 0x80) !== 0 && shift < 35);

  // Sign-extend if the last byte had bit 6 set
  if (shift < 32 && (byte & 0x40) !== 0) {
    result |= ~0 << shift;
  }

  const r = new Sleb128Result();
  r.value = result;
  r.nextOffset = offset;
  return r;
}
