# scripts/menus

Entry points for the installer.

| Script | Purpose |
| --- | --- |
| `initial.sh` | Bootstrap as root: base packages, `/opt/kevrevrun` layout, `setup.sh` download, `gum` install. |
| `setup.sh` | Stage dispatcher via `/opt/kevrevrun/status/setup.stage` (stages 1-3 active, 4 reserved, 5-30 placeholders). |
| `de-select.sh` | Stub for desktop environment selection. |
