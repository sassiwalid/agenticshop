# Scenario S1. Empty the cart

Add requirement CART-8 to `Documentation/Features/shopping-cart.md` and implement it.

| CART-8 | Emptying a cart removes every line and the discount, in one call, `Cart.removeAll()`. |

The method is `public mutating func removeAll()` on `Cart`, in `Packages/ShoppingCart`.
Add at least one test whose name starts with `cart8_`.

Change nothing outside `Packages/ShoppingCart` and `Documentation/Features/shopping-cart.md`.
Do not commit. Report the files you changed and how you verified the change.
