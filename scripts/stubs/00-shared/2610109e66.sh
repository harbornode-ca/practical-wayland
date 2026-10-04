#!/bin/bash
#2610109e66.sh - Install Niri Runtime Dependencies

aptDeps=$(cat /opt/practical-wayland/lib/apt/niri-runtime.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDeps -y