// swift-tools-version: 6.0
import PackageDescription

// Read-only developer tools for AgenticShop.
// ProjectAnalysis reads what Swift Package Manager knows about a package.
// shop-analyzer prints it for a person, shop-mcp serves it to an agent.
let package = Package(
    name: "AgenticShopTools",
    platforms: [.macOS(.v14)],
    targets: [
        .target(name: "ProjectAnalysis"),
        .executableTarget(name: "shop-analyzer", dependencies: ["ProjectAnalysis"]),
        .executableTarget(name: "shop-mcp", dependencies: ["ProjectAnalysis"]),
        .testTarget(name: "ProjectAnalysisTests", dependencies: ["ProjectAnalysis"]),
    ]
)
