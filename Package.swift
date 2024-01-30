// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "WalletConnect",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "WalletConnect",
            targets: ["WalletConnectSign"]),
        .library(
            name: "WalletConnectChat",
            targets: ["WalletConnectChat"]),
        .library(
            name: "Web3Wallet",
            targets: ["Web3Wallet"]),
        .library(
            name: "WalletConnectPairing",
            targets: ["WalletConnectPairing"]),
        .library(
            name: "WalletConnectNotify",
            targets: ["WalletConnectNotify"]),
        .library(
            name: "WalletConnectPush",
            targets: ["WalletConnectPush"]),
        .library(
            name: "WalletConnectRouter",
            targets: ["WalletConnectRouter", "WalletConnectRouterLegacy"]),
        .library(
            name: "WalletConnectNetworking",
            targets: ["WalletConnectNetworking"]),
        .library(
            name: "WalletConnectSync",
            targets: ["WalletConnectSync"]),
        .library(
            name: "WalletConnectVerify",
            targets: ["WalletConnectVerify"]),
        .library(
            name: "WalletConnectModal",
            targets: ["WalletConnectModal"]),
        .library(
            name: "WalletConnectIdentity",
            targets: ["WalletConnectIdentity"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),
        .package(url: "https://github.com/WalletConnect/QRCode", from: "14.3.1")
    ],
    targets: [
        .target(
            name: "WalletConnectSign",
            dependencies: ["WalletConnectPairing", "WalletConnectVerify", "WalletConnectSigner"],
            path: "Sources/WalletConnectSign"),
        .target(
            name: "WalletConnectChat",
            dependencies: ["WalletConnectIdentity", "WalletConnectSync"],
            path: "Sources/Chat"),
        .target(
            name: "Web3Wallet",
            dependencies: ["WalletConnectSign", "WalletConnectPush", "WalletConnectVerify"],
            path: "Sources/Web3Wallet"),
        .target(
            name: "WalletConnectNotify",
            dependencies: ["WalletConnectPairing", "WalletConnectIdentity", "WalletConnectPush", "WalletConnectSigner", "Database"],
            path: "Sources/WalletConnectNotify"),
        .target(
            name: "WalletConnectPush",
            dependencies: ["WalletConnectNetworking", "WalletConnectJWT"],
            path: "Sources/WalletConnectPush"),
        .target(
            name: "WalletConnectRelay",
            dependencies: ["WalletConnectJWT"],
            path: "Sources/WalletConnectRelay",
            resources: [.copy("PackageConfig.json")]),
        .target(
            name: "WalletConnectKMS",
            dependencies: ["WalletConnectUtils"],
            path: "Sources/WalletConnectKMS"),
        .target(
            name: "WalletConnectPairing",
            dependencies: ["WalletConnectNetworking"]),
        .target(
            name: "WalletConnectSigner",
            dependencies: ["WalletConnectNetworking"]),
        .target(
            name: "WalletConnectJWT",
            dependencies: ["WalletConnectKMS"]),
        .target(
            name: "WalletConnectIdentity",
            dependencies: ["WalletConnectNetworking"]),
        .target(
            name: "WalletConnectUtils",
            dependencies: ["JSONRPC"]),
        .target(
            name: "JSONRPC",
            dependencies: ["Commons"]),
        .target(
            name: "Commons",
            dependencies: []),
        .target(
            name: "HTTPClient",
            dependencies: []),
        .target(
            name: "WalletConnectNetworking",
            dependencies: ["HTTPClient", "WalletConnectRelay"]),
        .target(
            name: "WalletConnectRouterLegacy",
            dependencies: [],
            path: "Sources/WalletConnectRouter/RouterLegacy"),
        .target(
            name: "WalletConnectRouter",
            dependencies: ["WalletConnectRouterLegacy"],
            path: "Sources/WalletConnectRouter/Router"),
        .target(
            name: "WalletConnectVerify",
            dependencies: ["WalletConnectUtils", "WalletConnectNetworking"]),
        .target(
            name: "Database",
            dependencies: ["WalletConnectUtils"]),
        .target(
            name: "WalletConnectModal",
            dependencies: ["QRCode", "WalletConnectSign"],
            exclude: ["Secrets/secrets.json.sample"],
            resources: [
                .copy("Secrets/secrets.json"),
                .copy("Resources/Assets.xcassets")
            ]
        ),
        .target(
            name: "WalletConnectSync",
            dependencies: ["WalletConnectSigner"]),
        .testTarget(
            name: "WalletConnectSignTests",
            dependencies: ["WalletConnectSign", "WalletConnectUtils", "TestingUtils", "WalletConnectVerify"]),
        .testTarget(
            name: "Web3WalletTests",
            dependencies: ["Web3Wallet", "TestingUtils"]),
        .testTarget(
            name: "WalletConnectPairingTests",
            dependencies: ["WalletConnectPairing", "TestingUtils"]),
        .testTarget(
            name: "ChatTests",
            dependencies: ["WalletConnectChat", "WalletConnectUtils", "TestingUtils"]),
        .testTarget(
            name: "NotifyTests",
            dependencies: ["WalletConnectNotify", "TestingUtils"]),
        .testTarget(
            name: "RelayerTests",
            dependencies: ["WalletConnectRelay", "WalletConnectUtils", "TestingUtils"]),
        .testTarget(
            name: "VerifyTests",
            dependencies: ["WalletConnectVerify", "TestingUtils", "WalletConnectSign"]),
        .testTarget(
            name: "WalletConnectKMSTests",
            dependencies: ["WalletConnectKMS", "WalletConnectUtils", "TestingUtils"]),
        .target(
            name: "TestingUtils",
            dependencies: ["WalletConnectPairing"],
            path: "Tests/TestingUtils"),
        .testTarget(
            name: "WalletConnectUtilsTests",
            dependencies: ["WalletConnectUtils", "TestingUtils"]),
        .testTarget(
            name: "JSONRPCTests",
            dependencies: ["JSONRPC", "TestingUtils"]),
        .testTarget(
            name: "CommonsTests",
            dependencies: ["Commons", "TestingUtils"]),
        .testTarget(
            name: "WalletConnectModalTests",
            dependencies: ["WalletConnectModal", "TestingUtils"])
    ],
    swiftLanguageVersions: [.v5]
)
