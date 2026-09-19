#!/bin/bash
#Moves files from the dev folder to the main folder
destFldr="/opt/kevrevrun/scripts /opt/kevrevrun/cfg"
for f in $destFldr; do
    echo "Emptying folder $F"
    sleep 1
    rm -rvf $f/*
    sleep 1
done
echo Copying main directory contents
cp -vf $HOME/practical-wayland/* /opt/kevrevrun
sleep 1
echo "Copying cfg folder contents"
cp -rvf $HOME/practical-wayland/cfg/* /opt/kevrevrun/cfg
sleep 1
echo "Copying scripts folder contents"
cp -rvf $HOME/practical-wayland/scripts/* /opt/kevrevrun/scripts
sleep 1

