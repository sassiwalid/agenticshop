import Foundation
import ProjectAnalysis

/// A minimal Model Context Protocol server over stdio, written with Foundation only.
///
/// Start it with the directory of the package it describes:
///
///     shop-mcp /path/to/agenticshop
///
/// Each line on standard input is one JSON-RPC message, and each answer is one line on
/// standard output. Standard output carries protocol messages only. Logs go to standard error.
/// The server reads and never writes. Its tools take no path, so a call cannot reach
/// another directory than the one it was started with.
@main
enum Server {
    /// Revisions that open a session with `initialize`, newest first.
    static let supportedVersions = ["2025-11-25", "2025-06-18", "2025-03-26"]
    nonisolated(unsafe) static var root = URL(fileURLWithPath: ".")

    static func main() {
        guard let path = CommandLine.arguments.dropFirst().first else {
            log("usage: shop-mcp <package directory>")
            exit(64)
        }
        root = URL(fileURLWithPath: path).absoluteURL.standardizedFileURL
        log("serving \(root.path)")

        while let line = readLine(strippingNewline: true) {
            guard !line.isEmpty else { continue }
            guard let message = (try? JSONSerialization.jsonObject(with: Data(line.utf8))) as? [String: Any] else {
                send(["jsonrpc": "2.0", "id": NSNull(), "error": ["code": -32700, "message": "Parse error"]])
                continue
            }
            let method = message["method"] as? String ?? "?"
            log("<- \(method)")
            // A message without an id is a notification and gets no answer.
            guard let id = message["id"] else { continue }
            let params = message["params"] as? [String: Any] ?? [:]

            switch method {
            case "initialize":
                let requested = params["protocolVersion"] as? String
                let version = requested.flatMap { supportedVersions.contains($0) ? $0 : nil } ?? supportedVersions[0]
                reply(id, [
                    "protocolVersion": version,
                    "capabilities": ["tools": [String: Any](), "resources": [String: Any]()],
                    "serverInfo": ["name": "agenticshop-tools", "version": "1.0.0"],
                    "instructions": "Answers questions about the structure of the AgenticShop package. Read-only.",
                ])
            case "ping":
                reply(id, [:])
            case "tools/list":
                reply(id, ["tools": Tools.definitions])
            case "tools/call":
                // A call to a tool the server does not have is a malformed request, so a protocol error.
                // A tool that runs and fails answers with a result flagged isError, in Tools.call.
                let name = params["name"] as? String ?? ""
                if Tools.definitions.contains(where: { $0["name"] as? String == name }) {
                    reply(id, Tools.call(params, root: root))
                } else {
                    fail(id, code: -32602, "Unknown tool: \(name).")
                }
            case "resources/list":
                reply(id, ["resources": Resources.list(root: root)])
            case "resources/read":
                if let contents = Resources.read(params["uri"] as? String, root: root) {
                    reply(id, ["contents": [contents]])
                } else {
                    fail(id, code: -32602, "Unknown resource.")
                }
            default:
                // Includes `server/discover`, which newer clients send first. Answering
                // "method not found" tells them to open the session with `initialize`.
                fail(id, code: -32601, "Method not found")
            }
        }
    }

    static func reply(_ id: Any, _ result: [String: Any]) {
        send(["jsonrpc": "2.0", "id": id, "result": result])
    }

    static func fail(_ id: Any, code: Int, _ message: String) {
        send(["jsonrpc": "2.0", "id": id, "error": ["code": code, "message": message]])
    }

    static func send(_ object: [String: Any]) {
        guard let data = try? JSONSerialization.data(withJSONObject: object) else { return }
        FileHandle.standardOutput.write(data + Data("\n".utf8))
    }

    static func log(_ text: String) {
        FileHandle.standardError.write(Data("[shop-mcp] \(text)\n".utf8))
    }
}
