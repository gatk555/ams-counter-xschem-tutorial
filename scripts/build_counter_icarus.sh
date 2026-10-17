#!/usr/bin/env bash
set -euo pipefail

# Build the Verilog module with Icarus, matching the Xschem launcher behavior.
# Output binary: xschem/simulation/counter

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SIMDIR="$REPO_ROOT/xschem/simulation"
VERILOG="$REPO_ROOT/xschem/counter.v"
OUT="$SIMDIR/counter"

mkdir -p "$SIMDIR"
cd "$SIMDIR"

echo "[iverilog] compiling: $VERILOG -> $OUT"
iverilog -o "$OUT" "$VERILOG"

echo "OK: built $OUT"
