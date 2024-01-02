// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FFMVVM",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(name: "FFMVVM", targets: ["FFMVVM"]),
    ],
    targets: [
        .target(name: "FFMVVM"),
    ]
)
