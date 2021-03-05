/// Encodes and Decodes bytes using the 
/// Base16 algorithm
///
/// https://en.wikipedia.org/wiki/Base16

/// Maps binary format to hex encoding
private let Base16EncodingTable: [Byte: Byte] = [
   0: .zero,  1: .one,   2: .two, 3: .three,
   4: .four,  5: .five,  6: .six, 7: .seven,
   8: .eight, 9: .nine, 10: .a,  11: .b,
  12: .c,    13: .d,    14: .e,  15: .f
]

private let encode: (Byte) -> Byte = {
  Base16EncodingTable[$0] ?? .max
}

/// Maps hex encoding to binary format
/// - note: Supports upper and lowercase
private let Base16DecodingTable: [Byte: Byte] = [
   .zero: 0,  .one: 1, .two: 2, .three: 3,
   .four: 4, .five: 5, .six: 6, .seven: 7,
  .eight: 8, .nine: 9,   .a: 10,    .b: 11,
      .c: 12,   .d: 13,  .e: 14,    .f: 15,
      .A: 10,   .B: 11,  .C: 12,    .D: 13,
      .E: 14,   .F: 15
]

private let decode: (Byte) -> Byte = {
  Base16DecodingTable[$0] ?? .max
}

/// Encodes bytes into Base16 format
public func encode(_ bytes: Bytes) -> Bytes {

  var result: Bytes = []

  for byte in bytes {
    // move the top half of the byte down
    // 0x12345678 becomes 0x00001234
    let upper = byte >> 4

    // zero out the top half of the byte
    // 0x12345678 becomes 0x00005678
    let lower = byte & 0xF

    // encode the 4-bit numbers
    // using the 0-f encoding (2^4=16)
    result.append(encode(upper))
    result.append(encode(lower))
  }

  return result
}

public func encode(_ bytes: Bytes, uppercased: Bool) -> Bytes {
  guard uppercased else {
    return encode(bytes)
  }

  var result: Bytes = []

  for byte in bytes {
    // move the top half of the byte down
    // 0x12345678 becomes 0x00001234
    let upper = byte >> 4

    // zero out the top half of the byte
    // 0x12345678 becomes 0x00005678
    let lower = byte & 0xF

    // encode the 4-bit numbers
    // using the 0-f encoding (2^4=16)
    result.append(toUppercase(encode(upper)))
    result.append(toUppercase(encode(lower)))
  }

  return result
}

public enum Base16DecodingError: Error {
  case oddLength
  case invalidByte(Byte)
}

/// Decodes Base16 encoded bytes into 
/// binary format
public func decode(
  _ bytes: Bytes,
  ignoreUndecodableCharacters: Bool = true
) throws -> Bytes {

  guard bytes.count % 2 == 0 else {
    throw Base16DecodingError.oddLength
  }

  var result: Bytes = []

  // create an iterator to easily 
  // fetch two at a time
  var itr = bytes.makeIterator()

  // take bytes two at a time
  while let c1 = itr.next(), let c2 = itr.next() {
    // decode the first character from
    // letter representation to 4-bit number
    // e.g, "1" becomes 0x00000001
    let upper = decode(c1)
    guard upper != .max || ignoreUndecodableCharacters else {
      throw Base16DecodingError.invalidByte(c1)
    }

    // decode the second character from
    // letter representation to a 4-bit number
    let lower = decode(c2)
    guard lower != .max || ignoreUndecodableCharacters else {
      throw Base16DecodingError.invalidByte(c2)
    }

    // combine the two 4-bit numbers back
    // into the original byte, shifting
    // the first back up to its 8-bit position
    //
    // 0x00001234 << 4 | 0x00005678 
    // becomes:
    // 0x12345678
    let byte = upper << 4 | lower

    result.append(byte)
  }

  return result
}