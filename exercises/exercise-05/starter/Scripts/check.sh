#!/bin/sh
# Quality gate of AgenticShop. One command, one answer.
# Exits with 0 when every check passes, with 1 otherwise.
# It prints one line per check, and only the lines that explain a failure.
cd "$(dirname "$0")/.." || exit 1
logs=.build/check/logs
mkdir -p "$logs"
failed=0

pass() { echo "PASS  $1"; }
fail() { echo "FAIL  $1"; failed=1; }

# Removes terminal colors and the project path, so a line reads file:line:column: message.
plain() { perl -pe 's/\e\[[0-9;]*m//g' "$1" | sed "s|$PWD/||g"; }

# 1. Every target builds, tests included, with no warning and no undeclared import.
if swift build --build-tests --scratch-path .build/check --explicit-target-dependency-import-check error \
    -Xswiftc -warnings-as-errors >"$logs/build.txt" 2>&1; then
    pass "build, tests included, warnings as errors"
else
    fail "build, tests included, warnings as errors"
    plain "$logs/build.txt" | grep -E "^[^ ].*:[0-9]+:[0-9]+: error: " | sort -u | head -15
fi

# 2. Every test passes. Skipped when the build failed, since nothing would run.
if [ $failed -eq 0 ]; then
    if swift test --scratch-path .build/check >"$logs/test.txt" 2>&1; then
        pass "tests"
    else
        fail "tests"
        # The failing expectation, then the values Swift Testing printed for each side of it.
        plain "$logs/test.txt" | grep -E "recorded an issue|^↳ {1,3}[^ ]" | grep -vE "Testing Library Version|Target Platform" | head -30
    fi
else
    echo "SKIP  tests, the build failed"
fi

# 3. No test file changed since the last commit. The tests are the specification.
changed=$(git status --porcelain -- 'Packages/*/Tests/*' | grep -v '^??')
if [ -z "$changed" ]; then
    pass "tests unchanged since the last commit"
else
    fail "tests unchanged since the last commit"
    echo "$changed"
fi

# 4. Every requirement of every feature specification has a test named after it.
missing=""
for id in $(grep -hoE '^\| [A-Z]+-[0-9]+ \|' Documentation/Features/*.md | grep -oE '[A-Z]+-[0-9]+' | sort -u); do
    name=$(echo "$id" | tr 'A-Z' 'a-z' | tr -d '-')
    grep -rqE "func ${name}_" Packages/*/Tests || missing="$missing $id"
done
if [ -z "$missing" ]; then
    pass "every requirement has a test"
else
    fail "every requirement has a test, missing$missing"
fi

exit $failed
