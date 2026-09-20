#!/bin/bash
#26096d86bc.sh - Adds i386 architecture support and updates package cache. While not required NVIDIA Drivers still have i386 support.
#This is required for running steam. Adding does not affect performance or system stability.

#START GUM STYLE FUNCTION
prt_info (){
case $style in
    info) export FOREGROUND=7; export BOLD=true;;
    msg) export FOREGROUND=3;;
    lose) export FOREGROUND=1; export BOLD=true;;
    win) export FOREGROUND=2; export BOLD=true;;
    *) export FOREGROUND=7; export BOLD=true;;
esac
}
#END GUM STYLE FUNCTION

#START CMD FAIL FUNCTION
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
    exit 1
else
    style=win
    prt_info
    gum style "$successMsg"
    sleep 0.5
fi
# These variables need to be set directly after a process ends to capture the $? value 
# and output a message, cmdFail runs function.
# exitStat=$?
# errMsg="ERROR MESSAGE"
# successMsg="SUCCESS MESSAGE"
# cmdFail
}
#END CMD FAIL FUNCTION


#START ADD I386 ARCH
echo
style=info
prt_info
gum style "Running dpkg to add i386 32bit Architecture to supported architectures"
sleep 1
sudo dpkg --add-architecture i386
exitStat=$?
errMsg="dpkg failed to add i386 32bit Architecture to supported architectures"
successMsg="dpkg successfully added i386 32bit Architecture to supported architectures"
cmdFail
sleep 1
echo
#END ADD I386 ARCH

#START APT UPDATE
style=info
prt_info
gum style "Updating APT package cache"
sleep 0.5
gum spin $moduleDir/2609cf9ded.sh
exitStat=$?
errMsg="Failed to update APT package cache"
successMsg="APT package cache updated successfully"
cmdFail
sleep 1
echo
#END APT UPDATE

#END OF SCRIPT
