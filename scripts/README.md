# Scripts Directory

Modules that perform each install step. They are invoked by `setup.sh` (stage dispatcher) and are not intended to run standalone.

Each script follows the same pattern: `cmdFail` helper that checks `$?` via `exitStat`, prints `errMsg` / `successMsg`, and exits on failure.

## Installation scripts

### 2609180902.sh

Initializes the install environment.

- Confirms `/opt/kevrevrun/{cfg,status,scripts,tmp,logs}`.
- Checks `id.usr`, `name.usr`, `status/setup.stage`, `setup.dir`.
- Downloads the repository and places files in their target folders.

### 2609180904.sh

APT source migration and Forky upgrade.

- Removes legacy `sources.list` style files.
- Installs the Forky `.sources` file from `cfg/debianAPT/`.
- Upgrades the system to Debian Forky and installs firmware packages.
- Prompts for reboot on completion.

### 2609180905.sh

Rust toolchain.

- Installs or updates Rust and Cargo via rustup.
- Installs `just` via Cargo and links it for `sudo` use.
- Removes temporary files.

### 2609180912.sh

32-bit architecture support.

- Runs `dpkg --add-architecture i386` (needed for Steam and some NVIDIA components).
- Updates the APT cache.

### 2609180913.sh

GPU drivers.

- Detects Intel / AMD / NVIDIA adapters with `lspci`.
- Installs Mesa for Intel/AMD (`cfg/softwareAPT/gpuIntel.apt`, `gpuAMD.apt`) or the CUDA-keyring path for NVIDIA (`cfg/installerInfo/nvidia.url`, `gpuNVIDIA.apt`).
- Exits early on VMs with no detected adapter.

### 2609180915.sh

Desktop environment selector.

- Prompts for one of: Noctalia, Niri with status bar, LXQt with Niri WM.
- Writes the choice to `/opt/kevrevrun/status/selDE.status` for later stages.

### 2609180916.sh

Noctalia stack.

- Adds the Noctalia APT repo (`pkg.noctalia.dev`, keyring `nickh-archive-keyring.deb`).
- Installs `noctalia`, `noctalia-greeter`, `umbriel`, `xdg-desktop-portal-umbriel`.
- Umbriel is experimental; Niri is installed alongside it.

### 2609180937.sh

Lemurs login manager from source.

- Builds the pinned commit from `cfg/installerInfo/git-commits.csv`.
- Installs the binary to `/usr/bin/lemurs`, PAM module, default config (`cfg/installerInfo/lemurs-config.toml`), and systemd service.
- Enables `lemurs.service`.

### 2609180944.sh

Niri via the DankLinux (DMS) repository.

- Adds `cfg/installerInfo/dms.sources` and installs Niri plus `xwayland-satellite` support for X11 apps.

### 2609181116.sh

Status bar baseline (Flatbar path, transitional).

- Header notes this is moving toward an Ashell-from-source build; BlueTUI becomes optional software.
- Pulls foot, fuzzel, `mako`, `wl-clipboard`, Nemo / Rat Commander file-manager baseline.

### 2609181123.sh

Rat Commander file manager (optional, under evaluation).

- Installs deps from `cfg/softwareAPT/rc.apt`.
- Builds the pinned commit from `cfg/installerInfo/git-commits.csv`.

### 2609181124.sh

WinApps via Dockur/Windows container (optional).

- Installs `podman` / `podman-compose` (`cfg/softwareAPT/winapps.apt`).
- Uses `cfg/installerInfo/winapps-compose.yaml` and `winapps.conf`; installer fetched from `cfg/installerInfo/winapps.url`.
- See `ref/winapps.md` for container lifecycle commands.

### 2609181622.sh

Bitmap font support.

- Removes blocklists in `cfg/installerInfo/fontconfig-rm.list`.
- Links additions in `cfg/installerInfo/fontconfig-add.csv` and refreshes the font cache.

### 2609181656.sh

Xwayland Satellite from source.

- Installs deps from `cfg/softwareAPT/xwayland-satellite.apt`.
- Builds the pinned commit from `cfg/installerInfo/git-commits.csv`.
- See `ref/xwayland-satellite.md` for XSETTINGS background.

## Dev tools (`dev-tools/`)

Helpers for development and testing. Not part of the normal install.

- `clear-lemurs.sh` - removes Lemurs binary, PAM file, and `/etc/lemurs`.
- `clear-noctalia.sh` - purges `noctalia`, `noctalia-greeter`, `umbriel`, `xdg-desktop-portal-umbriel`, then `autopurge`.
- `cp-from-dev.sh` - copies the local checkout (`$HOME/practical-wayland`) into `/opt/kevrevrun/` to test without commit/push.
- `script-template.sh` - `cmdFail` + status boilerplate for new modules.
- `variable-loader.sh` - loads folder/file/status variables from `/opt/kevrevrun/status/` (`folders.list`, `files.list`, `values.list`).
