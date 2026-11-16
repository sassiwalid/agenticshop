# ADR 0001. One package with one target per feature

Status: accepted.

## Context

The app is split into features that several people, and several agents, will change at the same
time. Boundaries between features must be visible to the compiler and cheap to check.

## Decision

AgenticShop is a single Swift package. Each feature is a library target with its own folder
under `Packages/` and its own test target.

## Consequences

- `swift build` and `swift test` validate the whole codebase from the command line, with no
  simulator.
- A dependency between two features has to be declared in `Package.swift`, where a review sees it.
- The iOS application shell lives in a separate Xcode project that imports these libraries.
- One manifest means one file that every new target touches. Changes to it are made by one
  person or one agent at a time.
