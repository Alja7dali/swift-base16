import XCTest
@testable import Base16

final class Base16Tests: XCTestCase {
  func testEncodingToBase16() {
    do {
      let bytes = "Hello, World!".makeBytes()
      let encoded = Base16.encode(bytes, uppercased: true)
      let str = try String(encoded)
      XCTAssertEqual(str, "48656C6C6F2C20576F726C6421")
    } catch {
      XCTFail()
    }
  }

  func testDecodingToBase16() {
    do {
      let bytes = "48656C6C6F2C20576F726C6421".makeBytes()
      let decoded = try Base16.decode(bytes, ignoreUndecodableCharacters: false)
      let str = try String(decoded)
      XCTAssertEqual(str, "Hello, World!")
    } catch {
      XCTFail()
    }
  }

  static var allTests = [
    ("testEncodingToBase16", testEncodingToBase16),
    ("testDecodingToBase16", testDecodingToBase16),
  ]
}