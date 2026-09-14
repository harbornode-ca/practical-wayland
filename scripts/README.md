## Scripts Directory

This folder contains module files for installing and setting up various features of the Practical Wayland environments.
*These files are not intended to be run independently.*

### Installation Scripts

#### 00-script.sh`
 *(For future development)*
*A loop monitoring script that checks `/opt/kevrevrun/loop.status` and waits until a background task completes.*

#### `01-script.sh`

**Sets up system directory structures, initializes environment variables, downloads the Practical Wayland repository, and places files into `/opt/kevrevrun`.**

#### 02-script.sh

**Configures Debian Forky (testing) APT repositories and upgrades the system to Debian Forky.**

#### `03-script.sh`

**Installs Rust, Cargo, and Just development tools into the user's home directory.**

*Just will need to be installed from debian repos for installation scripts to work when calling sudo*
*Software is compiled by the user and sudo is only called to move the files according the justfile where needed.* 

#### `04-script.sh`
**Adds `i386` architecture support via `dpkg` (required for 32-bit software like Steam and NVIDIA components) and updates the APT package cache.**

*Need to add the option to skip the addition of the i386 architecture. Adding the architecture does not affect performance or stability on its own*
*It is supported by Mesa and Nvidia drivers and is required for some use of some software like steam*

#### `05-script.sh`
**Detects GPU hardware (Intel, AMD, NVIDIA) using `lspci`, installs corresponding graphics drivers, and prompts for a system reboot upon completion.**

*Will install drivers for all detected hardware.*
*A prompt will be added for installing support for legacy GPUs. Logic will be added in the future.*

#### `06-script.sh`

**Displays an interactive menu allowing the user to select which desktop environment to install.**

*Currently supported by this script is:*
    - *Noctalia V5* Includes the full notallia stack and is installed from the Noctalia Debian Testing repository
    - *Niri with Flatbar* Includes the niri compositor and flatbar status bar. Portal is provided by xdg-desktop-portal-gtk. Lemurs handles login and launching the desktop environment.
    - *LXQT with Niri* Includes the lxqt desktop environment and the niri compositor. Portal is provided by xdg-desktop-portal-gtk. Lemurs handles login and launching the desktop environment. 

#### `07-script.sh`

**Sets up the Noctalia APT repository and installs the Noctalia Desktop Environment stack (`noctalia`, `noctalia-greeter`, `umbriel`, and `xdg-desktop-portal-umbriel`).**

#### `08-script.sh`

**Downloads, compiles from source via Cargo, installs, and configures the Lemurs login manager alongside its PAM module and session files.**

#### `09-script.sh`

**Adds the Danklinux (DMS) APT repository and installs the `niri` Wayland compositor and `xwayland-satellite`.**

*This repository currently supplies the `niri` Wayland compositor, `xwayland-satellite` package and calls required dependancies*
*This will be replaced with a source build of niri and xwayland-satellite if the repository becomes unreliable.*

#### `10-script.sh`

**Installs Flatbar and supporting software. Sets up default configuration files for Flatbar.**

*(Work in progress)*

---

### Dev Tools Directory (`dev-tools/`)

**Helper scripts used during development and testing of installation components.**

#### `dev-tools/clear-lemurs.sh`

**Uninstalls and cleans up Lemurs login manager binaries, PAM configs, and configuration directories.**

#### `dev-tools/clear-noctalia.sh`

**Purges Noctalia packages (`noctalia`, `noctalia-greeter`, `umbriel`, `xdg-desktop-portal-umbriel`) and runs `apt autopurge`.**

#### `dev-tools/cp-from-dev.sh`

**Copies updated scripts and configuration files from the local working repository (`$HOME/practical-wayland`) to `/opt/kevrevrun/`.**

*Copies files to the installation directory instead of commiting, pushing and pulling repository*

#### `dev-tools/template-var.sh`

**Template snippet script that reads and exports folder, file, and status variables from `/opt/kevrevrun/status/`.**

*A script template that loads all variables required by the installation scripts, whether all are used in the current script or not.*
*Avoids having to copy and paste variable definitions throughout the installation scripts.*
*Once workflow is fully developed scripts will be upgraded to use export to avoid the need for a template file.*
