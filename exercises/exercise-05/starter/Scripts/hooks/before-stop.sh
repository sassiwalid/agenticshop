#!/bin/sh
# Claude Code Stop hook. Runs the quality gate before the agent may end its turn.
# A failing gate exits with 2, and its short report becomes the agent's next input.
# The same failure twice in a row lets the agent stop, so that it reports instead of looping.
input=$(cat)
cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0
mkdir -p .build
report=$(Scripts/check.sh 2>&1)
if [ $? -eq 0 ]; then
    rm -f .build/last-gate-failure.txt
    exit 0
fi
if [ "$(echo "$input" | jq -r '.stop_hook_active')" = "true" ] \
    && [ "$report" = "$(cat .build/last-gate-failure.txt 2>/dev/null)" ]; then
    exit 0
fi
echo "$report" >.build/last-gate-failure.txt
printf 'Scripts/check.sh fails. Fix the code, not the tests.\n%s\n' "$report" >&2
exit 2
