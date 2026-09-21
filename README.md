# Practical Wayland Tools

**A practical installer & Maintainance Tool for Wayland environments on Debian.**

*Installs Wayland setups with GPU drivers, login manager, and Wayland session files for multiple wayland native desktop environments.*

---

## Desktop choices

Desktop environment selection is under construction.

| Option | Stack | Status |
| --- | --- | --- |
| Noctalia | Greeter + Umbriel compositor + shell; Niri included for stability, xwayland-satellite for X11 | *In Progress* |
| Niri + Ashell | Lemurs + niri + Ashell, xwayland-satellite | *In Progress* |
| LXQt + niri | LXQt panel/PCManFM-Qt with niri compositor, xwayland-satellite | *In Progress* |

---

## CLI Documentation

Charmbracelet `gum` provides the CLI (`confirm`, `choose`, `style`, `spin`). Defaults are in `ref/gumVariables.md` and applied via `prt_info` + `gum style`. See `ref/gum.md` and `ref/gum-log.md` for full flags and variables.

Message types: `info` (white), `msg` (yellow), `win` (green), `lose` (red).
