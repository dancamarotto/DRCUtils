// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "DRCUtils",
    platforms: [.iOS("13.0"), .macOS("10.15")],
    products: [
        .library(name: "DRCUtils", targets: ["DRCUtils"]),
    ],
    targets: [
        .target(
            name: "DRCUtils",
            path: "DRCUtils/Source"),
        .testTarget(
            name: "DRCUtilsTests",
            dependencies: ["DRCUtils"],
            path: "DRCUtils/Tests"),
    ]
)
