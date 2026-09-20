#!/bin/bash
curID=$(cat /opt/kevrevrun/cfg/install/current.id)
stageFile="/opt/kevrevrun/status/setup.stage"
setupStg=$(cat "$stageFile")
#START GUM VARIABLES

#GUM CONFIRM VARIABLES
export GUM_CONFIRM_PROMPT_FOREGROUND=7
export GUM_CONFIRM_SELECTED_FOREGROUND=0
export GUM_CONFIRM_SELECTED_BACKGROUND=3
export GUM_CONFIRM_UNSELECTED_FOREGROUND=0
export GUM_CONFIRM_UNSELECTED_BACKGROUND=2
export GUM_CONFIRM_PADDING="2 0"
export GUM_CONFIRM_SHOW_HELP=false
#END GUM CONFIRM VARIABLES

#START GUM CHOOSE VARIABLES
export GUM_CHOOSE_PADDING="1 0"
export GUM_CHOOSE_HEIGHT=10
export GUM_CHOOSE_CURSOR=" > "
export GUM_CHOOSE_CURSOR_PREFIX="[-] "
export GUM_CHOOSE_SELECTED_PREFIX="[x] "
export GUM_CHOOSE_UNSELECTED_PREFIX="[ ] "
export GUM_CHOOSE_CURSOR_FOREGROUND=7
export GUM_CHOOSE_HEADER_FOREGROUND=3
export GUM_CHOOSE_ITEM_FOREGROUND=3
export GUM_CHOOSE_SELECTED_FOREGROUND=10
#END GUM CHOOSE VARIABLES

#END GUM VARIABLES

#MESSAGE TYPE SETTINGS
prt_info () {
case $style in
    info) export FOREGROUND=7; export BOLD=true;;
    msg) export FOREGROUND=3;;
    lose) export FOREGROUND=1; export BOLD=true;;
    win) export FOREGROUND=2; export BOLD=true;;
    *) export FOREGROUND=7; export BOLD=true;;
esac
}
#END MESSAGE TYPE SETTINGS

#CMD FAIL FUNCTION
cmdFail () {
if [ $exitStat -ne 0 ]; then
    sleep 1
    echo
    style=lose
    prt_info    
    gum style "$errMsg"
    echo
    gum style "This script will now exit"
    exit 1
else
    style=win
    prt_info    
    gum style "$successMsg"
fi
}
#END CMD FAIL FUNCTION

#STAGE CHECK FUNCTION
chk_stage () {
setupStg=$(cat "$stageFile")
setup_stage
}
#END STAGE CHECK FUNCTION

