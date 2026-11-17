import Foundation
import ProjectAnalysis

/// shop-analyzer <package directory> [--affected-by <target>] [--json]
@main
enum Command {
    static func main() {
        var arguments = Array(CommandLine.arguments.dropFirst())
        let wantsJSON = arguments.contains("--json")
        arguments.removeAll { $0 == "--json" }

        var changedTarget: String?
        if let flag = arguments.firstIndex(of: "--affected-by"), flag + 1 < arguments.count {
            changedTarget = arguments[flag + 1]
            arguments.removeSubrange(flag...(flag + 1))
        }

        guard let path = arguments.first else {
            FileHandle.standardError.write(Data("Usage: shop-analyzer <package directory> [--affected-by <target>] [--json]\n".utf8))
            exit(64)
        }

        do {
            let report = try PackageAnalyzer.report(forPackageAt: URL(fileURLWithPath: path))
            if let changedTarget {
                let impact = try PackageAnalyzer.impact(of: changedTarget, in: report)
                print(wantsJSON ? try json(impact) : impact.text)
            } else {
                print(wantsJSON ? try json(report) : report.text)
            }
        } catch {
            FileHandle.standardError.write(Data("\(error)\n".utf8))
            exit(1)
        }
    }

    static func json(_ value: some Encodable) throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        return String(decoding: try encoder.encode(value), as: UTF8.self)
    }
}
