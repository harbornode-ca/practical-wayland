#!/bin/bash
#2909b581a8.sh - Clone practical-wayland repository from github

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


#START PRATICAL WAYLAND DOWNLOAD
style=info
prt_info
gum style "Downloading Practical Wayland from github"
sleep 1
git -C "$tmpDir" clone https://github.com/harbornode-ca/practical-wayland.git
if [ -d "$tmpDir/practical-wayland" ]; then
    style=win
    prt_info
    gum style "Practical Wayland sucessfully cloned"
    sleep 1
fi
#END PRATICAL WAYLAND DOWNLOAD