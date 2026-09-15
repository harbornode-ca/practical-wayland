#!/bin/bash
#Installs WinApps and WinApps installer.
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
echo "Starting WinApps and WinApps installer setup..."
echo
echo "Setting up user and password for WinApps installation"
read -p "Enter username: " RDP_USER
read -p "Enter password: " RDP_PASS
echo "User and password set to $RDP_USER and $RDP_PASS"
sed -i \
  -e "s|^RDP_USER=.*|RDP_USER=\"${RDP_USER}\"|" \
  -e "s|^RDP_PASS=.*|RDP_PASS=\"${RDP_PASS}\"|" \
  /home/kevin/practical-wayland/cfg/install/winapps.conf
exitStat=$?
errMsg="Failed to set up user and password"
successMsg="Successfully set up user and password"
cmdFail
echo
echo "Starting WinApps installation"
echo
bash $cfgDir/install/winapps.sh
exitStat=$?
errMsg="Failed to install WinApps"
successMsg="Successfully installed WinApps"
cmdFail
echo
echo "Starting WinApps installer setup"
echo
bash $cfgDir/install/winapps-installer.sh
exitStat=$?
errMsg="Failed to install WinApps installer"
successMsg="Successfully installed WinApps installer"
cmdFail
echo
echo "Installing WinApps dependancies"
depWinApps=$(cat $cfgDir/deps/winapps.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $depWinApps -y
exitStat=$?
errMsg="Failed to install WinApps dependancies"
successMsg="Successfully installed WinApps dependancies"
cmdFail
if [ -d $HOME/.config/winapps/ ]; then
    echo "WinApps config folder already exists"
    echo "Skipping WinApps config folder creation"
else
    echo "Creating WinApps config folder"
    echo
    mkdir -p $HOME/.config/winapps/
    exitStat=$?
    errMsg="Failed to create WinApps config folder"
    successMsg="Successfully created WinApps config folder"
    cmdFail
fi
if [ -f $HOME/.config/winapps/winapps.conf ]; then
    echo "WinApps config file already exists"
    echo "Skipping WinApps config file creation"
else
    echo "Creating WinApps config file"
    echo
    cp -fv $cfgDir/install/winapps.conf $HOME/.config/winapps/
    exitStat=$?
    errMsg="Failed to copy WinApps config file"
    successMsg="Successfully copied WinApps config folder"
    cmdFail
fi
echo "Setting directory permissions for WinApps config file"
chown $(whoami):$(whoami) ~/.config/winapps/winapps.conf
exitStat=$?
errMsg="Failed to set directory permissions for WinApps config file"
successMsg="Successfully set directory permissions for WinApps config file"
cmdFail
echo
chmod 600 ~/.config/winapps/winapps.conf
exitStat=$?
errMsg="Failed to set directory permissions for WinApps config file"
successMsg="Successfully set directory permissions for WinApps config file"
cmdFail
echo "Setting up WinApps Variables for Podman"
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
sed -i -E \
  -e "s|(VERSION:[[:space:]]*\")[^\"]*\"|\1${WIN_VERSION}\"|" \
  -e "s|(RAM_SIZE:[[:space:]]*\")[^\"]*\"|\1${WIN_RAM}\"|" \
  -e "s|(CPU_CORES:[[:space:]]*\")[^\"]*\"|\1${WIN_CPU}\"|" \
  -e "s|(DISK_SIZE:[[:space:]]*\")[^\"]*\"|\1${WIN_DISK}\"|" \
  -e "s|(USERNAME:[[:space:]]*\")[^\"]*\"|\1${RDP_USER}\"|" \
  -e "s|(PASSWORD:[[:space:]]*\")[^\"]*\"|\1${RDP_PASS}\"|" \
  /home/kevin/practical-wayland/cfg/install/winapps-compose.yaml
if [ $? -ne 0 ]; then
    exitStat=$?
    errMsg="Failed to update WinApps Variables for Podman"
    successMsg="Successfully updated WinApps Variables for Podman"
    cmdFail
fi
echo "Copying compose.yaml to WinApps config folder"
sudo cp -fv $cfgDir/install/winapps-compose.yaml $HOME/.config/winapps/compose.yaml
exitStat=$?
errMsg="Failed to copy compose.yaml to WinApps config folder"
successMsg="Successfully copied compose.yaml to WinApps config folder"
cmdFail
echo "Setting directory permissions for compose.yaml"
chown $(whoami):$(whoami) ~/.config/winapps/compose.yaml
exitStat=$?
errMsg="Failed to set directory permissions for compose.yaml"
successMsg="Successfully set directory permissions for compose.yaml"
cmdFail
echo
chmod 600 ~/.config/winapps/compose.yaml
exitStat=$?
errMsg="Failed to set directory permissions for compose.yaml"
successMsg="Successfully set directory permissions for compose.yaml"
cmdFail
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
read -p "Press [ENTER] key to exit"
exit 0