# AMS Co-simulation in Xschem: Verilog Counter + Ngspice (Icarus + d_cosim)

This repository is intended as a beginner-friendly, end-to-end example of **mixed-signal co-simulation (AMS)** using:

- **Xschem** a graphical tool for schematic capture and plotting
- **Ngspice** (with **XSPICE code models**) for analog simulation
- **Icarus Verilog** for the digital model, linked into an Ngspice simulation.

It describes the steps to build and run a simple **4-bit synchronous counter** written in Verilog, embed it as a symbol in Xschem, and drive an **analog current-mirror testbench** that converts the counter bits into a measurable analog current.

## What is here

- A minimal Verilog counter ([`xschem/counter.v`](xschem/counter.v))
- A reusable Xschem symbol (`xschem/counter.sym`) and example schematic (`xschem/current_mirror_cosim.sch`)
- A working netlist ([`xschem/simulation/current_mirror_cosim.spice`](xschem/simulation/current_mirror_cosim.spice)). This is the input file for Ngspice.
- Launchers inside the schematic for:
  - compiling Verilog with Icarus (`Icarusate Design`)
  - loading simulation results back into Xschem (`Load waves`)
- Scripts to check the environment

## Quick start (tools already installed)

```bash
# 1) (Optional) sanity check your environment
./scripts/check_install.sh

# 2) open the schematic
xschem xschem/current_mirror_cosim.sch
```

Inside Xschem:

1. **Ctrl + click** the `Icarusate design` launcher to compile `counter.v` into an Icarus executable.
2. Generate the SPICE netlist (menu bar button **Netlist**)
3. Run the simulation (menu bar button button **Simulation**)
4. **Ctrl + click** `Load waves` to load the `.raw` file and see the plots.


## Optional: run a pure-digital Verilog test

If you want to validate the counter without Ngspice:

```bash
cd xschem
iverilog -g2012 -o tb ../verilog/tb_counter.v counter.v
vvp tb
```

## Repository layout

```text
.
├── xschem/
│   ├── counter.v                     # Verilog counter (DUT)
│   ├── counter.sym                   # Xschem symbol for the counter
│   ├── current_mirror_cosim.sch      # Example AMS schematic (analog + DUT)
│   └── simulation/
│       └── current_mirror_cosim.spice # Generated/standalone spice netlist
├── docs/
│   ├── INSTALL.md
│   ├── TUTORIAL.md
│   └── TROUBLESHOOTING.md
├── scripts/
│   ├── check_install.sh
│   └── setup_xschem_paths.sh
├── Makefile
└── LICENSE
```

## Documentation

- Start here: [`TUTORIAL.md`](docs/TUTORIAL.md)
- Installation notes: [`INSTALL.md`](docs/INSTALL.md)
- Possible failures and fixes: [`TROUBLESHOOTING.md`](docs/TROUBLESHOOTING.md)

## Why this example may be useful

Most “AMS” tutorials are either too abstract or assume commercial EDA tools. This repo is intentionally small and explicit:
- **every file** is visible
- it runs on **open-source tools**
- you can adapt the pattern to your own Verilog blocks (FSMs, counters, serializers, etc.)

## Contributing

PRs are welcome. See [`CONTRIBUTING.md`](CONTRIBUTING.md).

## License

MIT License. See [`LICENSE`](LICENSE).
