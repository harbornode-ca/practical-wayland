# cfg/apt

DEB822 `.sources` files for switching Debian releases.

| File | Suite |
| --- | --- |
| `enabledForky.sources` / `disabledForky.sources` | `forky` + `forky-security` |
| `enabledSid.sources` / `disabledSid.sources` | `sid` |
| `enabledTrixie.sources` / `disabledTrixie.sources` | `trixie` |

Target suite is `forky` (`../../data/extra/debian.id`).

`enabled*` is the active variant; `disabled*` is kept for diff/rollback. Install copies the selected `enabled*` to `/etc/apt/sources.list.d/`.
