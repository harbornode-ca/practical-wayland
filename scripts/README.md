# Scripts Directory

Modules that perform each install step. They are invoked by `setup.sh` (stage dispatcher) and are not intended to run standalone.

Each script follows the same pattern: `cmdFail` helper that checks `$?` via `exitStat`, prints `errMsg` / `successMsg`, and exits on failure.

Note: `setup.sh` stages 2 and 3 call `2609180906.sh` and `2609180910.sh`, which are not present in this directory (the closest files are `2609180904.sh` and `2609180905.sh`). Verify stage-to-file mapping before running.

## Installation scripts

### 2609180902.sh

Initializes the install environment.

- Confirms `/opt/kevrevrun/{cfg,status,scripts,tmp,logs}`, repairs `id.usr`, `name.usr`, `status/setup.stage`, `setup.dir` if missing (`scripts/2609180902.sh:8-51`).
- Writes `status/folders.list`, `status/files.list`, `status/values.list` and exports them (`scripts/2609180902.sh:56-160`).
- Clones `https://github.com/harbornode-ca/practical-wayland.git` into `$tmpDir`, copies `scripts/*` and `cfg/*` into `/opt/kevrevrun/`, then removes the clone (`scripts/2609180902.sh:166-199`).

### 2609180904.sh

APT source migration and Forky upgrade.

- Deletes legacy `sources.list*` files outside `sources.list.d/`, removes `/etc/apt/sources.list.d/debian.sources` if present (`scripts/2609180904.sh:25-45`).
- Copies the Forky `.sources` file to `/etc/apt/sources.list.d/forky.sources`, then `apt update` and `apt upgrade` if upgrades are advertised (`scripts/2609180904.sh:50-75`).
- Prints a reboot-required message on completion; it does not reboot itself and installs no firmware packages.
- Known discrepancy: line 50 reads `$cfgDir/debian-sources/enabledForky.sources`, but the repo stores the file at `cfg/debianAPT/enabledForky.sources`.

### 2609180905.sh

Rust toolchain.

- If `$HOME/.cargo` exists, runs `rustup update`; otherwise downloads `https://sh.rustup.rs` to `$tmpDir/rustup.sh` and runs it with `-y` (`scripts/2609180905.sh:27-72`).
- Runs `cargo install just`, copies `$HOME/.cargo/bin/just` to `/usr/local/sbin/just` for `sudo` use, then deletes `$tmpDir/rustup.sh` (`scripts/2609180905.sh:76-94`).

### 2609180912.sh

32-bit architecture support.

- Runs `dpkg --add-architecture i386` (needed for Steam and some NVIDIA components) and updates the APT cache (`scripts/2609180912.sh:24-35`).

### 2609180913.sh

GPU drivers.

- Probes `lspci` for Intel / AMD / NVIDIA VGA adapters and prints each result (`scripts/2609180913.sh:23-46`).
- Intel: installs packages from `$swAptDir/gpuIntel.apt`. AMD: installs `$swAptDir/gpuAMD.apt` (`scripts/2609180913.sh:70-97`).
- NVIDIA: downloads the CUDA keyring from the URL in `$installDir/nvidia.url`, installs it with `dpkg -i`, updates APT, installs `$swAptDir/gpuNVIDIA.apt`, then installs `nvidia-open` (`scripts/2609180913.sh:98-153`).
- If no adapter matches it prints "No GPU detected" and continues to the completion message; it does not exit early. End message says a reboot is required.

### 2609180915.sh

Desktop environment selector (temporary menu).

- Menu offers `1. Noctalia`, `2. Niri /w Ashell Status Bar`, `3. lxqt w/ niri wm` (`scripts/2609180915.sh:14-22`).
- Stored label for option 2 is `Niri /w Flatbar`, not `Ashell` (`scripts/2609180915.sh:42`, `100-108`). Keep this naming mismatch in mind when reading logs.
- Selection is stored in `/opt/kevrevrun/status/selDE.status`.
- Known discrepancies: choices 1 and 2 invoke `$scriptDir/07-script.sh` and `$scriptDir/08-script.sh`, which are not in this directory; option 3 is commented out and re-prompts with "Installation script not yet implimented".

### 2609180916.sh

Noctalia stack.

- Downloads `nickh-archive-keyring.deb` from `pkg.noctalia.dev`, installs it with `dpkg -i`, downloads `noctalia-unstable.sources` and moves it to `/etc/apt/sources.list.d/` (`scripts/2609180916.sh:28-55`).
- Runs `apt update` and installs `noctalia noctalia-greeter umbriel xdg-desktop-portal-umbriel` (`scripts/2609180916.sh:60-75`).
- Removes the downloaded keyring and sources temp files.

### 2609180937.sh

Lemurs login manager from source.

