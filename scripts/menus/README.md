# Menus

Entry points for the installer. `initial.sh` is run once as root; `setup.sh` is then run as the configured user to drive the staged installation.

## initial.sh

Initial bootstrap script. Prepares a minimal Debian system for installation: updates the system, installs base packages, creates the `/opt/kevrevrun` directory structure, configures sudo access for the chosen user, and downloads the main `setup.sh` dispatcher.

## setup.sh

Stage dispatcher for the entire install. Reads the current stage from `/opt/kevrevrun/status/setup.stage` and executes the corresponding stage. Handles variable loading, inter-stage confirmations, and reboots. Stages 1-3 are active; stage 4 is reserved for the Forky upgrade; stages 5-30 are placeholders for future modules.

## run.sh

Utility that executes the command stored in `/opt/kevrevrun/status/cmd.string`.

## de-select.sh

Stub for desktop environment selection. Intended to prompt the user to choose a DE before installation continues.
