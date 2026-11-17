import Foundation
import Testing
@testable import ProjectAnalysis

private let manifest = Data("""
{
  "name": "Shop",
  "targets": [
    { "name": "Networking", "type": "regular", "path": "Packages/Networking/Sources", "dependencies": [] },
    { "name": "Catalog", "type": "regular", "dependencies": [ { "byName": ["Networking", null] } ] },
    { "name": "Cart", "type": "regular", "dependencies": [ { "byName": ["Catalog", null] } ] },
    { "name": "CatalogTests", "type": "test", "dependencies": [ { "target": ["Catalog", null] } ] },
    { "name": "CartTests", "type": "test", "dependencies": [ { "target": ["Cart", null] } ] }
  ]
}
""".utf8)

@Test func readsTargetsAndTheirDependencies() throws {
    let report = try PackageAnalyzer.report(fromManifestJSON: manifest)
    #expect(report.name == "Shop")
    #expect(report.targets.map(\.name) == ["Cart", "CartTests", "Catalog", "CatalogTests", "Networking"])
    #expect(report.targets[2].dependencies == ["Networking"])
    #expect(report.targets[1].kind == "test")
    #expect(report.targets[4].path == "Packages/Networking/Sources")
}

@Test func computesWhoDependsOnATarget() throws {
    let report = try PackageAnalyzer.report(fromManifestJSON: manifest)
    #expect(report.targets[4].dependents == ["Catalog"])
    #expect(report.targets[2].dependents == ["Cart", "CatalogTests"])
}

@Test func followsDependentsAtAnyDistance() throws {
    let report = try PackageAnalyzer.report(fromManifestJSON: manifest)
    let impact = try PackageAnalyzer.impact(of: "Networking", in: report)
    #expect(impact.affectedTargets == ["Cart", "Catalog"])
    #expect(impact.testsToRun == ["CartTests", "CatalogTests"])
}

@Test func aLeafTargetAffectsOnlyItsTests() throws {
    let report = try PackageAnalyzer.report(fromManifestJSON: manifest)
    let impact = try PackageAnalyzer.impact(of: "Cart", in: report)
    #expect(impact.affectedTargets.isEmpty)
    #expect(impact.testsToRun == ["CartTests"])
}

@Test func namesTheKnownTargetsWhenOneIsUnknown() throws {
    let report = try PackageAnalyzer.report(fromManifestJSON: manifest)
    #expect(throws: AnalysisError.unknownTarget("Basket", known: report.targets.map(\.name))) {
        try PackageAnalyzer.impact(of: "Basket", in: report)
    }
}

@Test func rejectsSomethingThatIsNotAManifest() {
    #expect(throws: AnalysisError.manifestUnreadable("unexpected shape")) {
        try PackageAnalyzer.report(fromManifestJSON: Data("[]".utf8))
    }
}
