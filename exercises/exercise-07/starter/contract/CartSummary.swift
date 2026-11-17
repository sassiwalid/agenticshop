import Catalog

/// The contract between ShoppingCart and Checkout.
///
/// Checkout never reads a `Cart`. It reads this summary, which ShoppingCart produces
/// with `Cart.summary`. Both missions build against this type. Neither mission changes it.
/// Changing it is a decision of its own, taken before either mission starts.
///
/// Specification: Documentation/Features/cart-summary.md
public struct CartSummary: Sendable, Equatable {
    /// The number of lines. The product count of CART-7.
    public let lineCount: Int
    /// The sum of the quantities of all lines.
    public let unitCount: Int
    /// The subtotal of CART-5.
    public let subtotal: Money
    /// The discount of DISC-1, `nil` when there is none.
    public let discountPercent: Int?
    /// The total of DISC-4, in the currency of the subtotal.
    public let total: Money

    public init(lineCount: Int, unitCount: Int, subtotal: Money, discountPercent: Int?, total: Money) {
        self.lineCount = lineCount
        self.unitCount = unitCount
        self.subtotal = subtotal
        self.discountPercent = discountPercent
        self.total = total
    }
}
