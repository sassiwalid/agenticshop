# Architecture overview

AgenticShop is one Swift package. Each feature is a library target under `Packages/`.

## Dependency rules

1. `DesignSystem` and `Networking` depend on no other module.
2. `Catalog` may depend on `Networking`.
3. A feature module may depend on `Catalog` and `DesignSystem`.
4. A feature module does not depend on another feature module. `Checkout` is the one exception.
   It reads the cart, so it depends on `ShoppingCart`.
5. Only `Networking` talks to the network. Feature modules receive an `HTTPClient`.

`Package.swift` is the source of truth for these rules. If this page and the manifest disagree,
the manifest is right and this page needs fixing.

## Conventions

- Amounts are `Money`, built on `Decimal`. No `Double` for prices.
- Public types are `Sendable`.
- Tests use Swift Testing.
