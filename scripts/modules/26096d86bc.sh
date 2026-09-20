#!/bin/bash
#Adds i386 architecture support and updates package cache. While not required NVIDIA Drivers still have i386 support.
#This is required for running steam. Adding does not affect performance or system stability.
cmdFail () {
if [ $exitStat -ne 0 ]; then
    echo "$errMsg"
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
else
    echo "$successMsg"
fi
}
#These variables need to be set directly after a process ends to capture the $? value and output a message, cmdFail runs function.
#exitStat=$?
#errMsg="ERROR MESSAGE"
#successMsg="SUCCESS MESSAGE"
#cmdFail
echo "Adding i386 architecture"
sleep 0.5
sudo dpkg --add-architecture i386
exitStat=$?
errMsg="Failed to add i386 architecture"
successMsg="i386 architecture added successfully"
cmdFail
echo "Updating APT package cache"
sleep 0.5
sudo DEBIAN_FRONTEND=noninteractive apt update
exitStat=$?
errMsg="Failed to update APT package cache"
successMsg="APT package cache updated successfully"
cmdFail
echo "i386 architchture support has been sucessfully added"
sleep 1