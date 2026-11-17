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
| [04. SwiftProjectAnalyzer over MCP](exercises/exercise-04/README.md) | 4. Extending Agents with Tools, Skills and MCP | Ready |
| [05. A self-correcting Shopping Cart workflow](exercises/exercise-05/README.md) | 5. Feedback Loops and Automated Validation | Ready |
| [06. Secure an agent environment](exercises/exercise-06/README.md) | 6. Agent Governance and Security | Ready |
| [07. Shopping Cart with several agents](exercises/exercise-07/README.md) | 7. Multi-Agent Development and Git Worktrees | Ready |
| [08. Evaluate harness configurations](exercises/exercise-08/README.md) | 8. Evaluation and Production Readiness | Ready |

Exercises 04, 05 and 06 start from the branch of exercise 03. Exercise 07 starts from the
branch of exercise 05, and exercise 08 from the branch of exercise 07.

The lessons are on [agenticswift.dev](https://agenticswift.dev).

## License

MIT, see [LICENSE](LICENSE). It applies to every revision of this repository, the `baseline`
tag included, whose own LICENSE file is an earlier placeholder.
