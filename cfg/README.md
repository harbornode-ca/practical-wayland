## Config Folder

Source data consumed by `initial.sh`, `setup.sh`, and the modules in `scripts/`.

| Directory | Purpose |
| --- | --- |
| `debianAPT/` | Debian release `.sources` files (Forky/Sid/Trixie, enabled/disabled). See `debianAPT/README.md`. |
| `softwareAPT/` | Per-component APT package lists (`*.apt`, one package per line). See `softwareAPT/README.md`. |
| `defaultConfig/` | Default application configs deployed to the system (currently `niri/`). See `defaultConfig/README.md`. |
| `installerInfo/` | Keys, third-party sources, pinned commits, URLs, and templates. See `installerInfo/README.md`. |
| `systemTheme/` | Theme files. See `systemTheme/README.md`. |
