#!/bin/bash
# 260955fa1e - downloads practical-wayland, copies folder contents to relative folders in kevrevrun

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

#START DOWNLOADING PRATICAL WAYLAND INSTALLER
style=info
prt_info
gum style "Downloading Practical Wayland Setup installer..."
echo
sleep 1
wget -nv https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/scripts/modules/2909b581a8.sh
echo
exitStat=$?
errMsg="Practical Wayland Setup installer part 1 download failed."
successMsg="Practical Wayland Setup installer part 1 downloaded successfully"
cmdFail
sleep 1
wget -nv https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/scripts/modules/260901abbc.sh
exitStat=$?
errMsg="Practical Wayland Setup installer part 2 download failed."
successMsg="Practical Wayland Setup installer part 2 downloaded successfully"
cmdFail
echo
gum style "Adding execute permission to Practical Wayland setup installer files"
chmod +x 2909b581a8.sh 260901abbc.sh
exitStat=$?
errMsg="Added execute permission to Practical Wayland Setup installer."
successMsg="Added execute permission to Practical Wayland Setup installer sucessfully"
cmdFail
sleep 1
echo
style=info
prt_info
gum style "Practical Wayland Setup installer files downloaded successfully"
sleep 1
echo
#END DOWNLOADING PRATICAL WAYLAND INSTALLER

#START INSTALLING PRATICAL WAYLAND
echo
style=info
prt_info
gum style "Installing Practical Wayland Setup."
echo
sleep 1
gum spin ./2909b581a8.sh
exitStat=$?
errMsg="Installing Practical Wayland Setup failed."
successMsg="Installing Practical Wayland Setup completed"
cmdFail
echo
sleep 1
gum spin ./260901abbc.sh
exitStat=$?
errMsg="Installing Practical Wayland Setup failed."
successMsg="Installing Practical Wayland Setup completed"
cmdFail
sleep 1
echo
style=info
prt_info
gum style "Practical Wayland Setup installation completed"
sleep 1
echo
#END INSTALLING PRATICAL WAYLAND

#START CLEANUP
gum style "Cleaning up temporary files"
sleep 1
gum style "Removing downloaded installer files"
sleep 0.5
rm -rf 2909b581a8.sh 260901abbc.sh
exitStat=$?
errMsg="Removing downloaded installer files failed."
successMsg="Successfully removed downloaded installer files"
cmdFail
sleep 0.5
gum style "Removing temporary download folder"
sleep 0.5
rm -rf "$tmpDir/practical-wayland"
exitStat=$?
errMsg="Removing temporary download folder failed."
successMsg="Successfully removed temporary download folder"
cmdFail
sleep 0.5
#END CLEANUP
