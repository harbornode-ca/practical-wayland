# data

Installer data consumed by the modules. Debian release sources live in `../cfg/apt/`.

| Directory | Contents |
| --- | --- |
| `apt/` | Per-component package lists (`*.apt`): `niri-build`, `niri-runtime`, `ashell-*`, `gpu*`, `lemurs`, `noctalia*`, `rc`, `winapps`, `xwayland-satellite`, `lazy-spotify`. |
| `csv/` | `git-commits.csv` (pinned source commits), `niri-install.csv` (install destinations), `fontconfig-add.csv`. |
| `extra/` | `debian.id` / `debian.name` (target release), `fontconfig-rm.list`, `opencode.dlr`. |
| `repositories/` | Third-party APT sources (`charm.sources`) and keys (`keys/charm.gpg`). |
| `url/` | Upstream URLs: `nvidia.url`, `winapps.url`, `lazy-spotify.url`. |
| `containers/compose/` | `winapps-compose.yaml` container definition. |
