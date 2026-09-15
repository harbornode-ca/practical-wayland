#!/bin/bash
#This setups up the Danklinux Repository that contains a debian installer for niri and xwayland-sattelite 
#which is requrired for niri to support X11 apps.
cmdFail () {
if [ $? -ne 0 ]; then
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
echo "Starting niri install"
sleep 0.5
echo
echo "Adding repository for Niri"
sleep 0.5
echo Downloading DMS-key.gpg
wget -nv -O $tmpDir/DMS-key.gpg https://download.opensuse.org/repositories/home:AvengeMedia:danklinux/Debian_Testing/Release.key
exitStat=$?
errMsg="DMS-key.gpg failed to download"
successMsg="DMS-key.gpg downloaded successfully"
cmdFail
cat $tmpDir/DMS-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/DMS-key.gpg
exitStat=$?
errMsg="DMS-key.gpg failed to install"
successMsg="DMS-key.gpg installed successfully"
echo "Adding DMS repository to APT sources"
sudo cp -fv $cfgDir/install-cfg/dms.sources /etc/apt/sources.list.d/dms.sources
exitStat=$?
errMsg="Failed to add DMS repository to APT sources"
successMsg="DMS repository added successfully"
cmdFail
echo "Updating APT package cache"
sleep 0.5
sudo DEBIAN_FRONTEND=noninteractive apt update
exitStat=$?
errMsg="Failed to update APT package cache"
successMsg="APT package cache updated successfully"
cmdFail
echo
echo "Installing niri Dependencies"
echo
sleep 0.5
aptDeps=$(cat $cfgDir/deps/niri.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDeps -y
exitStat=$?
errMsg="Niri dependencies failed to install"
successMsg="Niri dependencies installed successfully"
cmdFail
echo "Installing Niri and Xwayland-Sattelite"
sleep 0.5
sudo DEBIAN_FRONTEND=noninteractive apt install niri xwayland-sattelite -y
exitStat=$?
errMsg="Niri and Xwayland-Sattelite failed to install"
successMsg="Niri and Xwayland-Sattelite installed successfully"
cmdFail
echo "Updating the stage file"
echo "9" > $stageFile
sleep 0.5
echo "Stage file updated"
sleep 0.5
echo 
echo "Niri has been installed and enabled successfully."
echo "Your system has been prepared for the next stage of installation."
echo
read -p "Press [ENTER] key to continue..."
clear
exit 0
