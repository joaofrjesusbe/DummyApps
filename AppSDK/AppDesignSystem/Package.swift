// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AppDesignSystem",
    platforms: [
        .iOS("17.0"),
        .macOS("14.0")
    ],
    products: [
        .library(
            name: "AppDesignSystem",
            targets: ["AppDesignSystem"]
        ),
    ],
    dependencies: [
        .package(path: "../AppCore"),
        .package(path: "../AppNetwork"),
    ],
    targets: [
        .target(
            name: "AppDesignSystem",
            dependencies: [
                "AppCore",
                "AppNetwork"
            ]
        )
    ]
)
