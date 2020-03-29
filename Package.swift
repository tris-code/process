// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Process",
    products: [
        .library(name: "Process", targets: ["Process"]),
    ],
    dependencies: [
        .package(path: "../platform"),
        .package(path: "../time"),
        .package(path: "../async"),
        .package(path: "../fiber"),
        .package(path: "../aio"),
        .package(path: "../test")
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
