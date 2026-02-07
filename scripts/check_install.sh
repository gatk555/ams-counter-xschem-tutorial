#!/usr/bin/env bash
set -euo pipefail

say() { printf "\n== %s ==\n" "$*"; }

say "Tools"
command -v xschem >/dev/null && xschem --version || echo "xschem: NOT FOUND"
command -v ngspice >/dev/null && (ngspice -v | head -n 2) || echo "ngspice: NOT FOUND"
command -v iverilog >/dev/null && (iverilog -V | head -n 2) || echo "iverilog: NOT FOUND"
command -v vvp >/dev/null && (vvp -V | head -n 1) || echo "vvp: NOT FOUND"

say "PDK / symbols (paths are examples)"
PDK_BASE="/usr/local/share/OpenPDKs/IHP-Open-PDK/ihp-sg13g2"
if [ -d "$PDK_BASE" ]; then
  echo "IHP SG13G2 found: $PDK_BASE"
  ls -la "$PDK_BASE/libs.tech/xschem/sg13g2_pr" 2>/dev/null | head || true
else
  echo "IHP SG13G2 not found at: $PDK_BASE"
fi

say "d_cosim presence (best-effort)"
if command -v ngspice >/dev/null; then
  # Some builds support 'showmod'; if not, this will just print an error.
  ngspice -b -o /tmp/ngspice_showmod.log -q <<'NGEOF' || true
showmod d_cosim
quit
NGEOF
  tail -n +1 /tmp/ngspice_showmod.log | tail -n 20 || true
fi

say "Done"
