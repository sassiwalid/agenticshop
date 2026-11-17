import Catalog
import Checkout
import Foundation
import ShoppingCart
import Testing

// Exercise 07. The test that spans two modules. It goes in Packages/Checkout/Tests after
// both missions are merged. It builds a real cart, takes its summary, and drafts an order,
// so it fails if the two missions understood the contract differently.

private let mug = Product(id: "mug", name: "Enamel Mug", price: Money(amount: 14, currencyCode: "EUR"))
private let poster = Product(id: "poster", name: "Swift Poster", price: Money(amount: 22, currencyCode: "EUR"))

private func euros(_ text: String) -> Money {
    Money(amount: Decimal(string: text)!, currencyCode: "EUR")
}

@Test func integration_aDiscountedCartBelowFiftyPaysStandardShipping() throws {
    var cart = Cart()
    try cart.add(mug)
    try cart.add(poster)
    try cart.applyDiscount(percent: 10)
    let summary = try #require(cart.summary)
    let draft = OrderDraft(summary: summary, shipping: .standard)
    // 36 less 10 percent is 32.40, plus 4.90 of shipping.
    #expect(draft.amountToPay == euros("37.30"))
}

@Test func integration_aCartAtFiftyAfterTheDiscountShipsFree() throws {
    var cart = Cart()
    try cart.add(mug)
    try cart.setQuantity(4, for: mug.id)
    let summary = try #require(cart.summary)
    // 4 times 14 is 56, at or above 50.
    #expect(OrderDraft(summary: summary, shipping: .standard).amountToPay == euros("56"))
}

@Test func integration_anEmptyCartCannotBeDrafted() {
    #expect(Cart().summary == nil)
}
