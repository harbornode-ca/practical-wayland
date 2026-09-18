#!/bin/bash
#This script will add a basic status bar called flatbar. It is a simple 2 colour status bar.
#It is not GPU acellerated and aims at having a small footprint. Relying on other tools to manage settings
#while providing basic information about the system.
#The bar requires foot terminal, fuzzel for dbus menu (will fall back to dbus popup), the TUI environment of network-manager for wifi and ethernet settings.
#Bluetooth connection and disconnection is managed by Flatbar but pairing and other settings is provided but Bluetui by default. A different manager can be specified in the config file.
#Bluetui needs to be built from source and is not in the default APT repositories. This will automatically be done during the install process.
#Rat commander ships as the main file manager with nemo being installed for handling GUI apps need for a GUI file manager. Mako is used as the notification daemon. and wl-clipboard for clipboard tools.
#At the moment this script gets the bare minimum installed for a user to get started. Future releases will add: idler, lockscreen, screenshots, screenrecording, VTT through Voxtype, and more.
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

#**Add in new script for Ashell build from source.**
#**BlueTUI is not needed for bluetooth management and will be added as an optional software package.**
#**Move this script to a new folder for optional software installation.**
echo "Installing BlueTUI Bluetooth GUI"
sleep 0.5
echo "Installing BlueTUI from crates.io"
cargo install bluetui
exitStat=$?
errMsg="BlueTUI install failed"
successMsg="BlueTUI installed successfully"
cmdFail
echo "Installing Bluetui into /usr/bin/bluetui"
sleep 1
sudo cp -fv $HOME/.cargo/bin/bluetui /usr/bin/
exitStat=$?
errMsg="Bluetui install failed"
successMsg="Bluetui is now on system PATH"
cmdFail
echo "BlueTUI installation completed"
sleep 1
echo
echo "--------------------------------------------------"
echo "BlueTUI have been installed successfully."
echo "---------------------------------------------------"
sleep 1
