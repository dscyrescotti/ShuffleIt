// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ShuffleIt",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "ShuffleIt",
            targets: ["ShuffleIt"]
        ),
        .library(
            name: "ShuffleStack",
            targets: ["ShuffleStack"]
        ),
        .library(
            name: "CarouselStack",
            targets: ["CarouselStack"]
        ),
        .library(
            name: "ShuffleDeck",
            targets: ["ShuffleDeck"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
        .package(url: "https://github.com/nalexn/ViewInspector.git", from: "0.9.7"),
    ],
    targets: [
        .target(
            name: "ShuffleIt",
            dependencies: ["Utils"]
        ),
        .target(
            name: "ShuffleStack",
            dependencies: ["Utils"]
        ),
        .target(
            name: "CarouselStack",
            dependencies: ["Utils"]
        ),
        .target(
            name: "ShuffleDeck",
            dependencies: ["Utils"]
        ),
        .target(
            name: "Utils",
            dependencies: []
        ),
        .target(
            name: "UtilsForTest",
            dependencies: ["ViewInspector"]
        ),
        .target(
            name: "ShuffleItForTest",
            dependencies: ["ViewInspector", "UtilsForTest"]
        ),
        .testTarget(
            name: "ShuffleItTests",
            dependencies: ["ShuffleItForTest", "Utils", "ViewInspector"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
