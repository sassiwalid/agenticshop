# AgenticShop

A small modular e-commerce codebase used through the course
Advanced Agent Harness Engineering for Swift Developers.

The baseline is deliberately plain. It has no agent instruction file and little documentation.
Making it ready for agents is the subject of module 2.

## Modules

| Module | Depends on | State in the baseline |
|---|---|---|
| DesignSystem | nothing | Spacing, price formatting, one button style |
| Networking | nothing | An HTTP client protocol and a stub |
| Catalog | Networking | Products, an in-memory catalog and a remote one |
| ShoppingCart | Catalog | Specified, not implemented |
| Checkout | Catalog, ShoppingCart | Declared, empty |
| Account | nothing | A customer type |

## Build and test

    swift build
    swift test
