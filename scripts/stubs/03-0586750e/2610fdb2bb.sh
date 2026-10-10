#!/bin/bash
#2610fdb2bb.sh - Install Ashell dependancies

aptDeps=$(cat /opt/practical-wayland/lib/apt/ashell.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDeps -y