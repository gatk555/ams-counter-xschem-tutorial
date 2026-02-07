# Contributing

Thanks for considering a contribution.

## Scope

This repository is intentionally small and focused on one goal:
a reproducible open-source AMS co-simulation example using Xschem + Ngspice + Icarus.

Good contributions include:
- clearer docs and diagrams
- small improvements to scripts (portability, error messages)
- additional examples (resettable counter, FSM, PWM) that remain beginner-friendly
- fixes for path/config issues across common environments

Avoid:
- adding PDK files or proprietary content
- turning this repo into a large “framework”

## Development workflow

1. Fork the repo
2. Create a branch: `git checkout -b feature/your-change`
3. Make changes
4. Run:
   - `./scripts/check_install.sh`
   - open Xschem and run the co-sim
5. Submit a PR with:
   - what changed
   - why it matters
   - screenshots/log snippets if relevant

## Style

- Prefer clear, explicit steps over “magic”
- Keep examples minimal
- Use consistent naming (`count_out0` .. `count_out3`, `clk`, etc.)
