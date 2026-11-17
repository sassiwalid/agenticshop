#!/bin/sh
# Runs one prepared run with Claude Code and no person watching. Usage, from the root of your clone:
#   ../exercise-08/eval/run-headless.sh <configuration> <scenario> <run number> <budget in USD>
# The agent works in the run's worktree. Its final JSON result is saved next to the worktree,
# and the cost it reports is printed, ready for accept.sh. Interventions are 0 by definition.
set -e
config=$1; scenario=$2; run=$3; budget=${4:-1}
starter=$(cd "$(dirname "$0")/.." && pwd)
worktree="$(pwd)/../eval-$config-$scenario-$run"
result="$worktree.result.json"
cd "$worktree"
start=$(date +%s)
claude -p "$(cat "$starter/scenarios/$scenario/mission.md")" \
    --output-format json \
    --max-budget-usd "$budget" \
    --permission-mode acceptEdits \
    --allowedTools "Bash(swift build *)" "Bash(swift test *)" "Bash(Scripts/*)" "Bash(git status *)" "Bash(git diff *)" \
    >"$result" || true
end=$(date +%s)
echo "cost_usd   $(jq -r '.total_cost_usd // empty' "$result")"
echo "duration_s $((end - start))"
echo "result     $result"