- Installs deps from `$swAptDir/lemurs.apt`, clones the URL and checks out the tag from the `lemurs` row of `$installDir/git-commits.csv`, then `cargo build --release` (`scripts/2609180937.sh:31-69`).
- Copies `target/release/lemurs` to `/usr/bin/lemurs`, creates `/etc/lemurs/wayland` and `/etc/lemurs/wms`, installs the PAM module, copies `$installDir/lemurs-config.toml` to `/etc/lemurs/config.toml`, and installs the systemd service (`scripts/2609180937.sh:75-118`).
- Runs `systemctl daemon-reload` and `systemctl enable --now lemurs.service` (`scripts/2609180937.sh:122-131`).

### 2609180944.sh

Niri from source (not from APT).

- Despite the header comment mentioning the DankLinux repository, the body installs build deps from `$swAptDir/niri-build.apt`, clones `https://github.com/niri-wm/niri.git`, checks out hardcoded commit `ee8a04bbaa9a20c53b9544cdd098ff54d8c509b4`, and runs `cargo build --release` (`scripts/2609180944.sh:36-46`).
- Copies artifacts per `$installDir/niri-install.csv` (binary, session file, desktop entry, portal config, systemd user units) (`scripts/2609180944.sh:47-53`).
- Does not install `xwayland-satellite`; that is `2609181656.sh`.

### 2609181116.sh

BlueTUI Bluetooth TUI only.

- Despite the header describing a Flatbar status bar with foot, fuzzel, mako, and file managers, the body only runs `cargo install bluetui` and copies `$HOME/.cargo/bin/bluetui` to `/usr/bin/` (`scripts/2609181116.sh:31-45`).
- Inline comments state Ashell will get its own from-source script and BlueTUI will move to optional software (`scripts/2609181116.sh:28-30`).

### 2609181123.sh

Rat Commander file manager from source.

- Installs deps from `$swAptDir/rc.apt`, clones the URL and checks out the tag from the `rat-commander` row of `$installDir/git-commits.csv`, runs `cargo build --release`, and copies `target/release/rc` to `/usr/bin/rc` (`scripts/2609181123.sh:27-74`).
- Header notes it is being moved to optional software pending more testing (`scripts/2609181123.sh:19-20`).

### 2609181124.sh

WinApps via Dockur Windows container and Podman.

- Ensures `podman` and `podman-compose` are installed, then installs deps from `$swAptDir/winapps.apt` (`scripts/2609181124.sh:25-90`).
- Prompts for `RDP_USER` / `RDP_PASS` and patches `$installDir/winapps.conf`; prompts for Windows version (default `11`), RAM (`8G`), CPUs (`6`), disk (`128G`) and patches `$installDir/winapps-compose.yaml` (`scripts/2609181124.sh:67-180`).
- Copies both files to `$HOME/.config/winapps/` (`winapps.conf` mode `600`, `compose.yaml` mode `700`, user-owned), then starts the VM with `podman-compose up -d` (`scripts/2609181124.sh:122-209`).
- Header notes this should become optional with a resource check (`scripts/2609181124.sh:21-24`). See `ref/winapps.md` for container lifecycle commands.

### 2609181622.sh

Bitmap font support.

- Removes every file listed in `cfg/installerInfo/fontconfig-rm.list` (`scripts/2609181622.sh:19-31`).
- Links each `src,dst` pair from `cfg/installerInfo/fontconfig-add.csv` with `ln` and refreshes with `fc-cache -fv` (`scripts/2609181622.sh:34-48`).
- Note: lines 31 and 41 use the relative path `cfg/installerInfo/...`, so the script only works when run from the repo root.

### 2609181656.sh

Xwayland Satellite from source.

- Installs deps from `$swAptDir/xwayland-satellite.apt` with `--no-install-recommends`, clones the URL and checks out the tag from the `xwayland-satellite` row of `$installDir/git-commits.csv`, runs `cargo build --release`, and copies `target/release/xwayland-satellite` to `/usr/bin/` (`scripts/2609181656.sh:20-63`).
- See `ref/xwayland-satellite.md` for XSETTINGS background.

## Dev tools (`dev-tools/`)

Helpers for development and testing. Not part of the normal install.

- `clear-lemurs.sh` - removes Lemurs binary, PAM file, and `/etc/lemurs`.
- `clear-noctalia.sh` - purges `noctalia`, `noctalia-greeter`, `umbriel`, `xdg-desktop-portal-umbriel`, then `autopurge`.
- `cp-from-dev.sh` - copies the local checkout (`$HOME/practical-wayland`) into `/opt/kevrevrun/` to test without commit/push.
- `script-template.sh` - `cmdFail` + status boilerplate for new modules.
- `variable-loader.sh` - loads folder/file/status variables from `/opt/kevrevrun/status/` (`folders.list`, `files.list`, `values.list`).
