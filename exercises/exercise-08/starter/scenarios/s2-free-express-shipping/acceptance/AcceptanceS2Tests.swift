import Catalog
import Checkout
import Foundation
import ShoppingCart
import Testing

// Held-out acceptance tests for scenario S2. Copied in after the run. The agent never sees them.

private func summary(total: String) -> CartSummary {
    let amount = Money(amount: Decimal(string: total)!, currencyCode: "EUR")
    return CartSummary(lineCount: 1, unitCount: 1, subtotal: amount, discountPercent: nil, total: amount)
}

private func euros(_ text: String) -> Money {
    Money(amount: Decimal(string: text)!, currencyCode: "EUR")
}

@Test func accept_s2_expressBelowOneHundredCostsNineNinety() {
    #expect(OrderDraft(summary: summary(total: "99.99"), shipping: .express).shippingCost == euros("9.90"))
}

@Test func accept_s2_expressIsFreeFromOneHundred() {
    #expect(OrderDraft(summary: summary(total: "100"), shipping: .express).shippingCost == euros("0"))
    #expect(OrderDraft(summary: summary(total: "250"), shipping: .express).amountToPay == euros("250"))
}

@Test func accept_s2_standardShippingIsUnchanged() {
    #expect(OrderDraft(summary: summary(total: "49.99"), shipping: .standard).shippingCost == euros("4.90"))
    #expect(OrderDraft(summary: summary(total: "50"), shipping: .standard).shippingCost == euros("0"))
}
