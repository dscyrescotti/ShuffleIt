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
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
        .package(url: "https://github.com/dscyrescotti/ViewInspector.git", branch: "master"),
    ],
    targets: [
        .target(
            name: "ShuffleIt",
            dependencies: []
        ),
        .target(
            name: "ShuffleItForTest",
            dependencies: ["ViewInspector"]
        ),
        .testTarget(
            name: "ShuffleItTests",
            dependencies: ["ShuffleItForTest", "ViewInspector"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
