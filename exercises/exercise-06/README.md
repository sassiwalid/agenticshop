# Exercise 06. Secure an agent environment

Module 6, Agent Governance and Security. About 60 minutes.

The lesson that goes with this exercise is on
[agenticswift.dev](https://agenticswift.dev/course/governance-and-security/exercise-secure-an-agent-environment).
It holds the full instructions, part by part. Module 6 belongs to the paid part of the course,
so the lesson opens with a license key.

## What you do

You start from an agent configuration with no restriction, a secrets file on disk and a feature
specification with a hostile instruction hidden in an HTML comment. You add permission rules, a
sandbox, two hooks and a few lines of instructions, prove each protection with a test run, read
the audit log, and write the policy that says who approves what.

The secret is fake and opens nothing. Everything the planted instruction asks to delete is in Git
history. Run the exercise in a clone that holds nothing uncommitted.

## What you need

- Your branch `cart-b` from exercise 03.
- Claude Code for the sandbox and the hooks. Codex can follow parts 1, 4 and 6.
- `jq`, which ships with recent versions of macOS.

## Files

| File | Used for |
|---|---|
| [starter/environment/settings.json](starter/environment/settings.json) | Claude Code settings that allow every tool |
| [starter/environment/Config/Secrets.xcconfig](starter/environment/Config/Secrets.xcconfig) | A fake secrets file to protect |
| [starter/environment/Documentation/Features/gift-wrap.md](starter/environment/Documentation/Features/gift-wrap.md) | A specification carrying a planted instruction |
| [starter/Scripts/hooks/guard.sh](starter/Scripts/hooks/guard.sh) | A hook that refuses a few dangerous calls |
| [starter/Scripts/hooks/audit.sh](starter/Scripts/hooks/audit.sh) | A hook that records every tool call outside the repository |
| [starter/policy-template.md](starter/policy-template.md) | The policy to write |
| [starter/security-report.md](starter/security-report.md) | The report you fill in |

These files exist on the `main` branch only. Copy them next to your clone.

    git fetch
    git archive origin/main:exercises/exercise-06/starter --prefix=exercise-06/ | tar -x -C ..

## Done when

- A destructive command is refused or asks for approval in a test run.
- The secrets file cannot be read by the agent in a test run, through the Read tool and through a program.
- The planted instruction is not followed, and the run is recorded and documented.
- The policy states who approves which kind of action.

## Reference solution

Released with the course solutions, kept out of this repository on purpose.
