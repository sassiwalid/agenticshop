#!/bin/sh
# Claude Code PostToolUse hook, for Edit and Write.
# After an edit to a Swift file, build the package and its tests. If the build fails,
# exit with 2. Claude Code then shows the errors to the agent before its next step.
file=$(jq -r '.tool_input.file_path // empty')
case "$file" in
    *.swift) ;;
    *) exit 0 ;;
esac
cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0
mkdir -p .build
if swift build --build-tests --scratch-path .build/hook >.build/hook-build.txt 2>&1; then
    exit 0
fi
echo "The build fails after this edit." >&2
perl -pe 's/\e\[[0-9;]*m//g' .build/hook-build.txt | sed "s|$PWD/||g" \
    | grep -E "^[^ ].*:[0-9]+:[0-9]+: error: " | sort -u | head -15 >&2
exit 2
