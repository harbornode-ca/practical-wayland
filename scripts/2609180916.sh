#!/bin/bash
#This script adds the new noctalia repository and installs the Noctalia Desktop Environment stack.
#This includes the noctalia package which is the main shell, the noctalia-greeter the login manager, 
#umbriel which is the compositor/WM, and xdg-desktop-portal-umbriel for desktop portal support.
#This will be installed with niri as Umbriel is still suffering from stability issues.
#This will be monitored and updated once Umbriel is deemed stable enough for daily use.
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
echo "Setting up Noctalia Repository"
sleep 0.5
echo
echo "Downloading keyring"
sleep 0.5
wget -nv -O $tmpDir/nickh-archive-keyring.deb https://pkg.noctalia.dev/deb/nickh-archive-keyring.deb
exitStat=$?
errMsg="Noctalia keyring failed to download"
successMsg="Noctalia keyring downloaded successfully"
cmdFail
echo
echo "Installing Noctalia Keyring"
sleep 0.5
sudo dpkg -i $tmpDir/nickh-archive-keyring.deb
exitStat=$?
errMsg="Noctalia keyring failed to install"
successMsg="Noctalia keyring installed successfully"
cmdFail
echo
echo "Downloading Noctalia APT sources file"
sleep 0.5
wget -nv -O $tmpDir/noctalia-unstable.sources https://pkg.noctalia.dev/deb/noctalia-unstable.sources
exitStat=$?
errMsg="Noctalia sources file failed to download."
successMsg="Noctalia sources file downloaded successfully"
cmdFail
echo "Adding Noctalia APT sources file to APT sources directory"
sleep 0.5
sudo mv -vf $tmpDir/noctalia-unstable.sources /etc/apt/sources.list.d/
exitStat=$?
errMsg="Noctalia sources file failed to move to APT sources directory"
successMsg="Noctalia sources file moved to APT sources directory successfully"
cmdFail
echo
echo "Updating APT packages cache"
sleep 0.5
echo
sudo apt update
exitStat=$?
errMsg="APT packages cache update failed"
successMsg="APT packages cache updated successfully"
cmdFail
echo
sleep 0.5
echo
echo "Installing packages from Noctalia repository"
sleep 0.5
echo
sudo DEBIAN_FRONTEND=noninteractive apt install noctalia noctalia-greeter umbriel xdg-desktop-portal-umbriel -y
exitStat=$?
errMsg="Noctalia packages failed to install"
successMsg="Noctalia packages installed successfully"
cmdFail
echo
echo "Cleaning up temporary files"
sleep 0.5
echo
rm -fv $tmpDir/nickh-archive-keyring.deb
exitStat=$?
errMsg="Noctalia keyring failed to remove"
successMsg="Noctalia keyring removed successfully"
cmdFail
rm -fv $tmpDir/noctalia-unstable.sources
exitStat=$?
errMsg="Noctalia sources file failed to remove"
successMsg="Noctalia sources file removed successfully"
cmdFail
echo "Temporary files cleaned up successfully"
sleep 0.5
echo "--------------------------------------------------"
echo "Noctalia repository has been set up and packages have been installed successfully."
echo "--------------------------------------------------"
sleep 1
