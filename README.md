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

## Course exercises

The tag `baseline` marks the plain codebase. Every exercise of the course starts from it.

Exercise files live under `exercises/` on the `main` branch only. A branch created from
`baseline` contains the codebase and nothing else, which is what a baseline run needs.

| Exercise | Module | State |
|---|---|---|
| [01. Baseline versus configured](exercises/exercise-01/README.md) | 1. Agent Harness Foundations | Ready |
| [02. Prepare AgenticShop for agents](exercises/exercise-02/README.md) | 2. Building Agent-Ready Swift Repositories | Ready |
| [03. Two context strategies for one feature](exercises/exercise-03/README.md) | 3. Context Engineering for Swift Developers | Ready |

The exercises of modules 4 to 8 are not published yet.

The lessons are on [agenticswift.dev](https://agenticswift.dev).

## License

MIT, see [LICENSE](LICENSE). It applies to every revision of this repository, the `baseline`
tag included, whose own LICENSE file is an earlier placeholder.
