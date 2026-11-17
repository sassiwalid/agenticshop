# Exercise 05. A self-correcting Shopping Cart workflow

Module 5, Feedback Loops and Automated Validation. About 60 minutes.

The lesson that goes with this exercise is on
[agenticswift.dev](https://agenticswift.dev/course/feedback-loops-and-validation/exercise-a-self-correcting-shopping-cart-workflow).
It holds the full instructions, part by part. Module 5 belongs to the paid part of the course,
so the lesson opens with a license key.

## What you do

You install a quality gate and two Claude Code hooks, prove that each check can fail, and commit
the tests of the percentage discount before its code. Then an agent implements the feature while
the compiler, the tests and the gate answer it directly. You relay no error, and the diff shows
that no test was weakened. You finish with a Definition of Done where every line maps to a command.

## What you need

- Your branch `cart-b` from exercise 03.
- A Mac with Xcode and its command-line tools. The exercise was checked with Swift 6.4.
- Claude Code for the hooks. Codex works for every part except the hooks.
- `jq`, which ships with recent versions of macOS.

## Files

| File | Used for |
|---|---|
| [starter/Scripts/check.sh](starter/Scripts/check.sh) | The quality gate. Four checks, one line each |
| [starter/Scripts/hooks/](starter/Scripts/hooks/) | A build after each edit, the gate before the agent stops |
| [starter/claude-settings.json](starter/claude-settings.json) | The hooks, declared for Claude Code |
| [starter/DiscountTests.swift](starter/DiscountTests.swift) | The tests of DISC-1 to DISC-7, written before the code |
| [starter/percentage-discount.md](starter/percentage-discount.md) | The specification the tests follow |
| [starter/definition-of-done.md](starter/definition-of-done.md) | The Definition of Done to fill in |
| [starter/workflow-report.md](starter/workflow-report.md) | The report you fill in |

These files exist on the `main` branch only. Copy them next to your clone.

    git fetch
    git archive origin/main:exercises/exercise-05/starter --prefix=exercise-05/ | tar -x -C ..

## Done when

- `Scripts/check.sh` runs from one command and exits with 1 on each failure you planted.
- The tests of the discount were committed before the implementation, in their own commit.
- The agent made them pass without you relaying an error.
- `git diff --stat seeded-tests -- 'Packages/*/Tests/*'` at the end of the run printed nothing.
- Every line of your Definition of Done maps to a command, or is marked as a review.

## Reference solution

Released with the course solutions, kept out of this repository on purpose.
