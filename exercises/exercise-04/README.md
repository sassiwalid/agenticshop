# Exercise 04. SwiftProjectAnalyzer over MCP

Module 4, Extending Agents with Tools, Skills and MCP. About 60 minutes.

The lesson that goes with this exercise is on
[agenticswift.dev](https://agenticswift.dev/course/tools-skills-and-mcp/exercise-swiftprojectanalyzer-over-mcp).
It holds the full instructions, part by part. Module 4 belongs to the paid part of the course,
so the lesson opens with a license key.

## What you do

You finish a small Swift package that tells which targets of AgenticShop a change can break, and
which tests to run. You serve that answer to an agent through an MCP server written with
Foundation only. You write a skill that tells the agent when to use it. Then you ask the agent a
question about the project and record what it called.

## What you need

- Your branch `cart-b` from exercise 03, or `agent-ready` from exercise 02.
- A Mac with Xcode and its command-line tools. The exercise was checked with Swift 6.4.
- Claude Code or Codex.

## Files

| File | Used for |
|---|---|
| [starter/AgenticShopTools/](starter/AgenticShopTools/) | The package to finish. A library, a command-line tool and an MCP server |
| [starter/templates/SKILL.md](starter/templates/SKILL.md) | The skill to fill in |
| [starter/tools-report.md](starter/tools-report.md) | The report you fill in |

These files exist on the `main` branch only. Copy them next to your clone, out of AgenticShop.

    git fetch
    git archive origin/main:exercises/exercise-04/starter --prefix=exercise-04/ | tar -x -C ..

## Done when

- `swift test` passes in `AgenticShopTools`, with the tests of the impact unchanged.
- `shop-analyzer` reports the targets and dependencies of AgenticShop, as text and with `--json`.
- The server lists `affected_targets` with an input schema and answers a call, by hand and in your agent.
- A skill tells the agent when to use the tool, and `AGENTS.md` points at it.
- Your report records one session in which the agent was asked the question, and `git status` was clean afterwards.

## Reference solution

Released with the course solutions, kept out of this repository on purpose.
