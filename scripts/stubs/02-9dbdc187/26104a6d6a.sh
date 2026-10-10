#!/bin/bash
#26104a6d6a.sh - Install LXQt packages
#Author: kevinrevun - kevin@kevrev.run

aptDeps=$(cat /opt/practical-wayland/lib/apt/lxqt.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDeps -y