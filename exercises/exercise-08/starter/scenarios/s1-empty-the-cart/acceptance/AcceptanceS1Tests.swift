import Catalog
import Foundation
import Testing
import ShoppingCart

// Held-out acceptance tests for scenario S1. Copied in after the run. The agent never sees them.

private let mug = Product(id: "mug", name: "Enamel Mug", price: Money(amount: 14, currencyCode: "EUR"))
private let cap = Product(id: "cap", name: "Cap", price: Money(amount: 19, currencyCode: "USD"))

@Test func accept_s1_emptyingRemovesEveryLine() throws {
    var cart = Cart()
    try cart.add(mug)
    try cart.setQuantity(3, for: mug.id)
    cart.removeAll()
    #expect(cart.productCount == 0)
    #expect(cart.unitCount == 0)
    #expect(cart.subtotal == nil)
}

@Test func accept_s1_emptyingRemovesTheDiscount() throws {
    var cart = Cart()
    try cart.add(mug)
    try cart.applyDiscount(percent: 20)
    cart.removeAll()
    #expect(cart.discountPercent == nil)
}

@Test func accept_s1_anEmptiedCartAcceptsAnotherCurrency() throws {
    var cart = Cart()
    try cart.add(mug)
    cart.removeAll()
    try cart.add(cap)
    #expect(cart.subtotal == Money(amount: 19, currencyCode: "USD"))
}
