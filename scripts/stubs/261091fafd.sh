#!/bin/bash
#26093ecf51.sh - Download XWayland-Satellite Source Code

git clone https://github.com/Supreeeme/xwayland-satellite.git $tmpDir/xwayland-satellite
cd $tmpDir/xwayland-satellite
git checkout b5690b56d749526a05db9b9268d58bf8f700957f
