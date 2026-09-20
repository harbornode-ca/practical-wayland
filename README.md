# Practical Wayland

**A practical installer for Wayland environments on Debian.**

*Installs Wayland setups with GPU drivers, login manager, and Wayland session files for multiple wayland native desktop environments.*

---

## Requirements

- Debian stable minimal install with internet access.
- Run `scripts/menus/initial.sh` as root. Log in as the created sudo user for `scripts/menus/setup.sh`.
- Packages bootstrapped by `initial.sh`: `sudo`, `git`, `wget`, `curl`, `gpg`, `tmux`, `unzip`, `build-essential`, `fonts-nerd-symbols`, `fonts-font-awesome`, `firmware-linux`, plus Charmbracelet `gum` 0.17.0.

---

## Quickstart

```bash
# 1. As root, from a clone of this repo:
bash scripts/menus/initial.sh
# Creates /opt/kevrevrun/{cfg,status,scripts,tmp,logs},
# writes id.usr / name.usr / status/setup.stage,
# downloads setup.sh, installs gum, then reboots.

# 2. After reboot, log in as the sudo user:
sudo ./setup.sh
# Stage dispatcher. Stage 1 fetches the init module,
# stage 2 deploys installer files and reboots,
# stage 3 enables i386 arch, stage 4 migrates to Forky.
```

State is tracked in `/opt/kevrevrun/status/setup.stage`. Re-run `setup.sh` after each reboot to continue.

---

## Desktop choices

Desktop environment selection is under construction.

| Option | Stack | Status |
| --- | --- | --- |
| Noctalia | Greeter + Umbriel compositor + shell; Niri included for stability, xwayland-satellite for X11 | Repo and Niri scripts ready; dispatcher wiring in progress |
| Niri + Ashell | Lemurs + niri + Ashell, xwayland-satellite | Niri/Lemurs/xwayland-satellite ready; Ashell build pending |
| LXQt + niri | LXQt panel/PCManFM-Qt with niri compositor, xwayland-satellite | Niri/xwayland-satellite ready; LXQt integration in progress |

---

## Repository layout

| Path | Purpose |
| --- | --- |
| `scripts/menus/initial.sh` | Root bootstrap: users, dirs, `setup.sh` download, `gum` install. |
| `scripts/menus/setup.sh` | Multi-stage orchestrator (stages 1-30). |
| `scripts/` | Install modules. See `scripts/README.md`. |
| `cfg/` | APT sources and default configs. See `cfg/README.md`. |
| `data/` | Package lists, pinned commits, URLs, templates. See `data/README.md`. |
| `ref/` | Background notes. See `ref/README.md`. |
| `tools/` | Maintenance helpers. See `tools/README.md`. |

---

## CLI Documentation

Charmbracelet `gum` provides the CLI (`confirm`, `choose`, `style`, `spin`). Defaults are in `ref/gumVariables.md` and applied via `prt_info` + `gum style`. See `ref/gum.md` and `ref/gum-log.md` for full flags and variables.

Message types: `info` (white), `msg` (yellow), `win` (green), `lose` (red).

## Notes

1. **Install modules** - Install modules under `scripts/` are not meant to run standalone; run them via `setup.sh`.
2. **Pinned source commits** - Pinned source commits are listed in `data/csv/git-commits.csv`.
3. **Optional software candidates** - Optional software candidates are tracked in `ref/software.md`.
