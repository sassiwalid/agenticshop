import Foundation

public struct Product: Sendable, Equatable, Identifiable, Codable {
    public var id: String
    public var name: String
    public var price: Money
    public var tags: [String]

    public init(id: String, name: String, price: Money, tags: [String] = []) {
        self.id = id
        self.name = name
        self.price = price
        self.tags = tags
    }
}
