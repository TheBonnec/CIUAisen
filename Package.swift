// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CIUAisen",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CIUAisen",
            targets: ["CIUAisen"]),
    ],
    dependencies: [
        .package(url: "https://github.com/grdleo/LaTeXSwiftUI", from: "1.3.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CIUAisen",
            dependencies: [
                "LaTeXSwiftUI"
            ],
            path: "Sources",
            resources: [
                .process("Media.xcassets")
            ]),
        .testTarget(
            name: "CIUAisenTests",
            dependencies: ["CIUAisen"]),
    ]
)
