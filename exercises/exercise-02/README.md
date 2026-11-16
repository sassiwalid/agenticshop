# Exercise 02. Prepare AgenticShop for agents

Module 2, Building Agent-Ready Swift Repositories. About 60 minutes.

The lesson that goes with this exercise is on
[agenticswift.dev](https://agenticswift.dev/course/agent-ready-swift-repositories/exercise-prepare-agenticshop-for-agents).
It holds the full instructions, part by part. Module 2 belongs to the paid part of the course,
so the lesson opens with a license key.

## What you do

You make AgenticShop ready for an agent, and you measure what that changed. Three questions
are asked to a new agent session on the baseline, then again after your work.

1. Add one command that verifies a change, `Scripts/verify.sh`.
2. Prove that it holds a module boundary, by breaking the boundary on purpose.
3. Compare the architecture page with `Package.swift`.
4. Write a root instruction file, and one for the ShoppingCart module.
5. Ask the three questions again and record both readings.

## What you need

- A Mac with Xcode and its command-line tools. The exercise was checked with Swift 6.4.
- A coding agent. Claude Code and Codex both work.

## Files

| File | Used for |
|---|---|
| [starter/questions.md](starter/questions.md) | The three questions |
| [starter/readiness-report.md](starter/readiness-report.md) | The report you fill in |

These files exist on the `main` branch only. Print the questions before you create your
working branch.

    git switch main
    cat exercises/exercise-02/starter/questions.md
    git switch -c agent-ready baseline

## Done when

- A new agent session finds the build and test commands from the instruction files alone.
- The dependency rules you state match `Package.swift`.
- `Scripts/verify.sh` exits with 0 on your branch, and you have seen it exit with 1 on an undeclared import.
- No secret and no machine-specific path appears in what you committed.
- The root instruction file fits on one screen, 40 lines at most.
- Your report holds both readings, on the same three questions.

## Reference solution

A reference version of the instruction files and of the script is released with the course
solutions. It is kept out of this repository on purpose.
