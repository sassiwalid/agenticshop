import Foundation

/// Answers from a fixed table of responses. Used by tests and previews.
public struct StubHTTPClient: HTTPClient {
    private let responses: [String: HTTPResponse]

    public init(responses: [String: HTTPResponse]) {
        self.responses = responses
    }

    public func send(_ request: HTTPRequest) async throws -> HTTPResponse {
        guard let response = responses[request.path] else {
            throw HTTPError.unexpectedStatus(404)
        }
        return response
    }
}
