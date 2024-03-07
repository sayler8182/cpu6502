// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "nesCore",
    platforms: [.iOS(.v12), .macOS(.v12)],
    products: [
        .library(
            name: "nesCore",
            targets: ["nesCore"])
    ],
    dependencies: [
        .package(name: "cpu6502Core", path: "../cpu6502Core"),
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.54.0")
    ],
    targets: [
        .target(
            name: "nesCore",
            dependencies: ["cpu6502Core"],
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]),
        .testTarget(
            name: "nesCoreTests",
            dependencies: ["nesCore"])
    ]
)
