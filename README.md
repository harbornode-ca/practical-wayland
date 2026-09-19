# Practical Wayland

A practical installer for Wayland environments on Debian.

Targets Debian Forky (testing), see `cfg/installerInfo/debian.id`. Installs Wayland setups with GPU drivers, login manager, and Wayland session files.

## Requirements

- Debian Trixie minimal install with internet access.
- Run `initial.sh` as root. Log in as the created sudo user for `setup.sh`.
- Packages bootstrapped by `initial.sh`: `sudo`, `git`, `wget`, `curl`, `gpg`, `whiptail`, `tmux`, `unzip`, `build-essential`, `fonts-font-awesome`, `firmware-linux`, plus Charmbracelet `gum` 0.17.0.

## Quickstart

```bash
# 1. As root, from a clone of this repo:
bash initial.sh
# Creates /opt/kevrevrun/{cfg,status,scripts,tmp,logs},
# writes id.usr / name.usr / status/setup.stage,
# downloads setup.sh, installs gum, then reboots.

# 2. After reboot, log in as the sudo user:
sudo ./setup.sh
# Stage dispatcher. Stage 1 fetches the init module,
# stage 2 upgrades APT sources to Forky and reboots,
# stage 3 installs Rust via rustup, later stages add
# i386 arch, GPU drivers, desktop environment, and apps.
```

State is tracked in `/opt/kevrevrun/status/setup.stage`. Re-run `setup.sh` after each reboot to continue.

## Desktop choices

No selector menu remains (`scripts/2609180915.sh` was removed). Desktops are installed by individual modules in `scripts/`:

1. Noctalia via `scripts/2609180916.sh` (`noctalia`, `noctalia-greeter`, `umbriel`, `xdg-desktop-portal-umbriel`).
2. Niri from source via `scripts/2609180944.sh` (build deps from `niri-build.apt`, files per `niri-install.csv`), with X11 support via `scripts/2609181656.sh` (Xwayland Satellite).

Umbriel is experimental; Niri is installed alongside it for testing (`scripts/2609180916.sh:5-6`). Lemurs login manager is a separate from-source build (`scripts/2609180937.sh`). There is currently no LXQt module.

## Repository layout

| Path | Purpose |
| --- | --- |
| `initial.sh` | Root bootstrap: users, dirs, `setup.sh` download, `gum` install. |
| `setup.sh` | Multi-stage orchestrator (stages 1-30). |
| `scripts/` | Install modules, see `scripts/README.md`. |
| `cfg/` | APT sources, package lists, default configs, see `cfg/README.md`. |
| `ref/` | Background notes, see `ref/README.md`. |
| `tools/` | Update/maintenance helpers, see `tools/README.md`. |

## Notes

- Install modules under `scripts/` are not meant to run standalone; run them via `setup.sh`.
- Pinned source commits are listed in `cfg/installerInfo/git-commits.csv`.
- Optional software candidates are tracked in `ref/software.md`.

## License

MIT, see `LICENSE`.
