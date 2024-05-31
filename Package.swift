// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SelectableMarkdownUI",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SelectableMarkdownUI",
            targets: ["SelectableMarkdownUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/johnxnguyen/Down.git", branch: "master"),
        .package(url: "https://github.com/appstefan/highlightswift.git", exact: "1.0.7"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SelectableMarkdownUI",dependencies: [
                .product(name: "HighlightSwift", package: "highlightswift"),
                .product(name: "Down", package: "down")
            ]),
        .testTarget(
            name: "SelectableMarkdownUITests",
            dependencies: ["SelectableMarkdownUI"]),
    ]
)
