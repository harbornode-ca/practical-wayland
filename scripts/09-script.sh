#!/bin/bash
#This setups up the Danklinux Repository that contains a debian installer for niri and xwayland-sattelite 
#which is requrired for niri to support X11 apps.
echo
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
echo
echo Downloading DMS-key.gpg
wget -nv -O $tmpDir/DMS-key.gpg https://download.opensuse.org/repositories/home:AvengeMedia:danklinux/Debian_Testing/Release.key
if [ -f $tmpDir/DMS-key.gpg ]; then
    echo "DMS-key.gpg downloaded successfully"
    echo "Installing key to APT keyring"
    sleep 0.5
    cat $tmpDir/DMS-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/DMS-key.gpg
    if [ $? -ne 0 ]; then
        echo "Failed to install DMS-key.gpg"
        exit 1
    else
        echo "DMS-key.gpg installed successfully"
    fi
else
    echo "Failed to download DMS-key.gpg"
    exit 1
fi
echo
echo "Adding DMS repository to APT sources"
sudo cp -fv $cfgDir/install-cfg/dms.sources /etc/apt/sources.list.d/dms.sources
if [ $? -ne 0 ]; then
    echo "Failed to add DMS repository to APT sources"
    exit 1
else
    echo "DMS repository added successfully"
    sleep 0.5
fi
echo
echo "Updating APT package cache"
sleep 0.5
sudo apt update
if [ $? -ne 0 ]; then
    echo "Failed to update APT package cache"
    exit 1
else
    echo "APT package cache updated successfully"
    sleep 0.5
fi
echo
echo "Installing Niri and Xwayland-Sattelite"
sleep 0.5
sudo DEBIAN_FRONTEND=noninteractive apt install niri xwayland-sattelite
if [ $? -ne 0 ]; then
    echo "Failed to install Niri and Xwayland-Sattelite"
    exit 1
else
    echo "Niri and Xwayland-Sattelite installed successfully"
    sleep 0.5
fi
