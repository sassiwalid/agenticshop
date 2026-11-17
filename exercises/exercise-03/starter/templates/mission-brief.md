# Mission <NNN>. <Name>

## Goal

<One sentence. What will exist at the end that does not exist now.>

## Read first

<Paths, not content. The specification, the types the work builds on, the decision records.>

- `<path>`, <why>.

## Scope

<The folders and files the agent may change. Name each exception explicitly.>

## Out of scope

<What looks related and is not part of this mission. Name the temptation, if there is one.>

## Verify

<The command, and what its result must be.>

## Stop and report, without making the change, if

- a file outside the scope must change
- the specification does not say what to do in a case you have to handle
- the same failure comes back twice

## Report

- the files you changed
- the last lines of the verification command
- each case where the specification was silent, and what you would decide
