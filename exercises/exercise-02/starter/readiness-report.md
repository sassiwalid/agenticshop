# Agent readiness report

Agent and model used:
Swift version (`swift --version`):
Date:

## Three questions, before and after

| Question | Before, right or wrong | Before, files and commands | After, right or wrong | After, files and commands |
|---|---|---|---|---|
| 1. Build and test Catalog alone | | | | |
| 2. May ShoppingCart import Account, and where is that decided | | | | |
| 3. When is a ShoppingCart change done | | | | |

## The boundary

| With an undeclared `import Account` in Catalog | Exit code | What it printed |
|---|---|---|
| `swift build` | | |
| `Scripts/verify.sh` | | |

## The page and the manifest

Rules of `Documentation/Architecture/overview.md` that `Package.swift` contradicts:

Rules that `Package.swift` cannot express:

## The instruction files

Lines in the root file:
Lines in the ShoppingCart file:
A line you removed because the agent could find it without help:

## What did not change

Things the preparation did not improve. They matter as much as the ones it did.

## One session is one sample

Agent runs vary. If you asked the questions twice in each state, note whether the result held.
