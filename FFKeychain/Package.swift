// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FFKeychain",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "FFKeychain",
            targets: ["FFKeychain"]
        ),
    ],
    dependencies: [
        .package(name: "FFDataSource", path: "../FFDataSource")
    ],
    targets: [
        .target(
            name: "FFKeychain", 
            dependencies: [
                .product(name: "FFDataSource", package: "FFDataSource"),
            ]
        ),
    ]
)
