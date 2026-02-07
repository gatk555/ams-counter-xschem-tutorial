#!/usr/bin/env bash
set -euo pipefail

# Run ngspice in batch mode using the same deck used by Xschem.
# Produces: xschem/simulation/current_mirror_cosim.raw (see .control 'write' command)

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SIMDIR="$REPO_ROOT/xschem/simulation"
DECK="$SIMDIR/current_mirror_cosim.spice"
LOG="$SIMDIR/ngspice_batch.log"

cd "$SIMDIR"

echo "[ngspice] running: $DECK"
ngspice -b -o "$LOG" "$DECK"

echo "OK: log at $LOG"
