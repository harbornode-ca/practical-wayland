#!/bin/bash
#26096d86bc.sh - Adds i386 architecture support and updates package cache. While not required NVIDIA Drivers still have i386 support.
#This is required for running steam. Adding does not affect performance or system stability.
prt_info () {
case $style in
    info) export FOREGROUND=7; export BOLD=true;;
    msg) export FOREGROUND=3;;
    lose) export FOREGROUND=1; export BOLD=true;;
    win) export FOREGROUND=2; export BOLD=true;;
    *) export FOREGROUND=7; export BOLD=true;;
esac
}
cmdFail () {
if [ $exitStat -ne 0 ]; then
    style=lose
    prt_info
    gum style "$errMsg"
    sleep 1
    echo
    style=msg
    prt_info
    gum style "This script will now exit"
    sleep 1
    clear
    exit 1
else
    style=win
    prt_info
    gum style "$successMsg"
    sleep 0.5
fi
}
# These variables need to be set directly after a process ends to capture the $? value and output a message, cmdFail runs function.
# exitStat=$?
# errMsg="ERROR MESSAGE"
# successMsg="SUCCESS MESSAGE"
# cmdFail
style=msg
prt_info
gum style "Adding i386 architecture"
sleep 0.5
sudo dpkg --add-architecture i386
exitStat=$?
errMsg="Failed to add i386 architecture"
successMsg="i386 architecture added successfully"
cmdFail
style=msg
prt_info
gum style "Updating APT package cache"
sleep 0.5
sudo DEBIAN_FRONTEND=noninteractive apt update
exitStat=$?
errMsg="Failed to update APT package cache"
successMsg="APT package cache updated successfully"
cmdFail
style=win
prt_info
gum style "i386 architecture support has been successfully added"
sleep 1
echo "5" > $stageFile
