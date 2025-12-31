// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "CoreLayout",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "CoreLayout",
            targets: ["CoreLayout"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CoreLayout",
            dependencies: ["YogaLayout"],
            path: "Sources/CoreLayout"
        ),
        .target(
            name: "YogaLayout",
            path: "Sources/YogaLayout",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include"),
                .define("YOGA_EXPORT=")
            ]
        ),
        .testTarget(
            name: "CoreLayoutTests",
            dependencies: ["CoreLayout"],
            path: "Tests/CoreLayoutTests"
        )
    ]
)
