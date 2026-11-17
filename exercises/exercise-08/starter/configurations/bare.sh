#!/bin/sh
# Configuration A, bare. The code and its documentation, without any harness.
# Removes the instruction files, the Claude Code settings, hooks and skills.
# The scripts stay on disk, but nothing tells the agent they exist.
set -e
cd "$1"
git rm -q --ignore-unmatch AGENTS.md CLAUDE.md 'Packages/*/AGENTS.md' 'Packages/*/CLAUDE.md'
git rm -q -r --ignore-unmatch .claude .agents
git commit -q -m "Configuration A, bare"
