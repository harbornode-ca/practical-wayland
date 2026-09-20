# scripts/modules

Stage workers invoked by `menus/setup.sh`. Each performs one install step.

| Module | Purpose |
| --- | --- |
| `2609ab672b.sh` | Fetches target Debian release ID/name. |
| `2609783e82.sh` | Initializes `/opt/kevrevrun` directories and state. |
| `2909b581a8.sh` | Clones the `practical-wayland` repository. |
| `260901abbc.sh` | Copies cloned repo files into live directories. |
| `260955fa1e.sh` | Deploys installer files and cleans up. |
| `26096d86bc.sh` | Enables i386 architecture support. |
| `26090ffbdb.sh` | Migrates system to Debian Forky (not yet wired). |
