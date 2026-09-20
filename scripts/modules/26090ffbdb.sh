#!/bin/bash
#Removes an old style Debian .list files. Removes installer generated .sources file and adds Debian Forky repositories.
#Updates the system to Debian Forky (testing) and installs firmware packages. Exits prompting user to reboot to complete the update.
prt_info () {
case $style in
    info) export FOREGROUND=7; export BOLD=true;;
    msg) export FOREGROUND=3;;
    lose) export FOREGROUND=1; export BOLD=true;;
    win) export FOREGROUND=2; export BOLD=true;;
    *) export FOREGROUND=7; export BOLD=true;;
esac
}
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
}
# These variables need to be set directly after a process ends to capture the $? value and output a message, cmdFail runs function.
# exitStat=$?
# errMsg="ERROR MESSAGE"
# successMsg="SUCCESS MESSAGE"
# cmdFail
style=msg
prt_info
gum style "Removing non-modernized APT sources and setting up Debian Forky sources"
echo
sleep 0.5
oldRepos=$(find /etc/apt -name "sources.list*" -not -regex ".*/sources.list.d.*")
for r in $oldRepos; do
    style=msg
    prt_info
    gum style "Removing $r"
    sudo rm -fv $r
    exitStat=$?
    errMsg="Removing $r failed"
    successMsg="Removed $r successfully"
    cmdFail    
done
style=win
prt_info
gum style "Removed old APT sources files"
sleep 0.5
echo "Removing Debian installer generated source file"
if [ -f /etc/apt/sources.list.d/debian.sources ]; then
    style=msg
    prt_info
    gum style "Removing /etc/apt/sources.list.d/debian.sources"
    sudo rm -fv /etc/apt/sources.list.d/debian.sources
    exitStat=$?
    errMsg="Debian installer generated source file removal failed"
    successMsg="Debian installer generated source file removed successfully"
    cmdFail    
else
    style=win
    prt_info
    gum style "No installer generated modernized source file detected."
    sleep 0.5
fi
style=msg
prt_info
gum style "Copying Forky sources to /etc/apt/sources.list.d/"
sleep 1
sudo cp -fv "$cfgDir/debian-sources/enabledForky.sources" "/etc/apt/sources.list.d/forky.sources"
exitStat=$?
errMsg="Copying Forky sources to /etc/apt/sources.list.d/ failed"
successMsg="Copying Forky sources to /etc/apt/sources.list.d/ completed successfully"
cmdFail    
style=msg
prt_info
gum style "Updating APT package cache"
sleep 0.5
sudo apt update 2>&1 > $tmpDir/update.tmp
chkUpgrades=$(cat $tmpDir/update.tmp | grep -c "packages can be upgraded")
numUpdates=$(cat $tmpDir/update.tmp | grep "packages can be upgraded" | cut -d ' ' -f 1)
if [ $chkUpgrades != 0 ]; then
    style=msg
    prt_info
    gum style "There are $numUpdates upgrades available!"
    style=msg
    prt_info
    gum style "Updating system"
    sudo DEBIAN_FRONTEND=noninteractive apt upgrade -y
    exitStat=$?
    errMsg="APT upgrade failed"
    successMsg="APT upgrade completed successfully"
    cmdFail    
else
    style=win
    prt_info
    gum style "There are no updates available."
    sleep 0.5
    style=win
    prt_info
    gum style "System already up to date."
    sleep 0.5
fi
style=win
prt_info
gum style "Upgrade process completed!"
sleep 1
style=msg
prt_info
gum style "The system has been updated to Debian Forky."
sleep 1
style=msg
prt_info
gum style "A reboot is required to complete the update process."
sleep 1
