#!/bin/bash
#2609f9417f.sh - Install Niri Build Dependencies

aptDeps=$(cat /opt/practical-wayland/lib/apt/niri-build.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDeps -y