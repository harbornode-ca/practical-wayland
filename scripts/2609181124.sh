#!/bin/bash
#Installs WinApps and WinApps installer.
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

#**This needs to become and optional set as some computers will not have resources to 
#allocate for a windows installation. Will look into automatically checking resources and 
#making a recommendation based on results. Also look in to allowing a user to specify a remote
#Dockur Windows instanace**
echo "Installing Podman"
sleep 1
echo "Updating APT package cache"
sleep 1
sudo DEBIAN_FRONTEND=noninteractive apt update
exitStat=$?
errMsg="Failed to update APT package cache"
successMsg="Successfully updated APT package cache"
cmdFail
echo "Checking for podman binary"
sleep 1
if [ -f /usr/bin/podman ]; then
    echo "Podman main binary installed"
else
    echo "Podman is not installed."
    sleep 1
    echo "Installing podman"
    sleep 1
    sudo DEBIAN_FRONTEND=noninteractive apt install podman -y
    exitStat=$?
    errMsg="Failed to install podman"
    successMsg="Successfully installed podman"
    cmdFail
fi
echo "Checking for podman-compose binary"
sleep 1
if [ -f /usr/bin/podman-compose ]; then
    echo "Podman Compose binary installed"
else
    echo "Podman Compose is not installed."
    sleep 1
    echo "Installing podman-compose"
    sleep 1
    sudo DEBIAN_FRONTEND=noninteractive apt install podman-compose -y
    exitStat=$?
    errMsg="Failed to install podman-compose"
    successMsg="Successfully installed podman-compose"
    cmdFail
fi
echo "Starting WinApps and WinApps installer setup..."
sleep 0.5
echo
echo "Setting up user and password for WinApps installation"
sleep 1
read -p "Enter username: " RDP_USER
read -p "Enter password: " RDP_PASS
sleep 0.5
echo "User and password set to $RDP_USER and $RDP_PASS"
sleep 1.5
sed -i \
  -e "s|^RDP_USER=.*|RDP_USER=\"${RDP_USER}\"|" \
  -e "s|^RDP_PASS=.*|RDP_PASS=\"${RDP_PASS}\"|" \
  $installDir/winapps.conf
