#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SIMDIR="$REPO_ROOT/xschem/simulation"

rm -f "$SIMDIR"/*.raw "$SIMDIR"/*.log "$SIMDIR"/*.vcd "$SIMDIR"/*.vvp "$SIMDIR"/counter

echo "OK: cleaned simulation artifacts"
