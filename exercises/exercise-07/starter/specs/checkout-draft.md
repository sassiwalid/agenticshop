# Feature specification. Order draft

Status: specified.

## Goal

Before paying, the customer sees what the order will cost, shipping included. Checkout computes
it from the cart summary alone.

## Vocabulary

- An **order draft** is the amount to pay for a cart summary with a shipping option.
- A **shipping option** is standard or express.

## Requirements

| Id | Requirement |
|---|---|
| CHK-1 | An order draft is made from a `CartSummary` and a shipping option. It keeps the summary it was made from. |
| CHK-2 | Standard shipping costs 4.90 in the summary's currency. It is free when the summary's total is 50 or more. |
| CHK-3 | Express shipping costs 9.90 in the summary's currency, whatever the total. |
| CHK-4 | The amount to pay is the summary's total plus the shipping cost. |

## Boundaries

- The feature lives in `Packages/Checkout`.
- It reads `CartSummary` from ShoppingCart. It does not use `Cart`.
- Nothing outside `Packages/Checkout` changes.

## Acceptance

- Every requirement has at least one test named after its identifier.
- `swift test --filter CheckoutTests` passes.
