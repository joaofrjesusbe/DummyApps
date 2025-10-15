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
            name: "AppForm",
            targets: ["AppForm"]
        )
    ],
    dependencies: [
        // Reference AppGroup within AppSDK via correct relative path
        .package(path: "../AppSDK/AppGroup"),
    ],
    targets: [
        .target(
            name: "AppForm",
            dependencies: [
                
            ],
        ),
        .target(
            name: "AppList",
            dependencies: [
                "AppGroup",
            ],
        ),
        .testTarget(
            name: "AppListTests",
            dependencies: ["AppList"]
        ),
        .testTarget(
            name: "AppFormTests",
            dependencies: ["AppForm"]
        ),
    ]
)
