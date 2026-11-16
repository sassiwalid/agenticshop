import Foundation

/// An amount in one currency. Amounts are decimal, never floating point.
public struct Money: Sendable, Equatable, Codable {
    public var amount: Decimal
    public var currencyCode: String

    public init(amount: Decimal, currencyCode: String) {
        self.amount = amount
        self.currencyCode = currencyCode
    }
}
