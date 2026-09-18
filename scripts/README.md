# Scripts Directory

---

This folder contains module files for installing and setting up various features of the Practical Wayland environments.
*These files are not intended to be run independently.*

---

## Installation Scripts

### 2609180902.sh

**Initializes the installation environment**
* Creates `/opt/kevrevrun` directory structure
* Exports the folder, file, and status variables
* Downloads the Practical Wayland repository
* Places files in the correct folders

### 2609180904.sh

**Updates system to Debian Forky and installs base packages**
* Updates system to Debian Forky (testing)
* Installs base packages required for the installation scripts
* After update and install is complete, the system will reboot


### 2609180905.sh

**Installs Rust and development tools**
* Installs Rust and Cargo from rustup
* Installs Just using cargo
* Adds Just to /usr/local/sbin so it can be used by sudo
* Removes temporary files


### 2909180912.sh

**Adds i386 32-bit architecture to the system**
* Adds i386 architecture support via dpkg (required for 32-bit software like Steam and NVIDIA components)
* Updates the APT package cache

### 2909180913.sh

**Installs GPU drivers**
* Detects GPU hardware (Intel, AMD, NVIDIA) using `lspci`
* Installs corresponding graphics drivers
* After install the system will reboot

### 2609180915.sh

**Simple CLI Interactive Script for Selecting Desktop Environment**

* This script allows the user to select which desktop environment to install
* Currently supported by this script is:
    - *Noctalia V5* Includes the full notallia stack and is installed from the Noctalia Debian Testing repository
    - *Niri with Flatbar* Includes the niri compositor and flatbar status bar. Portal is provided by xdg-desktop-portal-gtk. Lemurs handles login and launching the desktop environment.
    - *LXQT with Niri* Includes the lxqt desktop environment and the niri compositor. Portal is provided by xdg-desktop-portal-gtk. Lemurs handles login and launching the desktop environment. 

### 2609180916.sh

**Adds Noctalia APT repository to the system and installs the Noctalia Desktop Environment stack**
* Adds Noctalia APT repository to the system
* Updates APT package cache
* Installs Noctalia packages
    - *noctalia* - Desktop environment
    - *noctalia-greeter* - Login manager
    - *umbriel* - Wayland compositor
    - *xdg-desktop-portal-umbriel* - Desktop portal support
* Removes temporary files

*The Umbriel compositor is currently experimental and is not production ready*
*Niri is installed along with Umbriel due to the current status of Umbriel issues*
*The Noctalia greeter will allow you switch between Umbriel and Niri for your testing pleasure*

### 2609180937.sh

**Compiles and Installs Lemurs Login Manager from Source**
* Downloads the current GitLab source for Lemurs
* Checks out the tagged commit from gitlab.com/kevrevan/lemurs
* Compiles Lemurs from source using Cargo
* Installs Lemurs
    - Copies the lemurs binary to /usr/bin/lemurs
    - Installs systemd files
        - Install Lemurs PAM Moduel
        - Installs Lemurs default configuration file
        - Installs Lemurs systemd service
* Enables and starts the lemurs.service
* Removes temporary files

### 2609180944.sh

**Compiles and Installs Niri Wayland Compositor from Source**
* Downloads and builds niri from GitLab repositories
* Checks out latest stable niri commit
* Installs required dependencies for building niri
* Compiles niri from source using cargo
* Installs niri
    - Installs niri binaries
    - Installs Wayland session
    - Installs xdg portal with GTK backend
    - Installs systemd services
* Removes temporary files

### 2609181116.sh

**Installs BlueTUI Bluetooth GUI**
* Builds BlueTUI from crates.io
* Installs BlueTUI to /usr/bin/bluetui

### 2609181123.sh

**Installs Rat Commander File Manager**
* Installs Rat Commander from source
* Installs Rat Commander to /usr/bin/rc

### 2609181124.sh

**Installs WinApps Powered by Dockur**
* Checks for Podman
* Installs Podman and Podman-Compose if required
* Creates configuration files for WinApps
* Starts podman container for WinApps

### 2609181622.sh

**Installs fontconfig files for bitmap font support**
* Removes existing fontconfig files
* Adds new fontconfig files
* Updates font cache

### 2609181656.sh

**Installs Xwayland Satellite**
* Builds xwayland-satellite from source (Github)
* Installs xwayland-satellite to /usr/bin/xwayland-satellite
* Creates configuration files for Xwayland Satellite
* Removes temporary files

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
