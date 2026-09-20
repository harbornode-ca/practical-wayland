#!/bin/bash
stageFile="/opt/kevrevrun/status/setup.stage"
setupStg=$(cat "$stageFile")

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


#STAGE CHECK FUNCTION
chk_stage () {
setupStg=$(cat "$stageFile")
setup_stage
}
#END STAGE CHECK FUNCTION

#START GUM VARIABLES
#GUM CONFIRM VARIABLES
export GUM_CONFIRM_PROMPT_FOREGROUND=7
export GUM_CONFIRM_SELECTED_FOREGROUND=0
export GUM_CONFIRM_SELECTED_BACKGROUND=2
export GUM_CONFIRM_UNSELECTED_FOREGROUND=0
export GUM_CONFIRM_UNSELECTED_BACKGROUND=3
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

#START GUM SPIN VARIABLES
export GUM_SPIN_TITLE="Processing..."
export GUM_SPIN_SPINNER_FOREGROUND=3
export GUM_SPIN_TITLE_FOREGROUND=11
export GUM_SPIN_SPINNER="dot"
export GUM_SPIN_PADDING="1 0"
#END GUM SPIN VARIABLES

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
#END GUM VARIABLES

loadVars () {
#FOLDER VARIABLES
style=info
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
style=info
prt_info
gum style "Completed loading folder variables"
echo
sleep 0.5
#END FOLDER VARIABLES

#FILE VARIABLES
style=info
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
style=info
prt_info
gum style "Completed loading file variables"
echo
sleep 0.5
#END FILE VARIABLES

#VARIABLE VALUES
style=info
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
style=info
prt_info
gum style "Completed loading variable values"
echo
sleep 0.5
#END VARIABLE VALUES
}

# START SETUP INITIALIZATION STAGE
stage1 () {
style=info
prt_info
gum style "Grabbing Debian release info..."
sleep 0.5
echo
wget -nv https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/scripts/modules/2609ab672b.sh
exitStat=$?
errMsg="Debian release info script download failed."
successMsg="Debian release info script downloaded successfully"
chmod +x 2609ab672b.sh
exitStat=$?
errMsg="Added execute permission to Debian release info script failed."
successMsg="Added execute permission to Debian release info script sucessfully"
cmdFail
./2609ab672b.sh
echo
exitStat=$?
errMsg="Debian release info script failed to run."
successMsg="Debian release info script ran successfully"
cmdFail
style=info
prt_info
gum style "Removing Debian release info script..."
rm -f 2609ab672b.sh
exitStat=$?
errMsg="Removing Debian release info script failed."
successMsg="Removing Debian release info script sucessfully"
cmdFail
echo
style=info
prt_info
gum style "Setting up install variables..."
sleep 0.5
wget -nv https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/scripts/modules/2609783e82.sh
exitStat=$?
errMsg="Install variable script download failed."
successMsg="Install variable script downloaded successfully"
echo
cmdFail
chmod +x 2609783e82.sh
exitStat=$?
errMsg="Added execute permission to install variable script failed."
successMsg="Added execute permission to install variable script sucessfully"
cmdFail
echo
./2609783e82.sh
echo
exitStat=$?
errMsg="Install variable script failed to run."
successMsg="Install variable script ran successfully"
cmdFail
echo
style=info
prt_info
gum style "Removing Install variable script..."
rm -f 2609783e82.sh
exitStat=$?
errMsg="Removing Install variable script failed."
successMsg="Removing Install variable script sucessfully"
cmdFail
echo
style=info
prt_info
gum style "Setup initialization process is complete!"
sleep 0.5
echo
gum style "Next stage installs Practical Wayland files!"
gum style "You can continue installation or come back later to continue."
sleep 0.5
echo "2" > $stageFile
gum confirm "Continue Installation?"
exitStat=$?
if [ $exitStat = 0 ]; then
    style=info
    prt_info
    echo
    gum style "Continuing..."
    sleep 1
    gum style "Loading Variables"
loadVars
    stage2
else
    echo
    style=info
    prt_info
    gum style "Installation cancelled by user."
    echo
    gum style "When you want to continue, please run"
    gum style "$PWD/setup.sh"
    echo
    style=msg
    prt_info
    gum style "This script will now exit."
    exit 0
fi
}
# END SETUP INITIALIZATION STAGE

# START PRACTICAL WAYLAND INSTALL
stage2 () {
style=info
prt_info
gum style "Downloading setup files script..."
echo
sleep 1
wget -nv https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/scripts/modules/260955fa1e.sh
exitStat=$?
errMsg="Setup files script download failed."
successMsg="Setup files script downloaded successfully"
cmdFail
echo
sleep 1
chmod +x 260955fa1e.sh
exitStat=$?
errMsg="Added execute permission to setup files script failed."
successMsg="Added execute permission to setup files script sucessfully"
cmdFail
echo
style=info
prt_info
gum style "Installing Practical Wayland Setup Files..."
echo
sleep 1
./260955fa1e.sh
echo
exitStat=$?
errMsg="Practical Wayland Setup failed."
successMsg="Practical Wayland Setup completed successfully!"
cmdFail
echo
style=info
prt_info
gum style "Removing setup files script..."
rm -f 260955fa1e.sh
exitStat=$?
errMsg="Removing setup files script failed."
successMsg="Removing setup files script sucessfully"
cmdFail
echo
sleep 1
gum style "Next stage is system upgrade!"
gum style "You can continue installation or come back later to continue."
sleep 0.5
echo "3" > $stageFile
gum confirm "Continue Installation?"
exitStat=$?
if [ $exitStat = 0 ]; then
    style=info
    prt_info
    echo
    gum style "Continuing..."
    sleep 1
    chk_stage
else
    echo
    style=info
    prt_info
    gum style "Installation cancelled by user."
    echo
    gum style "When you want to continue, please run"
    gum style "$PWD/setup.sh"
    echo
    style=msg
    prt_info
    gum style "This script will now exit."
    exit 0
fi
}
# END PRACTICAL WAYLAND INSTALL

stage3 () {
echo
style=info
prt_info
gum style "Adding i386 32bit Architecture to supported architectures..."
sleep 1
$moduleDir/26096d86bc.sh
exitStat=$?
errMsg="Failed to add i386 32bit architecture support"
successMsg="i386 32bit architecture support added successfully"
cmdFail
echo "4" > $stageFile
sleep 1
chk_stage
}
# START SYSTEM UPGRADE STAGE
stage4 () {
style=info
prt_info
gum style "Starting system upgrade to Debian $debVerName"
sleep 1
$moduleDir/26090ffbdb.sh
exitStat=$?
errMsg="Upgrading to Debian $debVerName failed!"
successMsg="System upgraded to Debian $debVerName successfully!"
cmdFail
sleep 0.5
echo
gum style "The system requires a reboot to complete the upgrade process."
gum style "After the reboot, please run '$PWD/setup.sh' to continue the installation process"
gum style "The next step installs the Rust Toolkit"
echo
sleep 0.5
echo "5" > $stageFile
gum confirm "Are you ready to reboot the system?"
exitStat=$?
if [ $exitStat = 0 ]; then
    style=msg
    prt_info
    gum style "Rebooting system..."
    echo
    sleep 1
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
}
# END SYSTEM UPGRADE STAGE

# START RUST INSTALLATION STAGE
stage5() {
style=msg
prt_info
gum style "Starting Rust installation..."
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
clear
if [ "$setupStg" != "1" ]; then
    loadVars
    setup_stage
else
    setup_stage
fi
