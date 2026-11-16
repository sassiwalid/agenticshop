# Exercise 01. Baseline versus configured

Module 1, Agent Harness Foundations. About 60 minutes.

The lesson that goes with this exercise is on
[agenticswift.dev](https://agenticswift.dev/course/understanding-agent-harnesses/exercise-prompting-versus-harnessing).
Module 1 is free to read.

## What you do

You implement the same small feature twice, with the same agent and the same model. The first
time you only type a prompt. The second time the agent works inside a prepared environment.
You then compare what happened, on criteria fixed in advance.

The feature is product search in the `Catalog` module. It is described in
[starter/feature-request.md](starter/feature-request.md).

## What you need

- A Mac with Xcode and its command-line tools. The code was built with Swift 6.4.
- A coding agent. Claude Code and Codex both work.

## Files

| File | Used in |
|---|---|
| [starter/feature-request.md](starter/feature-request.md) | Both runs, as the reference for what was asked |
| [starter/harness/AGENTS.md](starter/harness/AGENTS.md) | Run B, the instruction file |
| [starter/harness/task.md](starter/harness/task.md) | Run B, the task with its scope, its verification command and its stop conditions |
| [starter/comparison-report.md](starter/comparison-report.md) | The report you fill in |

These files exist on the `main` branch only. The tag `baseline` holds the codebase and nothing
else, so a run that starts from it cannot read them. Keep this page open in a browser while you
work, because the files leave your working tree when you switch to a run branch.

## Before you start

    git clone https://github.com/sassiwalid/agenticshop.git
    cd agenticshop
    swift build
    swift test

Six tests pass.

## Run A, baseline

1. Create a branch from the baseline.

       git switch -c run-a baseline

2. Start a new agent session at the root of the repository. Do not add any instruction file.
3. Type one prompt and nothing else.

       Add product search to the catalog.

4. Accept what the agent proposes. Answer its questions briefly, and count them.
5. When it says it is done, run `swift build` and `swift test` yourself.
6. Commit what the run left, if the agent did not.

       git add -A
       git commit -m "Run A"

## Run B, configured

1. Create a second branch from the baseline. Run A is not visible from it.

       git switch -c run-b baseline

2. Put the instruction file at the root of the repository.

       git show main:exercises/exercise-01/starter/harness/AGENTS.md > AGENTS.md

3. Print the task, start a new agent session and give it that text.

       git show main:exercises/exercise-01/starter/harness/task.md

4. Let it work. Count your interventions.
5. When it stops, run `swift build` and `swift test` yourself.
6. Commit what the run left, if the agent did not.

       git add -A
       git commit -m "Run B"

Use a new session for each run. A session that has seen run A already knows the answer.

## Record both runs

Go back to `main`, where the report template is, and look at what each run changed.

    git switch main
    git diff --stat baseline run-a
    git diff --stat baseline run-b

Fill in [starter/comparison-report.md](starter/comparison-report.md). List each difference and
name the part of the harness you attribute it to.

## Done when

- The report compares both runs on the same criteria. Build result, test result, files touched, human interventions.
- Each difference is attributed to a named dimension of the harness.
- The feature builds and its tests pass in run B, or the report explains why not.
- Both runs started from `baseline`, in separate sessions.

## Reference solution

A reference implementation of the feature is released with the course solutions. It is kept out
of this repository on purpose, so that neither run can find it.
