import { readUleb128 } from "./leb128";

/** Result of locating a custom section within a WASM binary. */
export class CustomSectionResult {
  /** Byte offset within wasmBytes where the section content begins (after the name). */
  contentOffset: u32 = 0;
  /** Length of the section content in bytes (after the name). */
  contentLength: u32 = 0;
}

// WASM magic bytes: \0asm
const WASM_MAGIC_0: u8 = 0x00;
const WASM_MAGIC_1: u8 = 0x61; // 'a'
const WASM_MAGIC_2: u8 = 0x73; // 's'
const WASM_MAGIC_3: u8 = 0x6d; // 'm'

/**
 * Find a custom section by name in a WASM binary.
 *
 * @param wasmBytes  The full WASM binary
 * @param name       The custom section name to search for (e.g. ".debug_line")
 * @returns          The content offset and length, or null if not found
 */
export function findCustomSection(
  wasmBytes: Uint8Array,
  name: string
): CustomSectionResult | null {
  if (wasmBytes.length < 8) return null;

  // Validate WASM magic
  if (
    wasmBytes[0] !== WASM_MAGIC_0 ||
    wasmBytes[1] !== WASM_MAGIC_1 ||
    wasmBytes[2] !== WASM_MAGIC_2 ||
    wasmBytes[3] !== WASM_MAGIC_3
  ) {
    return null;
  }

  // Encode the target name to UTF-8 bytes for comparison
  const nameBuffer = String.UTF8.encode(name, false);
  const nameBytes = Uint8Array.wrap(nameBuffer);

  let offset: u32 = 8; // Skip magic + version

  while (offset < <u32>wasmBytes.length) {
    const sectionId = wasmBytes[offset];
    offset++;

    const sizeResult = readUleb128(wasmBytes, offset);
    offset = sizeResult.nextOffset;
    const sectionSize = sizeResult.value;
    const sectionEnd = offset + sectionSize;

    if (sectionId === 0) {
      // Custom section: read the name length and name bytes
      const nameLenResult = readUleb128(wasmBytes, offset);
      offset = nameLenResult.nextOffset;
      const nameLen = nameLenResult.value;

      if (nameLen === <u32>nameBytes.length) {
        let match = true;
        for (let i: u32 = 0; i < nameLen; i++) {
          if (wasmBytes[offset + i] !== nameBytes[i]) {
            match = false;
            break;
          }
        }

        if (match) {
          const contentOffset = offset + nameLen;
          const result = new CustomSectionResult();
          result.contentOffset = contentOffset;
          result.contentLength = sectionEnd - contentOffset;
          return result;
        }
      }
    }

    offset = sectionEnd;
  }

  return null;
}