exitStat=$?
errMsg="Failed to set up user and password"
successMsg="Successfully applied user and password to config file"
cmdFail
echo
echo "Installing WinApps dependancies"
sleep 1
depWinApps=$(cat $swAptDir/winapps.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $depWinApps -y
exitStat=$?
errMsg="Failed to install WinApps dependancies"
successMsg="Successfully installed WinApps dependancies"
cmdFail
echo "Creating user mode WinApps config files"
sleep 1
if [ -d $HOME/.config/winapps/ ]; then
    echo "WinApps config folder already exists"
    echo "Skipping WinApps config folder creation"
    sleep 1
else
    echo "Creating WinApps config folder"
    sleep 1
    echo
    mkdir -p $HOME/.config/winapps/
    exitStat=$?
    errMsg="Failed to create WinApps config folder"
    successMsg="Successfully created WinApps config folder"
    cmdFail
fi
if [ -f $HOME/.config/winapps/winapps.conf ]; then
    echo "User WinApps config file already exists"
    read -p "Do you want to replace it? \[y/n]\: " overwrite
    if [[ $overwrite =~ ^[Yy]$ ]]; then
        echo "Replacing user WinApps config file"
        sleep 1
        cp -fv $installDir/winapps.conf $HOME/.config/winapps/
        exitStat=$?
        errMsg="Failed to replace user WinApps config file"
        successMsg="Successfully replaced user WinApps config file"
        cmdFail
    else
        echo "Skipping user WinApps config file replacement"
        sleep 1
    fi
else
    echo "Creating WinApps config file"
    sleep 1
    cp -fv $installDir/winapps.conf $HOME/.config/winapps/
    exitStat=$?
    errMsg="Failed to copy WinApps config file"
    successMsg="Successfully copied WinApps config folder"
    cmdFail
fi
echo "Setting directory permissions for WinApps config file"
sleep 1
chown $usrName:$usrName ~/.config/winapps/winapps.conf
exitStat=$?
errMsg="Failed to set directory permissions for WinApps config file"
successMsg="Successfully set directory permissions for WinApps config file"
cmdFail
echo "Setting permissions for WinApps config file"
sleep 1
chmod 600 $HOME/.config/winapps/winapps.conf
exitStat=$?
errMsg="Failed to set directory permissions for WinApps config file"
successMsg="Successfully set directory permissions for WinApps config file"
cmdFail
echo "Setting up WinApps Variables for Podman"
echo
sleep 1
read -p "Enter Windows Version [Default is 11]: " WIN_VERSION
if [ -z "$WIN_VERSION" ]; then
    WIN_VERSION="11"
fi
read -p "Enter RAM Size [Default is 8G]: " WIN_RAM
if [ -z "$WIN_RAM" ]; then
    WIN_RAM="8G"
fi
read -p "Enter CPU Cores [Default is 6]: " WIN_CPU
if [ -z "$WIN_CPU" ]; then
    WIN_CPU="6"
fi
read -p "Enter Disk Size [Default is 128G]: " WIN_DISK
if [ -z "$WIN_DISK" ]; then
    WIN_DISK="128G"
fi
#Note that RDP_USER and RDP_PASS are not asked for because they are already set via winapps.conf.
echo "Writting variables to WinApps compose.yaml file"
sleep 1
sed -i -E \
  -e "s|(VERSION:[[:space:]]*\")[^\"]*\"|\1${WIN_VERSION}\"|" \
  -e "s|(RAM_SIZE:[[:space:]]*\")[^\"]*\"|\1${WIN_RAM}\"|" \
  -e "s|(CPU_CORES:[[:space:]]*\")[^\"]*\"|\1${WIN_CPU}\"|" \
  -e "s|(DISK_SIZE:[[:space:]]*\")[^\"]*\"|\1${WIN_DISK}\"|" \
  -e "s|(USERNAME:[[:space:]]*\")[^\"]*\"|\1${RDP_USER}\"|" \
  -e "s|(PASSWORD:[[:space:]]*\")[^\"]*\"|\1${RDP_PASS}\"|" \
  $installDir/winapps-compose.yaml
if [ $? -ne 0 ]; then
    exitStat=$?
    errMsg="Failed to update WinApps Variables for Podman"
    successMsg="Successfully updated WinApps Variables for Podman"
    cmdFail
fi
echo
echo "Copying compose.yaml to WinApps config folder"
sleep 1
sudo cp -fv $installDir/winapps-compose.yaml $HOME/.config/winapps/compose.yaml
exitStat=$?
errMsg="Failed to copy compose.yaml to WinApps config folder"
successMsg="Successfully copied compose.yaml to WinApps config folder"
cmdFail
echo "Setting user ownership for compose.yaml"
sleep 1
chown $usrName:$usrName $HOME/.config/winapps/compose.yaml
exitStat=$?
errMsg="Failed to set user ownership for compose.yaml"
successMsg="Successfully set user ownership for compose.yaml"
cmdFail
echo "Setting user file permissions for compose.yaml"
sleep 1
chmod -v 700 ~/.config/winapps/compose.yaml
exitStat=$?
errMsg="Failed to set user file permissions for compose.yaml"
successMsg="Successfully set user file permissions for compose.yaml"
cmdFail
echo "Starting WinApps with Podman Compose"
sleep 1
sudo podman-compose --file ~/.config/winapps/compose.yaml up -d
exitStat=$?
errMsg="Failed to start WinApps"
successMsg="Successfully started WinApps"
cmdFail
echo
echo "----------------------------------------------------------------"
echo "You should now be able to connect to WinApps in the broswer"
echo "This script should launch the chromium browser automatically."
echo "If not, open the browser and navigate to http://127.0.0.1:8006/"
echo "----------------------------------------------------------------"
sleep 1