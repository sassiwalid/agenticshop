# Feature specification. Cart summary

Status: specified.

## Goal

The cart can describe itself to another module without exposing its lines. Checkout reads the
summary and never the cart.

## Vocabulary

- The **summary** is a `CartSummary`, the type declared in `Packages/ShoppingCart/Sources/CartSummary.swift`.

## Requirements

| Id | Requirement |
|---|---|
| SUM-1 | A cart with at least one line has a summary, reached through `Cart.summary`, whose line count, unit count, subtotal, discount and total are those of the cart. |
| SUM-2 | An empty cart has no summary. |
| SUM-3 | Applying, replacing or removing a discount changes the summary's discount and total, and leaves its subtotal unchanged. |

## Boundaries

- The feature lives in `Packages/ShoppingCart`.
- `CartSummary.swift` is the contract and does not change in this mission.
- Nothing outside `Packages/ShoppingCart` changes.

## Acceptance

- Every requirement has at least one test named after its identifier.
- `swift test --filter ShoppingCartTests` passes.