#LOAD VARIABLES FUNCTIONS
loadVars () {
style=msg
prt_info
gum style "Setting up Folder Variables"
sleep 0.5
fldrList=$(cat /opt/kevrevrun/status/folders.list)
for f in $fldrList; do
    varName=$(echo $f | cut -d ',' -f 1)
    varValue=$(echo $f | cut -d ',' -f 2)
    style=msg
    prt_info
    gum style "Setting up folder variable $varName"
    export $varName="$varValue" 2>&1
    style=win
    prt_info
    gum style "Folder Variable $varName is set to $varValue"
    sleep 0.25
done
style=msg
prt_info
gum style "Setting up File Variables"
sleep 0.5
varFiles=$(cat /opt/kevrevrun/status/files.list)
for v in $varFiles; do
    varName=$(echo $v | cut -d ',' -f 1)
    varValue=$(echo $v | cut -d ',' -f 2)
    style=msg
    prt_info
    gum style "Setting up file variable $varName"
    export $varName="$varValue"
    style=win
    prt_info
    gum style "File Variable $varName is set to $varValue"
    sleep 0.25
done
style=msg
prt_info
gum style "Reading and Exporting All Setup Variables"
sleep 0.5
valueList=$(cat /opt/kevrevrun/status/values.list)
for v in $valueList; do
    varName=$(echo $v | cut -d ',' -f 1)
    fileName=$(echo $v | cut -d ',' -f 2)
    varValue=$(cat $fileName)
    style=msg
    prt_info
    gum style "Reading variable $varName"
    export $varName="$varValue"
    style=win
    prt_info
    gum style "Variable $varName has been imported with value $varValue"
    sleep 0.25
done
}
#END LOAD VARIABLES FUNCTIONS
stage1 () {
echo
style=msg
prt_info
gum style "Grabbing Debian release info..."
sleep 0.5
wget -nv https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/scripts/modules/2609ab672b.sh
exitStat=$?
errMsg="Debian release info script download failed."
successMsg="Debian release info script downloaded successfully"
chmod -v +x 2609ab672b.sh
exitStat=$?
errMsg="Added execute permission to Debian release info script failed."
successMsg="Added execute permission to Debian release info script sucessfully"
cmdFail
./2609ab672b.sh
echo
gum style "Removing Debian release info script..."
rm -vf 2609ab672b.sh
exitStat=$?
errMsg="Removing Debian release info script failed."
successMsg="Removing Debian release info script sucessfully"
cmdFail
echo
style=msg
prt_info
gum style "Setting up install variables..."
sleep 0.5
wget -nv https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/scripts/modules/2609783e82.sh
exitStat=$?
errMsg="Install variable script download failed."
successMsg="Install variable script downloaded successfully"
cmdFail
chmod -v +x 2609783e82.sh
exitStat=$?
errMsg="Added execute permission to install variable script failed."
successMsg="Added execute permission to install variable script sucessfully"
cmdFail
./2609783e82.sh
exitStat=$?
errMsg="Install variable script failed to run."
successMsg="Install variable script ran successfully"
cmdFail
echo
}
stage2 () {
style=msg
prt_info
gum style "Loading Variables"
sleep 1
loadVars
style=msg
prt_info
style=msg
prt_info
gum style "Downloading setup files script..."
sleep 0.5
wget -nv -O /opt/kevrevrun/scripts/modules/260955fa1e.sh https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/scripts/modules/260955fa1e.sh
exitStat=$?
errMsg="Setup files script download failed."
successMsg="Setup files script downloaded successfully"
cmdFail
gum spin "/opt/kevrevrun/scripts/modules/260955fa1e.sh"
exitStat=$?
errMsg="Setup files script failed to run."
successMsg="Setup files script ran successfully"
cmdFail
style=info
prt_info
gum style "The system requires a reboot to complete the upgrade process."
gum style "After the reboot, please run '$PWD/setup.sh' to continue the installation process"
gum style "The next step is to install Rustup."
sleep 1.5
nextStep=$(gum confirm "Are you ready to reboot the system?")
if [ $nextStep = 0 ]; then
    style=msg
    prt_info
    gum style "Rebooting system..."
    echo
    sleep 1
    echo "3" > $stageFile
    sudo reboot
    else
    style=msg
    prt_info
    gum style "Please restart your system before running the script again."
    style=info
    prt_info
    gum style "When you want to continue, please run"
    gum style "$PWD/setup.sh"
    style=msg
    prt_info
    gum style "This script will now exit."
    exit 1
fi
style=msg
prt_info
gum style "Starting Rust installation..."
sleep 1
/opt/kevrevrun/scripts/modules/2609180910.sh
exitStat=$?
errMsg="Rust installation script failed to run."
successMsg="Rust installed and script ran successfully"
cmdFail
style=msg
prt_info
gum style "The next step is to add i386 architecture to the system"
sleep 1
nextStep=$(gum confirm "Do you want to continue?")
if [ $nextStep = 0 ]; then
    style=msg
    prt_info
    gum style "Adding i386 architecture..."
    echo
    sleep 1
    echo "4" > $stageFile
    chk_stage
else
    style=msg
    prt_info
    gum style "Exit cancelled by user."
    style=info
    prt_info
    gum style "When you want to continue, please run"
    gum style "$PWD/setup.sh"
    style=msg
    prt_info
    gum style "This script will now exit."
    exit 1
fi
}
setup_stage () {
case $setupStg in
    1) 
        stage1
        ;;
    2) 
        stage2
        ;;
    3) 
        stage3
        ;;
    4) 
        stage4
        ;;
    5) 
        stage5
        ;;
    6) 
        stage6
        ;;
    7) 
        stage7
        ;;
    8) 
        stage8
        ;;
    9) 
        stage9
        ;;
    10) 
        stage10
        ;;
    11) 
        stage11
        ;;
    12) 
        stage12
        ;;
    13) 
        stage13
        ;;
    14) 
        stage14
        ;;
    15) 
        stage15
        ;;
    16) 
        stage16
        ;;
    17) 
        stage17
        ;;
    18) 
        stage18
        ;;
    19) 
        stage19
        ;;
    20) 
        stage20
        ;;
    21) 
        stage21
        ;;
    22) 
        stage22
        ;;
    23) 
        stage23
        ;;
    24) 
        stage24
        ;;
    25) 
        stage25
        ;;
    26) 
        stage26
        ;;
    27) 
        stage27
        ;;
    28) 
        stage28
        ;;
    29) 
        stage29
        ;;
    30) 
        stage30
        ;;
    *) 
        echo "Invalid stage"
        read -p "Press [Enter] key to exit..."
        exit 1
        ;;
esac
}
if [ "$setupStg" != "1" ]; then
    loadVars
    setup_stage
else
    setup_stage
fi
