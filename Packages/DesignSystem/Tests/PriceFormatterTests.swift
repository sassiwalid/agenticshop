import Foundation
import Testing
@testable import DesignSystem

@Test func formatsAnAmountInTheGivenLocale() {
    let formatter = PriceFormatter(locale: Locale(identifier: "en_US"))
    #expect(formatter.string(amount: Decimal(string: "12.5")!, currencyCode: "USD") == "$12.50")
}
