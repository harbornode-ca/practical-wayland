#!/bin/bash
#Moves files from the dev folder to the main folder
destFldr="/opt/kevrevrun/scripts /opt/kevrevrun/cfg /opt/kevrevrun/data /opt/kevrevrun/tools"
for f in $destFldr; do
    echo "Emptying folder $f"
    sleep 0.25
    rm -rvf $f/*
    sleep 0.25
done
echo "Copying cfg folder contents"
cp -rvf $HOME/practical-wayland/cfg/* /opt/kevrevrun/cfg
sleep 0.25
echo "Copying scripts folder contents"
cp -rvf $HOME/practical-wayland/scripts/* /opt/kevrevrun/scripts
sleep 0.25
echo "Copying data folder contents"
cp -rvf $HOME/practical-wayland/data/* /opt/kevrevrun/data
sleep 0.25
echo "Copying tools folder contents"
cp -rvf $HOME/practical-wayland/tools/* /opt/kevrevrun/tools
sleep 0.25
