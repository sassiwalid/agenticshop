#!/bin/sh
# Configuration C, full. Everything the course built. Instruction files, the gate,
# the hooks of module 5, the skill and the security rules if you added them.
set -e
cd "$1"
git commit -q --allow-empty -m "Configuration C, full"
