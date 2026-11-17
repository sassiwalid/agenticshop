#!/bin/sh
# Configuration B, instructed. The instruction files and the scripts of modules 2 to 5,
# without hooks. The agent is told how to verify, and nothing makes it do so.
set -e
cd "$1"
if [ -f .claude/settings.json ]; then
    jq 'del(.hooks)' .claude/settings.json > .claude/settings.tmp && mv .claude/settings.tmp .claude/settings.json
    git add .claude/settings.json
fi
git commit -q --allow-empty -m "Configuration B, instructed"
