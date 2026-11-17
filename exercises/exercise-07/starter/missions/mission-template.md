# Mission <number>. <Name>

## Goal

<One sentence. What exists when the mission is done.>

## Read first

- <The specification, by path.>
- <The contract, by path.>
- <The code this mission extends, by path.>

## Scope

- <The only folder this mission may change.>

## Out of scope

- <What it must not touch, and why. The contract, `Package.swift`, the other mission's module.>

## Verify

<The command that says the mission is done, and the exit code that means yes.>

## Stop and report, without making the change, if

- <a file outside the scope must change>
- <the contract does not let you do what the specification asks>
- <the same failure comes back twice>

## Report

- <the files you changed>
- <the last lines of the verify command>
- <each case where the specification was silent, and what you would decide>
