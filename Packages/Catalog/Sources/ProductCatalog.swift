import Foundation
import Networking

/// Where the rest of the app gets its products from.
public protocol ProductCatalog: Sendable {
    func products() async throws -> [Product]
}

extension ProductCatalog {
    public func product(id: Product.ID) async throws -> Product? {
        try await products().first { $0.id == id }
    }
}

public struct InMemoryProductCatalog: ProductCatalog {
    private let stored: [Product]

    public init(products: [Product]) {
        self.stored = products
    }

    public func products() async throws -> [Product] { stored }
}

/// Loads the catalog from the backend through the Networking module.
public struct RemoteProductCatalog: ProductCatalog {
    private let client: any HTTPClient

    public init(client: any HTTPClient) {
        self.client = client
    }

    public func products() async throws -> [Product] {
        let response = try await client.send(HTTPRequest(path: "/products"))
        guard response.statusCode == 200 else {
            throw HTTPError.unexpectedStatus(response.statusCode)
        }
        return try JSONDecoder().decode([Product].self, from: response.body)
    }
}
