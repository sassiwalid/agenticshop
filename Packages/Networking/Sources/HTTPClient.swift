import Foundation

public struct HTTPRequest: Sendable, Equatable {
    public var path: String

    public init(path: String) {
        self.path = path
    }
}

public struct HTTPResponse: Sendable, Equatable {
    public var statusCode: Int
    public var body: Data

    public init(statusCode: Int, body: Data) {
        self.statusCode = statusCode
        self.body = body
    }
}

public enum HTTPError: Error, Equatable {
    case unexpectedStatus(Int)
}

/// The only way feature modules reach the network.
public protocol HTTPClient: Sendable {
    func send(_ request: HTTPRequest) async throws -> HTTPResponse
}
