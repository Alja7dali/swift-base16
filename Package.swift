// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "Base16",
  products: [
    .library(name: "Base16", targets: ["Base16"]),
  ],
  dependencies: [
    .package(url: "https://github.com/alja7dali/swift-bits", from: "1.0.0"),
  ],
  targets: [
    .target(name: "Base16", dependencies: ["Bits"]),
    .testTarget(name: "Base16Tests", dependencies: ["Base16"]),
  ]
)
