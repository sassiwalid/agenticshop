# Exercise 04, report

## Part 1, the analyzer

| Command | Lines | Bytes |
|---|---|---|
| `swift package dump-package` | | |
| `shop-analyzer` on AgenticShop | | |
| `shop-analyzer --affected-by Catalog` | | |

## Part 2, the impact

- Tests that passed before your change, out of 6:
- Tests that pass after, out of 6:
- What `--affected-by Networking` prints:

## Part 3, the server

- `claude mcp list` (or `codex mcp list`) shows the server as:
- The description you wrote for `affected_targets`:

## Part 4, the skill

- Where the file is:
- Did the agent list the skill when asked which skills it has? Yes or no:

## Part 5, the question

The question you asked:

> If I change the Money type in Catalog, which other modules can break, and which tests should I run?

| Criterion | Answer |
|---|---|
| Did the agent call `affected_targets`? With which argument? | |
| Did it also read `Package.swift`? | |
| Was the answer right? Compare with the tool output | |
| Did it load the skill? | |
| `git status --short` after the session | |

## What you would change

<One tool you would add to this server, its name, and the sentence of its description that says when to use it.>
