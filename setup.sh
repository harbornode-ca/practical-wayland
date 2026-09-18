#!/bin/bash
curID=$(cat /opt/kevrevrun/cfg/install/current.id)
stageFile="/opt/kevrevrun/status/setup.stage"
setupStg=$(cat "$stageFile")
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
chk_stage () {
setupStg=$(cat "$stageFile")
setup_stage
}
loadVars () {
echo "Setting up Folder Variables"
echo
sleep 0.5
fldrList=$(cat /opt/kevrevrun/status/folders.list)
for f in $fldrList; do
    varName=$(echo $f | cut -d ',' -f 1)
    varValue=$(echo $f | cut -d ',' -f 2)
    export $varName="$varValue" 2>&1
    echo "Folder Variable $varName is set to $varValue"
    sleep 0.25
done
echo
echo "Setting up File Variables"
sleep 0.5
echo
varFiles=$(cat /opt/kevrevrun/status/files.list)
for v in $varFiles; do
    varName=$(echo $v | cut -d ',' -f 1)
    varValue=$(echo $v | cut -d ',' -f 2)
    export $varName="$varValue"
    echo "File Variable $varName is set to $varValue"
    sleep 0.25
done
echo
echo "Reading and Exporting All Setup Variables"
sleep 0.5
echo
valueList=$(cat /opt/kevrevrun/status/values.list)
for v in $valueList; do
    varName=$(echo $v | cut -d ',' -f 1)
    fileName=$(echo $v | cut -d ',' -f 2)
    varValue=$(cat $fileName)
    export $varName="$varValue"
    echo "Variable $varName has been imported with value $varValue"
    sleep 0.25
done
}
stage1 () {
    echo "Inintializing the install process"
    sleep 1.5
    echo
    echo "Retrieving inintialization script."
    sleep 1
    wget -nv -O /opt/kevrevrun/scripts/2609180902.sh https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/scripts/2609180902.sh
    exitStat=$?
    errMsg="Script download failed."
    successMsg="Script downloaded successfully"
    cmdFail
    echo
    echo "Running script..."
    sleep 1
    chmod -v +x /opt/kevrevrun/scripts/2609180902.sh
    exitStat=$?
    errMsg="Setup Initialization script failed to run."
    successMsg="Setup Initialization script ran successfully"
    cmdFail
    echo
    echo "Next steps are to add the APT sources and upgrade the system to Debian $curID."
    read -p "Do you want to continue with the upgrade? \[Y/N] >\ " nextStep
    if [ $nextStep =~ ^[Yy]$ ]; then
        echo
        echo "Adding APT Sources and upgrading to Debian $curID..."
        echo
        sleep 1
        echo "2" > $stageFile
        chk_stage
    else
        echo
        echo "Exit cancelled by user."
        echo "When you want to continue, please run"
        echo "$PWD/setup.sh"
        echo
        echo "This script will now exit."
        sleep 1
        exit 1
    fi
}
stage2 () {
    echo "Loading Variables"
    sleep 1
    loadVars
    echo
    echo "Starting system update process..."
    sleep 1
    /opt/kevrevrun/scripts/2609180906.sh
    exitStat=$? 
    errMsg="System update script failed to run."
    successMsg="System update script ran successfully"
    cmdFail
    echo
    echo "The system requires a reboot to complete the upgrade process."
    echo "After the reboot, please run '$PWD/setup.sh' to continue the installation process"
    echo "The next step is to install Rustup."
    read -p "Are you ready to reboot the system? \[Y/N] >\ " nextStep
    if [ $nextStep =~ ^[Yy]$ ]; then
        echo
        echo "Rebooting system..."
        echo
        sleep 1
        echo "3" > $stageFile
        sudo reboot
    else
        echo
        echo "Please restart your system before running the script again."
        echo "When you want to continue, please run $PWD/setup.sh"
        echo
        read -p "Press [ENTER] key to exit"
        clear
        exit 1
    fi
}
stage3 () {
    echo "Starting Rust installation..."
    sleep 1
    /opt/kevrevrun/scripts/2609180910.sh
    exitStat=$?
    errMsg="Rust installation script failed to run."
    successMsg="Rust installed and script ran successfully"
    cmdFail
    echo
    echo "The next step is to add i386 architecture to the system"
    read -p "Do you want to continue? \[Y/N] >\ " nextStep
    if [ $nextStep =~ ^[Yy]$ ]; then
        echo
        echo "Adding i386 architecture..."
        echo
        sleep 1
        echo "4" > $stageFile
        chk_stage
    else
        echo
        echo "Exit cancelled by user."
        echo "When you want to continue, please run"
        echo "$PWD/setup.sh"
        echo
        echo "This script will now exit."
        sleep 1
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
