#!/bin/bash
#2610d13ab8.sh - Install Lemurs Build Dependencies

aptDeps=$(cat /opt/practical-wayland/lib/apt/lemurs.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDeps -y