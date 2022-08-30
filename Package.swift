// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ShuffleIt",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "ShuffleIt",
            targets: ["ShuffleStack"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ShuffleStack",
            dependencies: [],
            path: "Sources/ShuffleStack"
        ),
        .testTarget(
            name: "ShuffleItTests",
            dependencies: ["ShuffleStack"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
