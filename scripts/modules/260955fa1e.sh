#!/bin/bash
# 260955fa1e - downloads practical-wayland, copies folder contents to relative folders in kevrevrun
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
gum style "Downloading Practical Wayland from github"
sleep 1
git -C "$tmpDir" clone https://github.com/harbornode-ca/practical-wayland.git
if [ -d "$tmpDir/practical-wayland" ]; then
    style=win
    prt_info
    gum style "Practical Wayland sucessfully cloned"
    sleep 1
fi
style=info
prt_info
gum style "Setting up kevrevrun folder structure"
echo
sleep 1
style=msg
prt_info
gum style "Making sure file system is clean"
sleep 0.5
for f in "$scriptDir" "$cfgDir" "$dataDir" "$toolsDir"; do
    style=msg
    prt_info
    gum style "Ensuring folder $f is empty"
    rm -rvf "$f"/*
    exitStat=$?
    errMsg="Removing files from folder $f failed"
    successMsg="Removing files from folder $f completed successfully"
    cmdFail
    sleep 0.5
done
style=info
prt_info
echo
gum style "Installing setup files to main directories"
sleep 1
style=msg
prt_info
gum style "Copying files to folders"
sleep 0.5
for f in "$scriptDir" "$cfgDir" "$dataDir" "$toolsDir"; do
    srcFldr=$(echo $f | cut -d '/' -f 4)
    style=msg
    prt_info
    gum style "Copying files to folder $f"
    sleep 0.5
    cp -Rvf $tmpDir/practical-wayland/$srcFldr/* $f
    exitStat=$?
    errMsg="Copying files to folder $f failed"
    successMsg="Copying files to folder $f completed successfully"
    cmdFail
done
style=msg
prt_info
gum style "Cleaning up temporary files"
sleep 0.5
style=msg
prt_info
gum style "Removing temporary extraction folder"
sleep 0.5
rm -rvf "$tmpDir/practical-wayland"
exitStat=$?
errMsg="Removing temporary extraction folder"
successMsg="Successfully removed temporary extraction folder"
cmdFail
