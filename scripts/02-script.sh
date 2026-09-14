#!/bin/bash
#Removes an old style Debian .list files. Removes installer generated .sources file and adds Debian Forky repositories.
#Updates the system to Debian Forky (testing) and installs firmware packages. Exits prompting user to reboot to complete the update.
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
echo
echo "Removing non-modernized APT sources and setting up Debian Forky sources"
echo
sleep 0.5
oldRepos=$(find /etc/apt -name "sources.list*" -not -regex ".*/sources.list.d.*")
for r in $oldRepos; do
    sudo rm -fv $r
done
echo "Removed old APT sources files"
sleep 0.5
echo "Removing Debian installer generated source file"
if [ -f /etc/apt/sources.list.d/debian.sources ]; then
    sudo rm -fv /etc/apt/sources.list.d/debian.sources
    sleep 0.5
    echo "Debian installer generated source file removed"
else
    echo "No installer generated modernized source file detected."
    sleep 0.5
fi
echo
echo "Copying Forky sources to /etc/apt/sources.list.d/"
sleep 1
echo
sudo cp -fv "$cfgDir/debian-sources/enabledForky.sources" "/etc/apt/sources.list.d/forky.sources"
echo "Forky sources installed"
sleep 0.5
echo
echo "Updating APT package cache"
sleep 0.5
sudo apt update 2>&1 > $tmpDir/update.tmp
chkUpgrades=$(cat $tmpDir/update.tmp | grep -c "packages can be upgraded")
numUpdates=$(cat $tmpDir/update.tmp | grep "packages can be upgraded" | cut -d ' ' -f 1)
if [ $chkUpgrades != 0 ]; then
    echo "There are $numUpdates upgrades available!"
    echo "Updating system"
    sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
else
    echo "There are no updates available."
    sleep 0.5
    echo
    echo "System already up to date."
    sleep 0.5
fi
echo
echo "Updating the stage file"
sleep 0.5
echo "2" > $stageFile
sleep 0.5
echo "Stage file updated"
sleep 0.5
echo
echo "Upgrade process completed!"
echo "The system has been updated to Debian Forky. A reboot will complete the update process."
echo "Once the system reboots please run the main setup.sh script in your home directory to continue."
sleep 1
echo
read -p "Press [Enter] key when ready to reboot..."
clear
#reboot
exit 0