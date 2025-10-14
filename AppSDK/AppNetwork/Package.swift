// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AppNetwork",
    platforms: [
        .iOS("17.0"),
        .macOS("14.0")
    ],
    products: [
        .library(
            name: "AppNetwork",
            targets: ["AppNetwork"]
        ),
    ],
    dependencies: [
        .package(path: "../AppCore"),
        .package(url: "https://github.com/kean/Nuke.git", from: "12.8.0")
    ],
    targets: [
        .target(
            name: "AppNetwork",
            dependencies: [
                "AppCore",
                "Nuke"
            ],
            resources: [
                .copy("Resources/Records")
            ],
        ),
        .testTarget(
            name: "AppNetworkTests",
            dependencies: ["AppNetwork"]
        ),
    ]
)
