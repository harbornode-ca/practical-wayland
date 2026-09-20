# Practical Wayland

**A practical installer for Wayland environments on Debian.**

*Installs Wayland setups with GPU drivers, login manager, and Wayland session files for multiple wayland native desktop environments.*

---

## Requirements

- Debian stable minimal install with internet access.
- Run `initial.sh` as root. Log in as the created sudo user for `setup.sh`.
- Packages bootstrapped by `initial.sh`: `sudo`, `git`, `wget`, `curl`, `gpg`, `tmux`, `unzip`, `build-essential`, `fonts-nerd-symbols`, `fonts-font-awesome`, `firmware-linux`, plus Charmbracelet `gum` 0.17.0.

---

## Quickstart

```bash
# 1. As root, from a clone of this repo:
bash initial.sh
# Creates /opt/kevrevrun/{cfg,status,scripts,tmp,logs},
# writes id.usr / name.usr / status/setup.stage,
# downloads setup.sh, installs gum, then reboots.

# 2. After reboot, log in as the sudo user:
sudo ./setup.sh
# Stage dispatcher. Stage 1 fetches the init module,
# stage 2 upgrades APT sources to Forky and reboots,
# stage 3 installs Rust via rustup, later stages add
# i386 arch, GPU drivers, desktop environment, and apps.
```

State is tracked in `/opt/kevrevrun/status/setup.stage`. Re-run `setup.sh` after each reboot to continue.

---

## Desktop choices

**The selection menu for Desktop Environments (DE) is currently under construction!**

**The following choices will be available:**

*All packages will be installed through the dispatcher*

    1. **Noctalia**
        *Completion status: scripts available to install repository and packages. Niri build and install script also completed. Implementation that installs through the dispatcher is currently being worked on.*

        *Details:*
        - The complete stack including greeter, compositor, and shell
        - The included compositor Umbriel has some stability issues and when choosing this option the installer will also install Niri for daily driver use. Umbriel will be avaliable for the more adventurous user to try out if they wish.
        - The installation of niri is strictly for stability and will be removed once Umbreil becomes stable enough for daily driver use. **Details to follow**
        - X11 compatibility is included via xwayland-satellite for both niri and Umbriel
    2. **Niri w/ Ashell**
        *Completion status: Scripts are available to build and install lemurs, niri, and xwayland-satellite. The ashell build and install script needs to be completed. Implementation that installs through the dispatcher is currently being worked on.*

        *Details:*
        - This option installs a custom niri based setup.
            - Login/Display Manager: Lemurs
            - Compositor: niri
            - Shell: Ashell
            - X11 compatibility is included via xwayland-satellite
    3. **LXQt w/ niri compositor**
        *Completion status: niri, and xwayland-satellite build and install scripts are completed. LXQt will be installed through the main Debian repositories. The LXQt install from repository and configuration with niri is currently being worked on.*

        *Details:**
            - Installs LXQT desktop environment with niri as the desktop compositor
            - Includes LXQt panel and file manager (PCManFM-Qt)
            - X11 compatibility is included via xwayland-satellite

---

## Repository layout

| Path | Purpose |
| --- | --- |
| `initial.sh` | Root bootstrap: users, dirs, `setup.sh` download, `gum` install. |
| `setup.sh` | Multi-stage orchestrator (stages 1-30). |
| `scripts/` | Install modules, see `scripts/README.md`. |
| `cfg/` | APT sources, package lists, default configs, see `cfg/README.md`. |
| `ref/` | Background notes, see `ref/README.md`. |
| `tools/` | Update/maintenance helpers, see `tools/README.md`. |

---

## CLI Documentation

- Charmbracelet gum is used for the CLI.
- Variables are exported as required by the scripts so they are always available in the current shell.
- Default variables are located in `ref/gumVariables.md`.
- All variables are set to reasonable defaults, but can be overridden by the user.
- There are four types of messages:
    - *Information w/ White Foreground*
        - Information messages provide information that is useful to the user, but not critical to the operation of the script. (No user input required.)
    - *Messages w/ Yellow Foreground*
        - Messages are used for informing the user of actions being take or inform the user that action is required. Like discribing the purpose of an upcoming menu.
    - *Success w/ Green Foreground*
        - Success messages provide feedback that an action has been completed successfully.
    - *Error w/ Red Foreground*
        - Error messages provide feedback that an action has failed.

