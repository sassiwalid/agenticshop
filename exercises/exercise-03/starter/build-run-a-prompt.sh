#!/bin/sh
# Prints the prompt of run A. The mission of run B, with the content of every file
# it points at pasted below it. Run it from the root of the repository.
set -e
cat <<'BRIEF'
# Mission 001. Shopping Cart, first implementation

## Goal

Implement the Shopping Cart feature as a value type in the `ShoppingCart` module.

## Context

Everything you need is pasted below this brief. You do not need to read these files again.

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
BRIEF
for f in Documentation/Features/shopping-cart.md \
         Packages/Catalog/Sources/Money.swift \
         Packages/Catalog/Sources/Product.swift \
         Packages/Catalog/Sources/ProductCatalog.swift \
         Package.swift \
         Documentation/Architecture/overview.md \
         Documentation/ADRs/*.md; do
  printf '\n--- %s\n\n' "$f"
  cat "$f"
done
