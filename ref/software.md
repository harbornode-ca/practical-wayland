# Software List

A list of installed and optionally installable software on the system. 

**FUTURE RELEASE** - There will be scripts to manage installation and updating of software that is not available from the debian repositories. These scripts will likely be similar to the ones in the software_installers directory but with improvements and bug fixes.

---

## Debian Main Repository

1. :penguin: **Nemo**
    - *File manager for GNOME desktop environment*
    - *Package* - nemo
2. :penguin: **Podman**
    - *Container engine for running containers*
    - *Package* - podman
3. :penguin: **Podman-compose**
    - *Compose tool for podman*
    - *Package* - podman-compose
4. :penguin: **Mousepad**
    - *Lightweight text editor*
    - *Package* - mousepad
5. :penguin: **Btop**
    - *Resource monitor*
    - *Package* - btop
6. :penguin: **Fastfetch**
    - *System information utility*
    - *Package* - fastfetch
7. :penguin: **Git**
    - *Version control system*
    - *Package* - git
8. :penguin: **GitHub CLI**
    - *GitHub command-line interface*
    - *Package* - gh
9. :penguin: **Waydroid**
    - *Container-based Android system*
    - *Package* - waydroid
10. :penguin: **Waydroid Tools**
    - *Tools for Waydroid*
    - *Package* - waydroid
11. :penguin: **Foot**
    - *Wayland terminal emulator*
    - *Package* - foot, foot-extra-terminfo, foot-terminfo, foot-themes, ncurses-term
12. :penguin: **Inkscape**
    - *Vector graphics editor*
    - *Package* - inkscape
13. :penguin: **OBS Studio**
    - *Screen recording and streaming software*
    - *Package* - obs-studio

---

## Debian Packaged Software
1. :ice_cube: **Voxtype** - 
    - *AI Voice Typing*
    - *Current Stable 09/19/2026* - https://github.com/peteonrails/voxtype/releases/download/v1.0.1/voxtype_1.0.1-1_amd64.deb
2. :ice_cube: **Pake** - 
    - *Convert websites into desktop apps*
    - *Current Stable 09/19/2026* - https://github.com/tw93/Pake/releases/download/V3.16.3/DeepSeek_x86_64.deb
3. :ice_cube: **Markpad** - 
    - *A beautiful, fast, and functional Markdown editor for Linux.*
    - *Current Stable 09/19/2026* - https://github.com/sftwrdotdev/Markpad/releases/download/v2.7.6/Markpad_2.7.6_amd64.deb
4. :ice_cube: **SideX** - 
    - *VSCode built with Tauri*
    - *Current Stable 09/19/2026* - https://github.com/Sidenai/sidex/releases/download/v0.1.2/SideX_0.1.2_amd64.deb
5. :ice_cube: **Lapce** - 
    - *Lightning-fast and Powerful Code Editor written in Rust*
    - *Current Stable 09/19/2026* - https://github.com/lapce/lapce/releases/download/v0.4.6/lapce.debian.bookworm.amd64.deb
6. :ice_cube: **Dive** - 
    - *Tool for exploring the contents of Docker image layers*
    - *Current Stable 09/19/2026* - https://github.com/wagoodman/dive/releases/download/v0.13.1/dive_0.13.1_linux_amd64.deb
7. :ice_cube: **Opencode Desktop** 
    - *AI-powered cross-platform IDE GUI for Linux*
    - *Current Stable 09/19/2026* - https://opencode.ai/download/stable/linux-x64-deb

---

## Source Build Software
1. :notebook: **eget Package Manager** - https://github.com/zyedidia/eget
    - *Install* - `go install github.com/zyedidia/eget@latest`
2. :notebook: **lazydocker** - https://github.com/jesseduffield/lazydocker
    - *Install* - `go install github.com/jesseduffield/lazydocker@latest`
3. :notebook: **LazySpotify** - https://github.com/dubeyKartikay/lazyspotify
    - *Binary patched library in lazy-spotify.url. Needs to be configured in lazy-spotify config*
    - *Install* - 
        ```
        git clone https://github.com/dubeyKartikay/lazyspotify.git
        cd lazyspotify
        make build
        ```
4. :notebook: **Mods** - https://github.com/panjie/mods
    - *Install* - go install github.com/panjie/mods@latest

---

### Tarball Binaries
1. :card_file_box: **LazyGit** - https://github.com/jesseduffield/lazygit
    - Lates 09/19/2026: https://github.com/jesseduffield/lazygit/releases/download/v0.65.1/lazygit_0.65.1_linux_x86_64.tar.gz

---

##  Cargo Installable
1. :truck: **Hazelnut** 
    - *Terminal-based automated file organizer inspired by Hazel. Watch folders and organize files with rules.*
    - *Install* - `cargo install hazelnut`
2. :truck: **Binstall** 
    - *Tool to help you install cargo-binstall*
    - *Install* - `cargo install cargo-binstall`
3. :truck: **Podlet Podman Quadlet tool** 
    - *Tool for creating quadlets from docker compose or docker run commands*
    - *Install* - `cargo install podlet`

---

## Cargo Binstallable
1. :package: **Fresh IDE** 
    - *AI-powered code editor*
    - *Install* - `cargo binstall fresh-editor`

---

## uv Installable
1. :sunny: **OpenViking** - https://github.com/volcengine/OpenViking
    - *Install Info* - https://docs.openviking.ai/en/getting-started/02-quickstart

---


## Bash Installer
1. :shell: **Opencode Terminal IDE** - https://opencode.ai
    - *Install* - `curl -fsSL https://opencode.ai/v2/install | bash`

---

## Charmbracelet Repository
*Installable using APT after adding charmbracelet repository*
1. :ring: **VHS** - https://github.com/charmbracelet/vhs
    - *Record terminal sessions as GIFs*
    - *Package Name* - vhs
2. :ring: **Soft Serve** - https://github.com/charmbracelet/soft-serve
    - *Git server that runs in your terminal*
    - *Package Name* - softserve
3. :ring: **Skate** - https://github.com/charmbracelet/skate
    - *A personal key-value store*
    - *Package Name* - skate
4. :ring: **Pop** - https://github.com/charmbracelet/pop
    - *Mail app for your terminal*
    - *Package Name* - pop
5. :ring: **Glow** - https://github.com/charmbracelet/glow
    - *Markdown viewer*
    - *Package Name* - glow
6. :ring: **Freeze** - https://github.com/charmbracelet/freeze
    - *Generate images of code and terminal output.*
    - *Package Name* - freeze
7. :ring: **Crush** - https://github.com/charmbracelet/crush
    - *Glamorous agentic coding for all*
    - *Package Name* - crush
