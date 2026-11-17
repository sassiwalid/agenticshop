import Foundation
import ProjectAnalysis

/// The tools of the server. They read the package manifest and change nothing.
enum Tools {
    static var definitions: [[String: Any]] { [
        [
            "name": "list_targets",
            "annotations": ["readOnlyHint": true, "openWorldHint": false],
            "description": "Lists every target of the AgenticShop Swift package, one line each, with the targets it depends on. "
                + "Use it to learn which modules exist and how they depend on each other, instead of reading Package.swift. "
                + "Read-only.",
            "inputSchema": ["type": "object", "properties": [String: Any](), "additionalProperties": false],
        ],
        // Exercise 04, part 3. Add the definition of affected_targets here.
    ] }

    static func call(_ params: [String: Any], root: URL) -> [String: Any] {
        do {
            let report = try PackageAnalyzer.report(forPackageAt: root)
            switch params["name"] as? String {
            case "list_targets":
                return result(report.text)
            // Exercise 04, part 3. Answer a call to affected_targets here.
            // Its arguments are in params["arguments"], a dictionary.
            default:
                return result("Unknown tool. This server has list_targets.", isError: true)
            }
        } catch {
            // An error the model can read and act on, returned as a result and not as a protocol error.
            return result("\(error)", isError: true)
        }
    }

    static func result(_ text: String, isError: Bool = false) -> [String: Any] {
        ["content": [["type": "text", "text": text]], "isError": isError]
    }
}

/// One resource, the architecture overview of the package, read from disk at each request.
enum Resources {
    static let architectureURI = "agenticshop://docs/architecture"
    static let architecturePath = "Documentation/Architecture/overview.md"

    static func list(root: URL) -> [[String: Any]] {
        [[
            "uri": architectureURI,
            "name": "architecture",
            "title": "AgenticShop architecture overview",
            "description": "The module rules of AgenticShop and the reason for each.",
            "mimeType": "text/markdown",
        ]]
    }

    static func read(_ uri: String?, root: URL) -> [String: Any]? {
        guard uri == architectureURI,
              let text = try? String(contentsOf: root.appendingPathComponent(architecturePath), encoding: .utf8)
        else { return nil }
        return ["uri": architectureURI, "mimeType": "text/markdown", "text": text]
    }
}
