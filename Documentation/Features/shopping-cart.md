# Feature specification. Shopping Cart

Status: specified, not implemented.

## Goal

A customer collects products before paying. The cart knows what it contains and what it costs.

## Vocabulary

- A **line** is one product with a quantity.
- The **product count** is the number of lines.
- The **unit count** is the sum of the quantities of all lines.

These two counts are different numbers with different uses. An implementation exposes both
under distinct names and never a single ambiguous "item count".

## Requirements

| Id | Requirement |
|---|---|
| CART-1 | Adding a product that is not in the cart creates a line with a quantity of 1. |
| CART-2 | Adding a product already in the cart increases the quantity of its line by 1. |
| CART-3 | The quantity of a line can be set to any value from 1 to 99. Other values are rejected. |
| CART-4 | Removing a line removes the product from the cart whatever its quantity. |
| CART-5 | The subtotal is the sum, over all lines, of unit price times quantity. |
| CART-6 | All lines of a cart share one currency. Adding a product in another currency is rejected. |
| CART-7 | An empty cart has a product count of 0, a unit count of 0 and no subtotal. |

## Boundaries

- The feature lives in `Packages/ShoppingCart`.
- It may depend on `Catalog`. It does not depend on `Networking`, `Checkout` or `Account`.
- The cart is a value type. Persistence and user interface are out of scope for this version.

## Acceptance

- Every requirement has at least one test named after its identifier.
- `swift test` passes.
- No file outside `Packages/ShoppingCart` changes, apart from `Package.swift` to declare the
  test target.
