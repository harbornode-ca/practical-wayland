#!/bin/bash
#26090ffbdb.sh - Removes an old style Debian .list files. Removes installer generated .sources file and adds Debian Forky repositories.
#Updates the system to Debian Forky (testing) and installs firmware packages. Exits prompting user to reboot to complete the update.

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


#START SETUP APT SOURCES
style=info
prt_info
gum style "Removing non-modernized APT sources and setting up Debian Forky sources"
echo
sleep 0.5
oldRepos=$(find /etc/apt -name "sources.list*" -not -regex ".*/sources.list.d.*")
for r in $oldRepos; do
    style=msg
    prt_info
    gum style "Removing $r"
    sudo rm -f $r
    exitStat=$?
    errMsg="Removing $r failed"
    successMsg="Removed $r successfully"
    cmdFail
    sleep 0.25 
done
echo
style=win
prt_info
gum style "Removed old APT sources files"
sleep 0.5
echo
style=msg
prt_info
gum style "Removing Debian installer generated source file"
sleep 0.5

if [ -f /etc/apt/sources.list.d/debian.sources ]; then
    style=msg
    prt_info
    gum style "Removing /etc/apt/sources.list.d/debian.sources"
    sudo rm -f /etc/apt/sources.list.d/debian.sources
    exitStat=$?
    errMsg="Debian installer generated source file removal failed"
    successMsg="Debian installer generated source file removed successfully"
    cmdFail
    sleep 0.25    
else
    style=win
    prt_info
    gum style "No installer generated modernized source file detected."
    sleep 0.5
fi
echo
style=info
prt_info
gum style "Copying $debVerName sources to /etc/apt/sources.list.d/"
sleep 0.5
sudo cp -f "$cfgDir/apt/enabled$debVerName.sources" "/etc/apt/sources.list.d/$debVerID.sources"
exitStat=$?
errMsg="Copying $debVerName sources to /etc/apt/sources.list.d/ failed"
successMsg="Copying $debVerName sources to /etc/apt/sources.list.d/ completed successfully"
cmdFail    
echo
#END SETUP APT SOURCES

#START APT UPDATE
style=info
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
    gum spin $spinDir/2609f211fe.sh
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
gum style "The system has been updated to Debian $DebVerName."
sleep 1
style=msg
prt_info
gum style "A reboot is required to complete the update process."
sleep 1
