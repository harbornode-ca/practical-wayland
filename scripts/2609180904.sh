#!/bin/bash
#Removes an old style Debian .list files. Removes installer generated .sources file and adds Debian Forky repositories.
#Updates the system to Debian Forky (testing) and installs firmware packages. Exits prompting user to reboot to complete the update.
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
echo "Removing non-modernized APT sources and setting up Debian Forky sources"
echo
sleep 0.5
oldRepos=$(find /etc/apt -name "sources.list*" -not -regex ".*/sources.list.d.*")
for r in $oldRepos; do
    sudo rm -fv $r
    exitStat=$?
    errMsg="Removing $r failed"
    successMsg="Removed $r successfully"
    cmdFail    
done
echo "Removed old APT sources files"
sleep 0.5
echo "Removing Debian installer generated source file"
if [ -f /etc/apt/sources.list.d/debian.sources ]; then
    sudo rm -fv /etc/apt/sources.list.d/debian.sources
    exitStat=$?
    errMsg="Debian installer generated source file removal failed"
    successMsg="Debian installer generated source file removed successfully"
    cmdFail    
else
    echo "No installer generated modernized source file detected."
    sleep 0.5
fi
echo
echo "Copying Forky sources to /etc/apt/sources.list.d/"
sleep 1
echo
sudo cp -fv "$cfgDir/debian-sources/enabledForky.sources" "/etc/apt/sources.list.d/forky.sources"
exitStat=$?
errMsg="Copying Forky sources to /etc/apt/sources.list.d/ failed"
successMsg="Copying Forky sources to /etc/apt/sources.list.d/ completed successfully"
cmdFail    
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
    exitStat=$?
    errMsg="APT upgrade failed"
    successMsg="APT upgrade completed successfully"
    cmdFail    
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
echo "3" > $stageFile
sleep 0.5
echo "Stage file updated"
sleep 0.5
echo
echo "--------------------------------------------------"
echo "Upgrade process completed!"
echo "The system has been updated to Debian Forky." 
echo "A reboot is required to complete the update process."
echo "--------------------------------------------------"
read -p "Would you like to reboot now? \[y/n]\: " cont
if [[ $cont =~ ^[Yy]$ ]]; then
    echo "Rebooting"
    sleep 1
    clear
    sudo reboot
else
    echo "Please reboot manually to apply changes"
    sleep 1
    exit 1
fi