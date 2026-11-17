#!/bin/sh
# Scores one finished run. Usage, from the root of your clone:
#   ../exercise-08/eval/accept.sh <configuration> <scenario> <run number> <interventions> <cost in USD> [duration in seconds]
# Copies the held-out acceptance tests into the run's worktree, builds, runs every test,
# checks the scope, and appends one line to runs.csv in the starter folder. Changes nothing else.
config=$1; scenario=$2; run=$3; interventions=${4:-0}; cost=${5:-}; duration=${6:-}
here=$(pwd)
starter=$(cd "$(dirname "$0")/.." && pwd)
worktree="$here/../eval-$config-$scenario-$run"
acceptance="$starter/scenarios/$scenario/acceptance"
[ -d "$worktree" ] || { echo "No worktree at $worktree" >&2; exit 64; }
cd "$worktree" || exit 1

# Scope. Every changed or new path must start with one of the paths in scope.txt.
scope_ok=1
for path in $(git status --porcelain | cut -c4-); do
    inside=0
    for allowed in $(cat "$starter/scenarios/$scenario/scope.txt"); do
        case "$path" in "$allowed"*) inside=1 ;; esac
    done
    [ $inside -eq 1 ] || { scope_ok=0; echo "outside scope: $path" >&2; }
done

cp "$acceptance"/*.swift "$(cat "$acceptance/destination.txt")/"

build_ok=0
swift build --build-tests --scratch-path .build/accept >.build-accept.txt 2>&1 && build_ok=1

passed=0; total=$(grep -c '^@Test' "$acceptance"/*.swift); suite_ok=0
if [ $build_ok -eq 1 ]; then
    swift test --scratch-path .build/accept >.test-accept.txt 2>&1
    passed=$(grep -cE "Test accept_[A-Za-z0-9_]+\(\) passed" .test-accept.txt)
    # The suite is the tests that existed before the run. A failing acceptance test does not count here.
    regressions=$(grep -E "Test [A-Za-z0-9_]+\(.*\) failed" .test-accept.txt | grep -vc "accept_")
    [ "$regressions" -eq 0 ] && suite_ok=1
fi
rm -f "$(cat "$acceptance/destination.txt")"/Acceptance*.swift .build-accept.txt .test-accept.txt

[ -f "$starter/runs.csv" ] || echo "configuration,scenario,run,build_ok,acceptance_passed,acceptance_total,suite_ok,scope_ok,interventions,cost_usd,duration_s" >"$starter/runs.csv"
line="$config,$scenario,$run,$build_ok,$passed,$total,$suite_ok,$scope_ok,$interventions,$cost,$duration"
echo "$line" >>"$starter/runs.csv"
echo "$line"
