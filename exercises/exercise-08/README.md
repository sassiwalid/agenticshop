# Exercise 08. Evaluate harness configurations

Module 8, Evaluation and Production Readiness. About 60 minutes.

The lesson that goes with this exercise is on
[agenticswift.dev](https://agenticswift.dev/course/evaluation-and-production-readiness/exercise-evaluate-harness-configurations).
It holds the full instructions, part by part. Module 8 belongs to the paid part of the course,
so the lesson opens with a license key.

## What you do

You run three fixed missions from one tagged commit against different harness configurations,
score every run with acceptance tests the agent never saw, read the traces of the failures, and
recommend a configuration with its cost per successful mission and what you did not measure.

## What you need

- Your branch `checkout` from exercise 07.
- Claude Code for the headless runs as written, or Codex with the runner adapted.
- A budget for six runs at least. The batch caps each run at one dollar.
- `jq`, which ships with recent versions of macOS.

## Files

| File | Used for |
|---|---|
| [starter/scenarios/](starter/scenarios/) | Three missions, each with its scope and held-out acceptance tests |
| [starter/configurations/](starter/configurations/) | The bare, instructed and full configurations, as scripts |
| [starter/eval/new-run.sh](starter/eval/new-run.sh) | Prepares one run in its own worktree from `eval-base` |
| [starter/eval/run-headless.sh](starter/eval/run-headless.sh) | Runs a mission with Claude Code and a budget, no person watching |
| [starter/eval/accept.sh](starter/eval/accept.sh) | Scores a finished run and appends it to `runs.csv` |
| [starter/eval/score.swift](starter/eval/score.swift) | Turns `runs.csv` into the scorecard |
| [starter/evaluation-report.md](starter/evaluation-report.md) | The report you fill in |
| [starter/readiness-checklist.md](starter/readiness-checklist.md) | Nine questions a team answers with evidence |

These files exist on the `main` branch only. Copy them next to your clone.

    git fetch
    git archive origin/main:exercises/exercise-08/starter --prefix=exercise-08/ | tar -x -C ..

The scripts were checked with reference implementations in place of an agent. The figures of
your report come from your own runs.

## Done when

- Every configuration ran the same missions from the same commit.
- Each metric is computed from recorded runs, and the number of runs is stated.
- The report states a recommendation, its evidence and what was not measured.
- Cost is reported next to success.

## Reference solution

Released with the course solutions, kept out of this repository on purpose.
