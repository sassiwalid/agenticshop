// swift-tools-version: 6.0
import PackageDescription

// AgenticShop is one Swift package with one library per feature module.
// Dependencies point one way: features depend on Catalog, Catalog on Networking.
// DesignSystem depends on nothing and no feature depends on another feature,
// except Checkout, which reads the cart.
let package = Package(
    name: "AgenticShop",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "DesignSystem", targets: ["DesignSystem"]),
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "Catalog", targets: ["Catalog"]),
        .library(name: "ShoppingCart", targets: ["ShoppingCart"]),
        .library(name: "Checkout", targets: ["Checkout"]),
        .library(name: "Account", targets: ["Account"]),
    ],
    targets: [
        .target(name: "DesignSystem", path: "Packages/DesignSystem/Sources"),
        .target(name: "Networking", path: "Packages/Networking/Sources"),
        .target(name: "Catalog", dependencies: ["Networking"], path: "Packages/Catalog/Sources"),
        .target(name: "ShoppingCart", dependencies: ["Catalog"], path: "Packages/ShoppingCart/Sources"),
        .target(name: "Checkout", dependencies: ["Catalog", "ShoppingCart"], path: "Packages/Checkout/Sources"),
        .target(name: "Account", path: "Packages/Account/Sources"),

        .testTarget(name: "DesignSystemTests", dependencies: ["DesignSystem"], path: "Packages/DesignSystem/Tests"),
        .testTarget(name: "NetworkingTests", dependencies: ["Networking"], path: "Packages/Networking/Tests"),
        .testTarget(name: "CatalogTests", dependencies: ["Catalog"], path: "Packages/Catalog/Tests"),
    ]
)
