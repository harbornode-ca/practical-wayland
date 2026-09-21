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
gum style "Starting Rust Toolkit and Just installation..."
sleep 1
$moduleDir/260921e7b5.sh
exitStat=$?
errMsg="Rust Toolkit & Just installation script failed."
successMsg="Rust Toolkit & Just installed successfully"
cmdFail
echo
style=msg
prt_info
sleep 1
echo "6" > $stageFile
gum confirm "Do you want to continue?"
exitStat=$?
if [ $exitStat = 0 ]; then
    sleep 1
    chk_stage
else
    style=msg
    prt_info
    echo
    gum style "Exit cancelled by user."
    style=info
    prt_info
    echo
    gum style "When you want to continue, please run"
    gum style "$PWD/setup.sh"
    style=msg
    prt_info
    echo
    gum style "This script will now exit."
    exit 1
fi