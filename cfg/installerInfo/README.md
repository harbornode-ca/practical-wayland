## Installer Info Files

Third-party sources, keys, pinned versions, and install templates. Not Debian release sources (those live in `../debianAPT/`).

- `debian.id` / `debian.name` - installer target release (`forky` / `Forky`).
- `charm.gpg` / `charm.sources` - Charmbracelet APT repo (provides `gum`).
- `dms.sources` - DankLinux (DMS) repo for Niri builds.
- `git-commits.csv` - pinned `name,url,commit` for source builds: `lemurs`, `rat-commander`, `xwayland-satellite`, `lazy-git`, `lazy-spotify`.
- `nvidia.url` - CUDA keyring `.deb` URL for the NVIDIA driver path.
- `niri-install.csv` - `source,destination` pairs for Niri artifacts (binary, session file, `wayland-sessions/*.desktop`, portal config, systemd user units).
- `lemurs-config.toml` - default Lemurs login-manager config.
- `fontconfig-rm.list` / `fontconfig-add.csv` - bitmap-font blocklist removals and `src,dst` links applied by `scripts/2609181622.sh`.
- `winapps-compose.yaml` / `winapps.conf` / `winapps.url` - WinApps container definition, RDP config template, and upstream installer URL.
- `lazy-spotify.url` - patched `go-librespot` binary tarball URL.
- `opencode.dlr` - one-line Opencode installer (`curl ... | bash`).
