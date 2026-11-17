#!/bin/sh
# Claude Code PreToolUse hook. Appends one JSON line per tool call to a log outside
# the repository, where the agent's sandboxed shell cannot write. Never blocks.
log_dir="$HOME/Library/Logs/agenticshop"
mkdir -p "$log_dir"
jq -c --arg time "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
    '{time: $time, session: .session_id, cwd: .cwd, tool: .tool_name, input: .tool_input}' \
    >>"$log_dir/agent-audit.jsonl"
exit 0
