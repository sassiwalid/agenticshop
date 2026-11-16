import Foundation
import Networking
import Testing
@testable import Catalog

private let mug = Product(id: "mug", name: "Enamel Mug", price: Money(amount: 14, currencyCode: "EUR"), tags: ["kitchen"])
private let poster = Product(id: "poster", name: "Swift Poster", price: Money(amount: 22, currencyCode: "EUR"), tags: ["office"])

@Test func findsAProductByIdentifier() async throws {
    let catalog = InMemoryProductCatalog(products: [mug, poster])
    #expect(try await catalog.product(id: "poster") == poster)
    #expect(try await catalog.product(id: "unknown") == nil)
}

@Test func decodesTheRemoteCatalog() async throws {
    let body = try JSONEncoder().encode([mug, poster])
    let client = StubHTTPClient(responses: ["/products": HTTPResponse(statusCode: 200, body: body)])
    #expect(try await RemoteProductCatalog(client: client).products() == [mug, poster])
}

@Test func surfacesAServerError() async {
    let client = StubHTTPClient(responses: ["/products": HTTPResponse(statusCode: 500, body: Data())])
    await #expect(throws: HTTPError.unexpectedStatus(500)) {
        try await RemoteProductCatalog(client: client).products()
    }
}
