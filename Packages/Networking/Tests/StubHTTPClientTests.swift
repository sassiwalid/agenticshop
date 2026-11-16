import Foundation
import Testing
@testable import Networking

@Test func returnsTheResponseRegisteredForAPath() async throws {
    let client = StubHTTPClient(responses: ["/products": HTTPResponse(statusCode: 200, body: Data("[]".utf8))])
    let response = try await client.send(HTTPRequest(path: "/products"))
    #expect(response.statusCode == 200)
}

@Test func throwsForAnUnknownPath() async {
    let client = StubHTTPClient(responses: [:])
    await #expect(throws: HTTPError.unexpectedStatus(404)) {
        try await client.send(HTTPRequest(path: "/missing"))
    }
}
