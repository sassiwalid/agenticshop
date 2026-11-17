#!/bin/sh
# Prepares one run. Usage, from the root of your clone:
#   ../exercise-08/eval/new-run.sh <configuration> <scenario> <run number>
# Example: ../exercise-08/eval/new-run.sh bare s1-empty-the-cart 1
# Creates a worktree next to the clone, from the tag eval-base, applies the configuration
# and prints the path of the worktree and of the mission to give the agent.
set -e
config=$1; scenario=$2; run=$3
here=$(pwd)
starter=$(cd "$(dirname "$0")/.." && pwd)
name="eval-$config-$scenario-$run"
worktree="$here/../$name"
[ -f "$starter/scenarios/$scenario/mission.md" ] || { echo "Unknown scenario $scenario" >&2; exit 64; }
[ -x "$starter/configurations/$config.sh" ] || { echo "Unknown configuration $config" >&2; exit 64; }
git -C "$here" worktree add -q "$worktree" -b "$name" eval-base
"$starter/configurations/$config.sh" "$worktree"
echo "worktree  $worktree"
echo "mission   $starter/scenarios/$scenario/mission.md"
