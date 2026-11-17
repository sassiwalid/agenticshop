# Exercise 07. Shopping Cart with several agents

Module 7, Multi-Agent Development and Git Worktrees. About 60 minutes.

The lesson that goes with this exercise is on
[agenticswift.dev](https://agenticswift.dev/course/multi-agent-and-git-worktrees/exercise-shopping-cart-with-several-agents).
It holds the full instructions, part by part. Module 7 belongs to the paid part of the course,
so the lesson opens with a license key.

## What you do

You split the checkout of a cart into a contract and two missions, one in ShoppingCart and one in
Checkout. Two agents implement them at the same time, each in its own Git worktree. You merge the
branches in an order you can defend, and prove the result with a test that uses both modules.

## What you need

- Your branch `loop` from exercise 05, with the discount, the gate and its hooks.
- Two agent sessions at once, with Claude Code, Codex, or one of each.
- A Mac with Xcode and its command-line tools. The exercise was checked with Swift 6.4 and Git 2.54.

## Files

| File | Used for |
|---|---|
| [starter/contract/CartSummary.swift](starter/contract/CartSummary.swift) | The type both missions share, committed first |
| [starter/specs/cart-summary.md](starter/specs/cart-summary.md) | Requirements SUM-1 to SUM-3, for the ShoppingCart mission |
| [starter/specs/checkout-draft.md](starter/specs/checkout-draft.md) | Requirements CHK-1 to CHK-4, for the Checkout mission |
| [starter/missions/mission-template.md](starter/missions/mission-template.md) | The brief to fill in for each mission |
| [starter/CheckoutIntegrationTests.swift](starter/CheckoutIntegrationTests.swift) | The test that spans both modules, added after the merges |
| [starter/workflow-template.md](starter/workflow-template.md) | The workflow document you fill in |

These files exist on the `main` branch only. Copy them next to your clone.

    git fetch
    git archive origin/main:exercises/exercise-07/starter --prefix=exercise-07/ | tar -x -C ..

## Done when

- Each agent worked in its own worktree and branch.
- The contract was merged first, and the missions' scopes did not overlap.
- The merged result passes `Scripts/check.sh`, including the test that spans ShoppingCart and Checkout.
- The workflow document states the merge order and the reason for it.

## Reference solution

Released with the course solutions, kept out of this repository on purpose.
