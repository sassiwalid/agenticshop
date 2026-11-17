import Catalog
import Foundation
import Testing
@testable import ShoppingCart

// Exercise 05. The tests of the percentage discount, written before the code.
// They use the names of the reference cart, Cart, add, setQuantity, subtotal.
// If your cart uses other names, rename the calls. Never change an expectation.

private let mug = Product(id: "mug", name: "Enamel Mug", price: Money(amount: 14, currencyCode: "EUR"))
private let sticker = Product(id: "sticker", name: "Sticker", price: Money(amount: Decimal(string: "0.30")!, currencyCode: "EUR"))

private func euros(_ text: String) -> Money {
    Money(amount: Decimal(string: text)!, currencyCode: "EUR")
}

@Test func disc1_aSecondDiscountReplacesTheFirst() throws {
    var cart = Cart()
    try cart.add(mug)
    try cart.applyDiscount(percent: 10)
    try cart.applyDiscount(percent: 20)
    #expect(cart.discountPercent == 20)
    #expect(cart.total == euros("11.20"))
}

@Test(arguments: [1, 50]) func disc2_aDiscountFromOneToFiftyIsAccepted(percent: Int) throws {
    var cart = Cart()
    try cart.add(mug)
    try cart.applyDiscount(percent: percent)
    #expect(cart.discountPercent == percent)
}

@Test(arguments: [0, 51, -5]) func disc2_otherDiscountsAreRejected(percent: Int) throws {
    var cart = Cart()
    try cart.add(mug)
    try cart.applyDiscount(percent: 10)
    #expect(throws: CartError.discountOutOfRange(percent)) { try cart.applyDiscount(percent: percent) }
    #expect(cart.discountPercent == 10)
}

@Test func disc3_theSubtotalIgnoresTheDiscount() throws {
    var cart = Cart()
    try cart.add(mug)
    try cart.setQuantity(2, for: mug.id)
    try cart.applyDiscount(percent: 25)
    #expect(cart.subtotal == euros("28"))
}

@Test func disc4_theTotalIsTheSubtotalReducedByTheDiscount() throws {
    var cart = Cart()
    try cart.add(mug)
    #expect(cart.total == euros("14"))
    try cart.applyDiscount(percent: 15)
    #expect(cart.total == euros("11.90"))
}

@Test func disc5_theTotalIsRoundedToCentsHalvesAwayFromZero() throws {
    var cart = Cart()
    try cart.add(sticker)
    try cart.applyDiscount(percent: 15)
    // 0.30 less 15 percent is 0.255, which rounds to 0.26.
    #expect(cart.total == euros("0.26"))
}

@Test func disc6_removingTheDiscountRestoresTheSubtotal() throws {
    var cart = Cart()
    try cart.add(mug)
    try cart.applyDiscount(percent: 30)
    cart.removeDiscount()
    #expect(cart.discountPercent == nil)
    #expect(cart.total == cart.subtotal)
}

@Test func disc7_anEmptyCartHasNoTotal() throws {
    var cart = Cart()
    #expect(cart.total == nil)
    try cart.applyDiscount(percent: 10)
    #expect(cart.total == nil)
}
