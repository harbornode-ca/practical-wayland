#!/bin/bash
#cp-install - Copies current workspace to the install directories for testing.
usrName="$(whoami)"
mainFldr="/opt/practical-wayland"
if [ -d "$mainFldr" ]; then
    sudo chown "$usrName":"$usrName" "$mainFldr"
    cp -Rv * "$mainFldr"
    sudo chown -Rv "$usrName":"$usrName" "$mainFldr"
else
    sudo mkdir -pv "$mainFldr"
    cp -Rv "$mainFldr"
    sudo chown -Rv "$usrName":"$usrName" "$mainFldr"
fi