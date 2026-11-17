# Mission 001. Shopping Cart, first implementation

## Goal

Implement the Shopping Cart feature as a value type in the `ShoppingCart` module.

## Read first

- `Documentation/Features/shopping-cart.md`, the requirements CART-1 to CART-7 and the vocabulary.
- `Packages/Catalog/Sources/Money.swift` and `Product.swift`, the types the cart is built on.
- `Documentation/ADRs/`, the decisions already taken. Read the titles, open what applies.

## Scope

- `Packages/ShoppingCart/`, sources and a new `Tests/` folder.
- `Package.swift`, to declare the test target `ShoppingCartTests`. Nothing else in that file.

## Out of scope

- `Checkout`, persistence, any user interface.
- Any change to `Catalog`. If `Money` lacks something you need, compute inside the cart.

## Verify

`Scripts/verify.sh` exits with 0. Every requirement has at least one test whose name starts with
its identifier, as in `cart5_`.

## Stop and report, without making the change, if

- a file outside the scope must change
- the specification does not say what to do in a case you have to handle
- the same failure comes back twice

## Report

- the files you changed
- the last lines of `Scripts/verify.sh`
- each case where the specification was silent, and what you would decide
