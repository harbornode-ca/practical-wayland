# Modules

Stage workers invoked by `menus/setup.sh`. Each performs one install step.

## 2609ab672b.sh

Fetches target Debian release information (ID and name) from the repository for use by later stages. Runs in stage 1.

## 2609783e82.sh

Initializes the install environment. Ensures required directories and files exist under `/opt/kevrevrun` and generates the persisted variable lists (`folders.list`, `files.list`, `values.list`) that provide paths and state to all subsequent scripts. Runs in stage 1.

## 260955fa1e.sh

Deploys current installer files. Clones the `practical-wayland` repository and copies its contents into the live `/opt/kevrevrun` directories. Runs in stage 2.

## 26096d86bc.sh

Enables i386 (32-bit) architecture support so 32-bit packages (e.g., Steam, certain NVIDIA components) can be installed. Runs in stage 3.

## 26090ffbdb.sh

Migrates the system to Debian Forky. Replaces legacy APT sources with Forky sources and upgrades the system. Intended for stage 4; currently not yet connected to the dispatcher.