**The following commands have default variables for this project set and are ready to use:**

1. **Confirm** - (Used for binary questions.)
    - *command:* `gum confirm`
    - *The following variables are set by default:*
        - GUM_CONFIRM_PROMPT_FOREGROUND
        - GUM_CONFIRM_SELECTED_FOREGROUND
        - GUM_CONFIRM_SELECTED_BACKGROUND
        - GUM_CONFIRM_UNSELECTED_FOREGROUND
        - GUM_CONFIRM_UNSELECTED_BACKGROUND
        - GUM_CONFIRM_PADDING
        - GUM_CONFIRM_SHOW_HELP
    - Other variables can be set to change the appearance of the gum confirm command. The prompt string, affirmative choice text and negative choice text. (Default is Yes/No)
    - Example of prompt/affirmative/negative arguments:
        - prompt: "The sky is blue?"
        - affirmative: "True"
        - negative: "False"
    - Example of usage with default variables:
        - gum confirm "Are you sure?"
    - Example of usage with custom variables:
        - gum confirm "The sky is blue?" --affirmative "True" --negative "False"
2. **Choose** - (Used for multiple choice questions)
    - *command:* `gum choose`
    - *The following variables are set by default:*
        - GUM_CHOOSE_PROMPT_FOREGROUND
        - GUM_CHOOSE_SELECTED_FOREGROUND
        - GUM_CHOOSE_SELECTED_BACKGROUND
        - GUM_CHOOSE_UNSELECTED_FOREGROUND
        - GUM_CHOOSE_UNSELECTED_BACKGROUND
        - GUM_CHOOSE_PADDING
        - GUM_CHOOSE_HEIGHT
        - GUM_CHOOSE_CURSOR
        - GUM_CHOOSE_CURSOR_PREFIX
        - GUM_CHOOSE_SELECTED_PREFIX
        - GUM_CHOOSE_UNSELECTED_PREFIX
    - The variables are set for consistancy with the other gum commands.
    - Flags that have no defaults that should be specified at runtime.
        - 
        - *Flag:* --limit
            - Has to be set to allow selection of more than one option. Default is 1.
        - *Flag:* --selected
            - Can be used to pre-select items. Values are space delimited.
            - Example: --selected="Option 1 Option 2"
        - *Flag:* --header
            - Header value, Default: "Choose"
        - *Flag:* --input-delimiter
            - Option delimiter when reading from STDIN, Default: "\n"
        - *Flag:* --output-delimiter
            - Option delimiter when writing to STDOUT, Default: "\n"
        - *Flag:* --timeout
            - Timeout until command aborts without a selection
        - *Flag:* --[no-]show-help
            - Show keybinds help, default shows help
        - *Flag: * --[no-]strip-ansi
            - Strip ANSI sequences when reading from STDIN, default does not strip ANSI sequences
        - *Flag:* --height
            - While this is set to a default of 10 there may be a need to change it based on the the menu being displayed.
    - The choices are passed to stdout and can be used as arguments to other commands. 
    - If you want to > to a variable you need to set the variable to "" before passing the output othewise it will fail with an ambiguous redirect error.
3. **Style** - (Fancy text)
    - *command:* `gum style`
    - A function with already set colour choices for the 4 different types of messages is included in every script.
    - To use gum style to print messages based on the specified message types:
        - `style="type of message"`
            - *types:* "info", "msg", "lose", "win"
        - `prt_info`
            - sets the colour variables to match the message type set in the previous step. **This function must be called before using gum style!**
        - `gum style "$message"`
            - prints the message based on the sytle variable set by prt_info function.

**The following commands are not implemented yet:**

1. **Spinner** - (Progress bar)
    - *command:* `gum spin`
    *Currently being implemented*
2. **Input**
    - *command:* `gum input`
    *Currently being implemented*
3. **Filter**
    - *command:* `gum filter`
    *Currently being implemented*
4. **File**
    - *command:* `gum file`
    *Currently being implemented*
5. **Pager**
    - *command:* `gum pager`
    *Currently being implemented*

## Notes

1.  **Install modules** - Install modules under `scripts/` are not meant to run standalone; run them via `setup.sh`.
2.  **Pinned source commits** - Pinned source commits are listed in `cfg/installerInfo/git-commits.csv`.
3.  **Optional software candidates** - Optional software candidates are tracked in `ref/software.md`.



