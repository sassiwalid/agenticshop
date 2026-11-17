# Exercise 03. Two context strategies for one feature

Module 3, Context Engineering for Swift Developers. About 60 minutes.

The lesson that goes with this exercise is on
[agenticswift.dev](https://agenticswift.dev/course/context-engineering/exercise-two-context-strategies-for-one-feature).
It holds the full instructions, part by part. Module 3 belongs to the paid part of the course,
so the lesson opens with a license key.

## What you do

You implement the Shopping Cart twice, from the same commit and with the same mission. Once with
the content of every relevant file pasted into the prompt, once with a brief that gives their
paths. You record what the agent read and how much context it used in each run. Then you write a
decision record for a case the specification leaves open, and the specification and brief of the
next feature from the templates.

## What you need

- Your branch `agent-ready` from exercise 02, with `Scripts/verify.sh`.
- A Mac with Xcode and its command-line tools. The exercise was checked with Swift 6.4.
- A coding agent. Claude Code and Codex both work.

## Files

| File | Used for |
|---|---|
| [starter/build-run-a-prompt.sh](starter/build-run-a-prompt.sh) | Prints the prompt of run A, the mission with seven files pasted below it |
| [starter/mission-001-shopping-cart.md](starter/mission-001-shopping-cart.md) | The prompt of run B, the mission with paths |
| [starter/context-report.md](starter/context-report.md) | The report you fill in |
| [starter/templates/](starter/templates/) | Empty feature specification, decision record and mission brief |

These files exist on the `main` branch only. Build both prompts before you start, and keep them
outside the repository.

    mkdir -p ../exercise-03
    git show main:exercises/exercise-03/starter/build-run-a-prompt.sh | sh > ../exercise-03/run-a-prompt.md
    git show main:exercises/exercise-03/starter/mission-001-shopping-cart.md > ../exercise-03/run-b-prompt.md

## Done when

- Both runs started from the same commit and the same mission.
- Your report records, for each run, what the agent read and the context it used at the end.
- At least one branch has a cart for which `Scripts/verify.sh` exits with 0 and every requirement CART-1 to CART-7 has a test.
- A decision record settles the case of a line at 99, and a test covers it.
- The three templates are filled in.

## Reference solution

Released with the course solutions, kept out of this repository on purpose.
