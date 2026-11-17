import Foundation

/// One target of a Swift package, with what it uses and what uses it.
public struct TargetReport: Codable, Equatable, Sendable {
    public var name: String
    /// "regular", "test" or "executable", as Swift Package Manager names them.
    public var kind: String
    public var path: String?
    public var dependencies: [String]
    public var dependents: [String]
}

public struct ProjectReport: Codable, Equatable, Sendable {
    public var name: String
    public var targets: [TargetReport]

    /// A short text rendering, one line per target.
    public var text: String {
        var lines = ["Package \(name), \(targets.count) targets"]
        for target in targets {
            let uses = target.dependencies.isEmpty ? "nothing" : target.dependencies.joined(separator: ", ")
            lines.append("- \(target.name) (\(target.kind)) depends on \(uses)")
        }
        return lines.joined(separator: "\n")
    }
}

/// The targets a change to one target can break, directly or through another target.
public struct ImpactReport: Codable, Equatable, Sendable {
    public var changed: String
    /// Library and executable targets that depend on the changed one, at any distance.
    public var affectedTargets: [String]
    /// Test targets to run after the change, including the changed target's own tests.
    public var testsToRun: [String]

    public var text: String {
        let targets = affectedTargets.isEmpty ? "no other target" : affectedTargets.joined(separator: ", ")
        let tests = testsToRun.isEmpty ? "no test target" : testsToRun.joined(separator: ", ")
        return "A change to \(changed) can affect \(targets).\nRun \(tests)."
    }
}

public enum AnalysisError: Error, Equatable, CustomStringConvertible {
    case notAPackage(String)
    case manifestUnreadable(String)
    case unknownTarget(String, known: [String])

    public var description: String {
        switch self {
        case .notAPackage(let path):
            "No Swift package could be read at \(path)."
        case .manifestUnreadable(let reason):
            "The package manifest could not be understood: \(reason)."
        case .unknownTarget(let name, let known):
            "There is no target named \(name). Known targets are \(known.joined(separator: ", "))."
        }
    }
}
