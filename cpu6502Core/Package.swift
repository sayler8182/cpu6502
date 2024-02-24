// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "cpu6502Core",
    products: [
        .library(
            name: "cpu6502Core",
            targets: ["cpu6502Core"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.54.0")
    ],
    targets: [
        .target(
            name: "cpu6502Core",
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]),
        .testTarget(
            name: "cpu6502CoreTests",
            dependencies: ["cpu6502Core"]),
    ]
)
