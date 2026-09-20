#!/bin/bash
#Script Information

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
    sleep 1
    clear
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
style=info
prt_info
gum style "Downloading Practical Wayland setup installer..."
sleep 1
wget -nv https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/scripts/modules/2909b581a8.sh
exitStat=$?
errMsg="Practical Wayland setup installer part 1 download failed."
successMsg="Practical Wayland setup installer part 1 downloaded successfully"
cmdFail
echo
sleep 1
wget -nv https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/scripts/modules/260901abbc.sh
exitStat=$?
errMsg="Practical Wayland setup installer part 2 download failed."
successMsg="Practical Wayland setup installer part 2 downloaded successfully"
echo
sleep 1
cmdFail
gum style "Adding execute permission to Practical Wayland setup installer files"
sleep 1
chmod +x 2909b581a8.sh 260901abbc.sh
exitStat=$?
errMsg="Added execute permission to Practical Wayland setup installer."
successMsg="Added execute permission to Practical Wayland setup installer sucessfully"
cmdFail
style=info
prt_info
gum style "Practical Wayland setup installer files downloaded successfully"
sleep 1
exit 0