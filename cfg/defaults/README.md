## Config Files

Defaults deployed by the install modules.

### `niri/`

Split Niri configuration in KDL format (`https://kdl.dev`):

- `config.kdl` - root file; includes the six files below.
- `inputs.kdl` - keyboard, mouse, touchpad, tablet.
- `outputs.kdl` - monitors, scale, position.
- `layouts.kdl` - tiling layout, gaps, borders, focus behavior.
- `startup.kdl` - autostarted programs.
- `winrules.kdl` - per-window rules.
- `keybinds.kdl` - key bindings.

Edit the split files rather than inlining everything into `config.kdl` so diffs stay readable.
