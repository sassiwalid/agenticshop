# AgenticShop

A Swift package with one library target per feature, under `Packages/`.

## Commands

- Build: `swift build`
- Test: `swift test`

## Rules

- Dependency rules are in `Documentation/Architecture/overview.md`. Do not add a dependency between modules.
- Amounts use `Money`. Public types are `Sendable`. Tests use Swift Testing.
- Stay inside the scope of your task. If the task needs a change outside it, stop and report.
- A task is done when `swift test` passes and every requirement has a test named after its identifier.
