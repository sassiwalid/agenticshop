# Feature specification. Percentage discount

Status: specified.

## Goal

A cart can carry a discount expressed as a percentage. The customer sees the subtotal before the
discount and the total after it.

## Vocabulary

- The **subtotal** is the sum of the lines, as defined by CART-5. The discount does not change it.
- The **discount** is a whole number of percent applied to the subtotal.
- The **total** is the subtotal minus the discount, rounded as DISC-5 says.

## Requirements

| Id | Requirement |
|---|---|
| DISC-1 | A cart carries at most one discount. Applying a second one replaces the first. |
| DISC-2 | A discount is a whole number from 1 to 50. Other values are rejected. |
| DISC-3 | The subtotal is the same with or without a discount. |
| DISC-4 | The total is the subtotal reduced by the discount. Without a discount, the total equals the subtotal. |
| DISC-5 | The total is rounded to two decimal places, halves rounded away from zero. |
| DISC-6 | Removing the discount brings the total back to the subtotal. |
| DISC-7 | An empty cart has no total, with or without a discount. |

## Boundaries

- The feature lives in `Packages/ShoppingCart`.
- It may depend on `Catalog`. It does not depend on `Networking`, `Checkout` or `Account`.
- Discount codes, their validation and their expiry are out of scope for this version.

## Acceptance

- Every requirement has at least one test named after its identifier.
- `Scripts/verify.sh` exits with 0.
- No file outside `Packages/ShoppingCart` changes.

DISC-5 settles the gap named in module 1. The rounding rule is a choice made for this course,
in the place where a product owner would make it.
