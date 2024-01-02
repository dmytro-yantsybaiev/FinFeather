// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FFDomain",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(name: "FFDomain",targets: ["FFDomain"]),
    ],
    dependencies: [
        .package(name: "FFDataSource", path: "../FFDataSource"),
    ],
    targets: [
        .target(
            name: "FFDomain",
            dependencies: [
                .product(name: "FFDataSource", package: "FFDataSource"),
            ]
        ),
        .testTarget(name: "FFDomainTests", dependencies: ["FFDomain"]),
    ]
)
