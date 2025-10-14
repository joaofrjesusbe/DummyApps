// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AppDomains",
    defaultLocalization: "en",
    platforms: [
        .iOS("17.0"),
        .macOS("14.0")
    ],
    products: [
        .library(
            name: "AppList",
            targets: ["AppList"]
        ),
        .library(
            name: "AppMain",
            targets: ["AppMain"]
        )
    ],
    dependencies: [
        // Reference AppGroup within AppSDK via correct relative path
        .package(path: "../AppSDK/AppGroup"),
    ],
    targets: [
        .target(
            name: "AppMain",
            dependencies: [
                "AppGroup",
                "AppList"
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .target(
            name: "AppList",
            dependencies: [
                "AppGroup",
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "AppListTests",
            dependencies: ["AppList"]
        ),
    ]
)
