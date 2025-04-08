// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InterPlayModels",
    products: [
        .library(name: "InterPlayModels", targets: ["InterPlayModels"]),
    ],
    targets: [
        .target(name: "InterPlayModels"),
        .testTarget(name: "InterPlayModelsTests", dependencies: ["InterPlayModels"]),
    ]
)
