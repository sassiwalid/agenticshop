// Computes the scorecard of an evaluation from runs.csv.
// Usage: swift ../exercise-08/eval/score.swift ../exercise-08/runs.csv
//
// A run succeeds when its final state builds, every acceptance test passes, no test that
// existed before fails, and no file outside the scenario's scope changed.
// A run succeeds at first pass when it succeeds with no intervention from a person.
import Foundation

struct Run {
    let configuration: String
    let buildOK: Bool
    let acceptancePassed: Int
    let acceptanceTotal: Int
    let suiteOK: Bool
    let scopeOK: Bool
    let interventions: Int
    let cost: Double?

    var succeeded: Bool { buildOK && acceptancePassed == acceptanceTotal && suiteOK && scopeOK }
}

guard CommandLine.arguments.count == 2,
      let text = try? String(contentsOfFile: CommandLine.arguments[1], encoding: .utf8)
else {
    FileHandle.standardError.write(Data("Usage: swift score.swift <runs.csv>\n".utf8))
    exit(64)
}

let runs: [Run] = text.split(separator: "\n").dropFirst().compactMap { line in
    let field = line.split(separator: ",", omittingEmptySubsequences: false).map(String.init)
    guard field.count >= 10 else { return nil }
    return Run(
        configuration: field[0],
        buildOK: field[3] == "1",
        acceptancePassed: Int(field[4]) ?? 0,
        acceptanceTotal: Int(field[5]) ?? 0,
        suiteOK: field[6] == "1",
        scopeOK: field[7] == "1",
        interventions: Int(field[8]) ?? 0,
        cost: Double(field[9])
    )
}

func percent(_ part: Int, _ whole: Int) -> String {
    whole == 0 ? "n/a" : String(format: "%.0f%%", Double(part) * 100 / Double(whole))
}

func dollars(_ value: Double?) -> String {
    value.map { String(format: "$%.2f", $0) } ?? "n/a"
}

print("| Configuration | Runs | Task success | First-pass success | Build success | Acceptance tests passed | Interventions per run | Total cost | Cost per success |")
print("|---|---|---|---|---|---|---|---|---|")
for configuration in Set(runs.map(\.configuration)).sorted() {
    let group = runs.filter { $0.configuration == configuration }
    let successes = group.filter(\.succeeded).count
    let firstPass = group.filter { $0.succeeded && $0.interventions == 0 }.count
    let built = group.filter(\.buildOK).count
    let passed = group.map(\.acceptancePassed).reduce(0, +)
    let total = group.map(\.acceptanceTotal).reduce(0, +)
    let interventions = Double(group.map(\.interventions).reduce(0, +)) / Double(group.count)
    let costs = group.compactMap(\.cost)
    let totalCost: Double? = costs.count == group.count ? costs.reduce(0, +) : nil
    let perSuccess: Double? = totalCost.flatMap { successes > 0 ? $0 / Double(successes) : nil }
    print("| \(configuration) | \(group.count) | \(percent(successes, group.count)) | \(percent(firstPass, group.count)) | \(percent(built, group.count)) | \(percent(passed, total)) | \(String(format: "%.1f", interventions)) | \(dollars(totalCost)) | \(dollars(perSuccess)) |")
}
