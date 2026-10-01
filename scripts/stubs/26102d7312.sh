#!/bin/bash
#26102d7312.sh - Install Xwayland-satellite Dependencies

aptDeps=$(cat /opt/practical-wayland/lib/apt/xwayland-satellite.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDeps -y