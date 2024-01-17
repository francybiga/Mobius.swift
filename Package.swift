// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "Mobius",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_13),
        .tvOS(.v12),
        .watchOS(.v4),
    ],
    products: [
        .library(name: "MobiusCore", targets: ["MobiusCore"]),
        .library(name: "MobiusExtras", targets: ["MobiusExtras"]),
        .library(name: "MobiusNimble", targets: ["MobiusNimble"]),
        .library(name: "MobiusTest", targets: ["MobiusTest"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-case-paths", .upToNextMinor(from: "1.2.1")),
        .package(url: "https://github.com/Quick/Nimble", from: "10.0.0"),
        .package(url: "https://github.com/Quick/Quick", from: "5.0.1"),
    ],
    targets: [
        .target(name: "MobiusCore", dependencies: [.product(name: "CasePaths", package: "swift-case-paths")], path: "MobiusCore/Source", swiftSettings: [
            .enableExperimentalFeature("StrictConcurrency"),
        ]),
        .target(name: "MobiusExtras", dependencies: ["MobiusCore"], path: "MobiusExtras/Source", swiftSettings: [
            .enableExperimentalFeature("StrictConcurrency"),
        ]),
        .target(name: "MobiusNimble", dependencies: ["MobiusCore", "MobiusTest", "Nimble"], path: "MobiusNimble/Source"),
        .target(name: "MobiusTest", dependencies: ["MobiusCore"], path: "MobiusTest/Source"),
        .target(name: "MobiusThrowableAssertion", path: "MobiusThrowableAssertion/Source"),

        .testTarget(
            name: "MobiusCoreTests",
            dependencies: ["MobiusCore", "Nimble", "Quick", "MobiusThrowableAssertion"],
            path: "MobiusCore/Test"
        ),
        .testTarget(
            name: "MobiusExtrasTests",
            dependencies: ["MobiusCore", "MobiusExtras", "Nimble", "Quick", "MobiusThrowableAssertion"],
            path: "MobiusExtras/Test"
        ),
        .testTarget(name: "MobiusNimbleTests", dependencies: ["MobiusNimble", "Quick"], path: "MobiusNimble/Test"),
        .testTarget(name: "MobiusTestTests", dependencies: ["MobiusTest", "Quick", "Nimble"], path: "MobiusTest/Test"),
    ],
    swiftLanguageVersions: [.v5]
)
