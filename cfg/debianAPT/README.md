## APT Repository Files

DEB822 `.sources` files for switching Debian releases. Used by `scripts/2609180904.sh`.

| File | State | Suite |
| --- | --- | --- |
| `enabledForky.sources` | Active | `forky` + `forky-security` |
| `disabledForky.sources` | Inactive copy | `forky` + `forky-security` |
| `enabledSid.sources` | Active | `sid` |
| `disabledSid.sources` | Inactive copy | `sid` |
| `enabledTrixie.sources` | Active | `trixie` |
| `disabledTrixie.sources` | Inactive copy | `trixie` |

Current installer target is Forky (`../installerInfo/debian.id` contains `forky`).

Convention: copy the desired `enabled*` file to `/etc/apt/sources.list.d/` and remove legacy `sources.list` entries. The `disabled*` copies are kept for quick diffing and rollback.
