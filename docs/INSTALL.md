# Installation and prerequisites

This tutorial focuses on *how to wire the flow*, not on maintaining distro-specific install commands.
Tool packaging changes over time. The safest path is to use a known-good environment (for example,
a prebuilt EDA container used by the open-source silicon community).

## Required tools

You need the following installed and available on your `PATH`:

- `xschem` (tested with 3.4.x)
- `ngspice` built with **XSPICE code models** (tested with ngspice-45)
- `iverilog` and `vvp` (Icarus Verilog)

Verify:

```bash
xschem --version
ngspice -v | head -n 2
iverilog -V | head -n 2
```

## PDK / device symbols

The example analog testbench uses **IHP SG13G2** low-voltage NMOS symbols (`sg13_lv_nmos`)
and therefore requires:

- IHP SG13G2 PDK installed (commonly via OpenPDKs)
- Xschem symbols directory `sg13g2_pr` available on your system

Typical locations (these are environment-specific):

- `/usr/local/share/OpenPDKs/IHP-Open-PDK/ihp-sg13g2/libs.tech/xschem`
- `/usr/local/share/OpenPDKs/IHP-Open-PDK/ihp-sg13g2/libs.tech/xschem/sg13g2_pr`

If you do not have the IHP PDK installed yet, follow the official OpenPDKs/IHP instructions used by your environment.
This repository does **not** include PDK files.

## Xschem library search paths

Xschem resolves symbols through its **Tcl variable** `XSCHEM_LIBRARY_PATH`.
Setting the shell environment variable is often not enough if `~/.xschem/xschemrc` overrides it.

This repo provides a helper:

```bash
./scripts/setup_xschem_paths.sh
```

It appends a “user override” block to `~/.xschem/xschemrc` and points Xschem to:

- this repository's `xschem/` directory (project symbols)
- the system Xschem libraries (`xschem_library` and `devices`)
- the IHP SG13G2 Xschem libraries (`libs.tech/xschem` and `sg13g2_pr`)

After running it, **restart Xschem**.
