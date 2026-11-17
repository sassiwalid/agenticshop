#!/bin/sh
# Claude Code PreToolUse hook. Refuses a few actions before they run, whatever the
# permission rules or the mode say. Exit code 2 blocks the call and shows the reason
# to the agent. It is one layer among several, not a complete boundary.
input=$(cat)
tool=$(echo "$input" | jq -r '.tool_name // empty')
command=$(echo "$input" | jq -r '.tool_input.command // empty')
path=$(echo "$input" | jq -r '.tool_input.file_path // empty')

refuse() {
    echo "Blocked by Scripts/hooks/guard.sh. $1 Stop and tell the user what you were trying to do." >&2
    exit 2
}

case "$path$command" in
    *Secrets.xcconfig*) refuse "The secrets file is out of bounds for agents." ;;
esac

if [ "$tool" = "Bash" ]; then
    case "$command" in
        *"rm -rf"*|*"rm -fr"*|*"rm -r "*) refuse "Recursive deletion needs a person." ;;
        *"git push --force"*|*"git push -f"*) refuse "Force pushes need a person." ;;
        *"git reset --hard"*|*"git clean -f"*) refuse "Discarding work needs a person." ;;
    esac
fi
exit 0
