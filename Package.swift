
// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "ColorWheel",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "ColorWheel",
            targets: ["ColorWheel"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ColorWheel",
            dependencies: []),
    ])
