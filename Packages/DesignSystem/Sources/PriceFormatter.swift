import Foundation

/// Formats an amount for display. DesignSystem knows nothing about products,
/// so it takes a plain amount and a currency code.
public struct PriceFormatter: Sendable {
    public let locale: Locale

    public init(locale: Locale = .current) {
        self.locale = locale
    }

    public func string(amount: Decimal, currencyCode: String) -> String {
        amount.formatted(.currency(code: currencyCode).locale(locale))
    }
}
