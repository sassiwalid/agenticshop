import Catalog
import Foundation
import Testing

// Held-out acceptance tests for scenario S3. Copied in after the run. The agent never sees them.

private let mug = Product(id: "mug", name: "Enamel Mug", price: Money(amount: 14, currencyCode: "EUR"), tags: ["kitchen", "gift"])
private let poster = Product(id: "poster", name: "Swift Poster", price: Money(amount: 22, currencyCode: "EUR"), tags: ["office", "Gift"])
private let apron = Product(id: "apron", name: "Apron", price: Money(amount: 25, currencyCode: "EUR"), tags: ["kitchen"])

@Test func accept_s3_returnsTheProductsWithTheTagSortedByName() async throws {
    let catalog = InMemoryProductCatalog(products: [mug, poster, apron])
    #expect(try await catalog.products(taggedWith: "kitchen").map(\.id) == ["apron", "mug"])
}

@Test func accept_s3_ignoresLetterCase() async throws {
    let catalog = InMemoryProductCatalog(products: [mug, poster, apron])
    #expect(try await catalog.products(taggedWith: "GIFT").map(\.id) == ["mug", "poster"])
}

@Test func accept_s3_anUnknownTagGivesNothing() async throws {
    let catalog = InMemoryProductCatalog(products: [mug, poster, apron])
    #expect(try await catalog.products(taggedWith: "garden").isEmpty)
}
