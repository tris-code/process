// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Process",
    products: [
        .library(name: "Process", targets: ["Process"]),
    ],
    dependencies: [
        .package(path: "../Platform"),
        .package(path: "../Time"),
        .package(path: "../Async"),
        .package(path: "../Fiber"),
        .package(path: "../AIO"),
        .package(path: "../Test")
    ],
    targets: [
        .target(
            name: "Process",
            dependencies: ["Platform", "Time", "Async", "AIO"]),
        .testTarget(
            name: "ProcessTests",
            dependencies: ["Process", "Test", "Fiber", "AIO"])
    ]
)
