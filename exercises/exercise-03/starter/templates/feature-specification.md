# Feature specification. <Feature name>

Status: draft | specified | implemented.

## Goal

<Two sentences. What the feature is for, from the point of view of the person who uses it.>

## Vocabulary

<Every word of the feature that two readers could understand differently, defined once.
These definitions become names in the code.>

- A **<term>** is <definition>.

## Requirements

| Id | Requirement |
|---|---|
| <PREFIX>-1 | <One sentence that a test can prove true or false.> |

## Boundaries

- The feature lives in `<Packages/Module>`.
- It may depend on <modules>. It does not depend on <modules>.
- <What is out of scope for this version.>

## Acceptance

- Every requirement has at least one test named after its identifier.
- `Scripts/verify.sh` exits with 0.
- No file outside `<Packages/Module>` changes, apart from <the exceptions>.

<A specification says what, not how. No type names, no method signatures.>
