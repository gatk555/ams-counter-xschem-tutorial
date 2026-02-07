# Troubleshooting

## 1) `MISSING SYMBOL` boxes appear in Xschem

Cause: Xschem cannot find the `.sym` files because its library search path is incomplete.

Fix:
1. Run `./scripts/setup_xschem_paths.sh`
2. Restart Xschem
3. In Xschem Tcl console, verify:

```tcl
puts $XSCHEM_LIBRARY_PATH
```

Common missing paths:
- `/usr/share/xschem/xschem_library`
- `/usr/share/xschem/xschem_library/devices`
- the PDK symbol folder (example: `.../libs.tech/xschem/sg13g2_pr`)

---

## 2) `echo $XSCHEM_LIBRARY_PATH` prints nothing

This is not necessarily a problem.

Xschem uses a Tcl variable `XSCHEM_LIBRARY_PATH` usually set in `~/.xschem/xschemrc`.
Your shell environment variable may be unset, while Xschem still has the correct path.

Check inside Xschem instead:

```tcl
puts $XSCHEM_LIBRARY_PATH
```

---

## 3) Grep for `set/append XSCHEM_LIBRARY_PATH` returns nothing

If your `~/.xschem/xschemrc` contains only commented examples (lines starting with `#`),
a regex that matches only non-comment lines will return nothing. That is expected.

Example that intentionally ignores comments:

```bash
grep -nE '^[^#].*(set|append)[[:space:]]+XSCHEM_LIBRARY_PATH' ~/.xschem/xschemrc
```

---

## 4) `d_cosim` not found / Ngspice errors about code models

Cause: Ngspice was built without XSPICE code model support.

Fix: use an Ngspice build that includes XSPICE. Many EDA containers provide this.
There is no workaround inside the schematic; `d_cosim` requires XSPICE.

---

## 5) Ctrl + click does not trigger the `tclcommand`

Depending on your Xschem version and key bindings:
- some actions use Ctrl + click
- some use Shift + click
- some use right-click context menus

To confirm the symbol has a command, select it and press `q` and verify `tclcommand=...`.

---

## 6) Counter outputs are stuck, or the Verilog prints only `initial`

Most common cause: the Verilog was not compiled before running Ngspice.

Fix:
- Run the compile launcher (**Icarusate Design**) or run:

```bash
cd xschem
iverilog -o counter counter.v
```

Then rerun the Ngspice simulation.

---

## 7) Digital nodes look analog (sloped edges) or create glitches

This is normal if you load digital outputs with analog elements (caps/resistors) or if you use finite rise/fall on sources.
If you want ideal digital edges, keep the interface nodes lightly loaded.
If you want realism, add RC loading intentionally and observe its effect.
