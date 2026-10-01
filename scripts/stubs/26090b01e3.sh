#!/bin/bash
#26090b01e3.sh - Install Niri from build directory.

while IFS="," read -r src dest; do
    sudo cp -fv $tmpDir/niri/$src $dest
    exitStat=$?
    errMsg="Failed to copy $src to $dest"
    successMsg="Copied $src to $dest"
    cmdFail
done < "/opt/practical-wayland/lib/install-niri.csv"
