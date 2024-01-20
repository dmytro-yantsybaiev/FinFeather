// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UseCaseItem",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(name: "UseCaseItem", targets: ["UseCaseItem"]),
        .library(name: "UseCaseItemLive", targets: ["UseCaseItemLive"])
    ],
    dependencies: [
        .package(name: "FFDataSource", path: "../FFDataSource"),
        .package(url: "https://github.com/dmytro-yantsybaiev/swift-composable-repositories.git", .upToNextMinor(from: Version("0.1.1"))),
        .package(url: "https://github.com/dmytro-yantsybaiev/swift-composable-use-case.git", .upToNextMinor(from: Version("0.1.0"))),
    ],
    targets: [
        .target(
            name: "UseCaseItem",
            dependencies: [
                "FFDataSource",
            ]
        ),
        .target(
            name: "UseCaseItemLive",
            dependencies: [
                "UseCaseItem",
                "FFDataSource",
                .product(name: "ComposableRepositories", package: "swift-composable-repositories"),
                .product(name: "ComposableUseCase", package: "swift-composable-use-case"),
            ]
        )
    ]
)
