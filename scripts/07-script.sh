#!/bin/bash
#This script adds the new noctalia repository and installs the Noctalia Desktop Environment stack.
#This includes the noctalia package which is the main shell, the noctalia-greeter the login manager, 
#umbriel which is the compositor/WM, and xdg-desktop-portal-umbriel for desktop portal support.
echo
echo "Setting up Folder Variables"
echo
sleep 1
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
sleep 1
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
sleep 1
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
echo "Setting up Noctalia Repository"
echo
echo "Downloading keyring"
wget -nv -O $tmpDir/nickh-archive-keyring.deb https://pkg.noctalia.dev/deb/nickh-archive-keyring.deb
if [ -f $tmpDir/nickh-archive-keyring.deb ]; then
    echo "Download Complete"
    sleep 0.5
else
    echo "Noctalia keyring failed to download."
    echo "Please try running the script again."
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
fi
echo
echo "Installing Noctalia Keyring"
sudo dpkg -i $tmpDir/nickh-archive-keyring.deb
if [ $? -ne 0 ]; then
    echo "Noctalia keyring failed to install"
    echo "Please try running the script again"
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
else
    echo "Keyring installed successfully"
    sleep 0.5
fi
echo
echo "Downloading Noctalia APT sources file"
sleep 0.5
wget -nv -O $tmpDir/noctalia-unstable.sources https://pkg.noctalia.dev/deb/noctalia-unstable.sources
if [ -f $tmpDir/noctalia-unstable.sources ]; then
    echo "Download Complete"
    sleep 0.5
else
    echo "Noctalia sources file failed to download."
    echo "Please try running the script again."
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
fi
echo
echo "Adding Noctalia APT sources file to APT sources directory"
sleep 0.5
mv -vf $tmpDir/noctalia-unstable.sources /etc/apt/sources.list.d/
echo "Noctalia APT sources file added successfully"
sleep 0.5
echo
echo "Updating APT packages cache"
echo
sudo apt update
if [ $? -ne 0 ]; then
    echo "APT packages cache update failed"
    echo "Please try running the script again"
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
else
    echo "APT packages cache updated successfully"
    sleep 0.5
fi
echo
echo "Installing packages from Noctalia repository"
echo
sudo DEBIAN_FRONTEND=noninteractive apt install noctalia noctalia-greeter umbriel xdg-desktop-portal-umbriel -y
if [ $? -ne 0 ]; then
    echo "Noctalia packages failed to install"
    echo "Please try running the script again"
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
else
    echo "Noctalia packages installed successfully"
    sleep 0.5
fi
echo
echo "Cleaning up temporary files"
echo
rm -fv $tmpDir/nickh-archive-keyring.deb
rm -fv $tmpDir/noctalia-unstable.sources
echo "Temporary files cleaned up successfully"
sleep 0.5
echo
echo "Updating the stage file for stage 8!"
echo "7" > $stageFile
sleep 0.5
echo "Stage file updated"
sleep 0.5
echo 
echo "Noctalia repository has been set up and packages have been installed successfully."
echo "Your system has been prepared for the next stage of installation."
echo
read -p "Press [ENTER] key to continue..."
clear
exit 0
