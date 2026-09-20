# Scripts

Installer scripts for Practical Wayland.

## menus/

Entry points for the installation.

- **initial.sh** - Prepares a fresh Debian system for installation.
- **setup.sh** - Runs the staged installation.
- **de-select.sh** - Handles desktop environment selection.

See `menus/README.md` for details.

## modules/

Workers that perform individual install steps.

- **2609ab672b.sh** - Provides Debian release information.
- **2609783e82.sh** - Initializes the install environment and variables.
- **260955fa1e.sh** - Deploys installer files.
- **26096d86bc.sh** - Enables 32-bit architecture support.
- **26090ffbdb.sh** - Migrates the system to Debian Forky.

See `modules/README.md` for details.

## modules/tmp-to-implement/

Parked modules not currently in use. Includes installers for Rust, GPU drivers, Noctalia, Lemurs, Niri, BlueTUI, Rat Commander, WinApps, fonts, and xwayland-satellite.

See `modules/tmp-to-implement/README.md` for details.
