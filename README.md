###### This is an implementation of [Base16 aka Hex](https://en.wikipedia.org/wiki/Base16) `encode`/`decode` algorithm.

#### Example:

```swift
import Base16

/// Encoding to Base16
/// 1. convert string to bytes (utf8 format)
let bytes = "Hello, World!".makeBytes()
/// 2. encode bytes using base16 algorithm, by default the encoded bytes will be lowercased
let encodedBytes = Base16.encode(bytes, uppercased: true)
/// 3. converting bytes back to string
let encodedString = try String(encoded) // "48656C6C6F2C20576F726C6421"


/// Decoding from Base16
/// 1. convert string to bytes (utf8 format)
let bytes = "48656C6C6F2C20576F726C6421".makeBytes()
/// 2. decode bytes using base16 algorithm
let decodedBytes = try Base16.decode(bytes)
/// 3. converting bytes back to string
let decodedString = try String(encoded) // "Hello, World!"
```

#### Importing Base16:

To include `Base16` in your project, you need to add the following to the `dependencies` attribute defined in your `Package.swift` file.
```swift
dependencies: [
  .package(url: "https://github.com/alja7dali/swift-base16.git", from: "1.0.0")
]
```