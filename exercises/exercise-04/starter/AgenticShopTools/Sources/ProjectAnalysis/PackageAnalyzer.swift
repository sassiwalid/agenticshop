import Foundation

/// Reads what Swift Package Manager already knows about a package.
/// It runs `swift package dump-package` and changes nothing on disk.
public enum PackageAnalyzer {
    /// Builds a report from the JSON printed by `swift package dump-package`.
    public static func report(fromManifestJSON data: Data) throws -> ProjectReport {
        guard
            let root = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any],
            let name = root["name"] as? String,
            let rawTargets = root["targets"] as? [[String: Any]]
        else {
            throw AnalysisError.manifestUnreadable("unexpected shape")
        }

        var targets = rawTargets.map { raw in
            // A dependency is {"byName": [name, …]}, {"target": [name, …]} or {"product": [name, …]}.
            let dependencies = (raw["dependencies"] as? [[String: Any]] ?? []).compactMap { dependency in
                (dependency.values.first as? [Any])?.first as? String
            }
            return TargetReport(
                name: raw["name"] as? String ?? "unnamed",
                kind: raw["type"] as? String ?? "regular",
                path: raw["path"] as? String,
                dependencies: dependencies.sorted(),
                dependents: []
            )
        }
        for index in targets.indices {
            let name = targets[index].name
            targets[index].dependents = targets.filter { $0.dependencies.contains(name) }.map(\.name).sorted()
        }
        return ProjectReport(name: name, targets: targets.sorted { $0.name < $1.name })
    }

    /// Every target that depends on `target`, directly or through other targets.
    ///
    /// Exercise 04, part 2. Not implemented yet. The tests `followsDependentsAtAnyDistance`,
    /// `aLeafTargetAffectsOnlyItsTests` and `namesTheKnownTargetsWhenOneIsUnknown` describe
    /// what it must do. Library and executable targets go in `affectedTargets`, test targets
    /// in `testsToRun`, both sorted by name. An unknown target throws `AnalysisError.unknownTarget`.
    public static func impact(of target: String, in report: ProjectReport) throws -> ImpactReport {
        ImpactReport(changed: target, affectedTargets: [], testsToRun: [])
    }

    /// Runs `swift package dump-package` in a directory and reports on the result.
    public static func report(forPackageAt directory: URL) throws -> ProjectReport {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = ["swift", "package", "dump-package"]
        // Process needs an absolute location. A relative one, such as "../app", is resolved first.
        process.currentDirectoryURL = directory.absoluteURL.standardizedFileURL
        let output = Pipe()
        process.standardOutput = output
        process.standardError = FileHandle.nullDevice
        do {
            try process.run()
        } catch {
            throw AnalysisError.notAPackage(directory.path)
        }
        // Read before waiting, so a large manifest cannot fill the pipe and block.
        let data = output.fileHandleForReading.readDataToEndOfFile()
        process.waitUntilExit()
        guard process.terminationStatus == 0 else {
            throw AnalysisError.notAPackage(directory.path)
        }
        return try report(fromManifestJSON: data)
    }
}
