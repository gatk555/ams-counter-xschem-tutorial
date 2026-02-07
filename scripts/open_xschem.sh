#!/usr/bin/env bash
set -euo pipefail

# Convenience wrapper to open the demo schematic with AMS_DEMO_HOME set.

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export AMS_DEMO_HOME="$REPO_ROOT"

exec xschem "$REPO_ROOT/xschem/current_mirror_cosim.sch"
