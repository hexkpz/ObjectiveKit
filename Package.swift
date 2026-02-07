// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ObjectiveKit",
    products: [
        .library(name: "ObjectiveKit", targets: ["ObjectiveKit"]),
        .library(name: "_ObjectiveKit", targets: ["_ObjectiveKit"]),
    ],
    targets: [
        .target(
            name: "ObjectiveKit",
            path: "Sources/ObjectiveKit"
        ),
        .target(
            name: "_ObjectiveKit",
            dependencies: ["ObjectiveKit"],
            path: "Sources/_ObjectiveKit"
        ),
    ]
)
