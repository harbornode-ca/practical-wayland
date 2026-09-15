#!/bin/bash
#This script will add a basic status bar called flatbar. It is a simple 2 colour status bar.
#It is not GPU acellerated and aims at having a small footprint. Relying on other tools to manage settings
#while providing basic information about the system.
#The bar requires foot terminal, fuzzel for dbus menu (will fall back to dbus popup), the TUI environment of network-manager for wifi and ethernet settings.
#Bluetooth connection and disconnection is managed by Flatbar but pairing and other settings is provided but Bluetui by default. A different manager can be specified in the config file.
#Bluetui needs to be built from source and is not in the default APT repositories. This will automatically be done during the install process.
#Rat commander ships as the main file manager with nemo being installed for handling GUI apps need for a GUI file manager. Mako is used as the notification daemon. and wl-clipboard for clipboard tools.
#At the moment this script gets the bare minimum installed for a user to get started. Future releases will add: idler, lockscreen, screenshots, screenrecording, VTT through Voxtype, and more.
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
    sleep 0.5
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
echo "Installing Flatbar"
sleep 0.5
echo
echo "Updating APT package cache"
sleep 0.5
sudo DEBIAN_FRONTEND=noninteractive apt update
exitStat=$?
errMsg="Failed to update APT package cache"
successMsg="APT package cache updated successfully"
cmdFail
echo "Installing Flatbar APT dependancies"
sleep 0.5
echo
aptDep=$(cat $cfgDir/deps/flatbar.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDep -y
exitStat=$?
errMsg="Flatbar APT dependancies failed to install"
successMsg="Flatbar APT dependancies installed successfully"
echo
echo "Downloading Flatbar"
sleep 0.5
gitURL=$(cat $cfgDir/install/git-commits.csv | grep -i flatbar | cut -d ',' -f 2)
gitTag=$(cat $cfgDir/install/git-commits.csv | grep -i flatbar | cut -d ',' -f 3)
if [ -d "$tmpDir/flatbar" ]; then
    echo "Flatbar directory already exists. Skipping download"
    sleep 0.5
else
    git -C "$tmpDir" clone $gitURL $gitTag
    exitStat=$?
    errMsg="Flatbar download failed"
    successMsg="Flatbar downloaded successfully"
    cmdFail
fi
echo "Moving flatbar source files into a new directory"
sleep 0.5
mv -v "$tmpDir/$gitTag" "$tmpDir/flatbar"
exitStat=$?
errMsg="Flatbar source files move failed"
successMsg="Flatbar source files moved successfully"
echo
echo "Building flatbar from source"
sleep 0.5
cd $tmpDir/flatbar
cargo build --release
exitStat=$?
errMsg="Flatbar build failed"
successMsg="Flatbar built successfully"
cmdFail
echo "Installing flatbar"
sleep 0.5
echo "Setting executable permissions for Flatbar binaries"
sleep 0.5
chmod -v +x "$tmpDir/flatbar/target/release/flatbar"
exitStat=$?
errMsg="Flatbar executable permission failed"
successMsg="Flatbar executable permission set successfully"
cmdFail
chmod -v +x "$tmpDir/flatbar/target/release/flatbar-core"
exitStat=$?
errMsg="Flatbar-core executable permission failed"
successMsg="Flatbar-core executable permission set successfully"
cmdFail
echo "Copying Flatbar binaries to /usr/bin"
sleep 0.5
sudo cp -v "$tmpDir/flatbar/target/release/flatbar" "/usr/bin/flatbar"
exitStat=$?
errMsg="Flatbar binary copy failed"
successMsg="Flatbar binary copied successfully"
cmdFail
echo "Creating systemwide flatbar config directory"
sleep 0.5
sudo mkdir -pv "/etc/flatbar"
exitStat=$?
errMsg="Flatbar config directory creation failed"
successMsg="Flatbar config directory created successfully"
cmdFail
echo "Copying flatbar config to /etc/flatbar"
sleep 0.5
sudo cp -v "$tmpDir/flatbar/extras/config.toml /etc/flatbar/config.toml"
exitStat=$?
errMsg="Flatbar config copy failed"
successMsg="Flatbar config copied successfully"
cmdFail
echo
echo "Flatbar installation completed"
sleep 0.5
echo
echo "Installing BlueTUI Bluetooth GUI"
sleep 0.5
echo "Downloading BlueTUI"
sleep 0.5
gitURL=$(cat $cfgDir/install/git-commits.csv | grep -i bluetui | cut -d ',' -f 2)
gitTag=$(cat $cfgDir/install/git-commits.csv | grep -i bluetui | cut -d ',' -f 3)
if [ -d "$tmpDir/bluetui" ]; then
    echo "BlueTUI directory already exists. Skipping download"
    sleep 0.5
else
    git -C "$tmpDir" clone $gitURL $gitTag
    exitStat=$?
    errMsg="BlueTUI download failed"
    successMsg="BlueTUI downloaded successfully"
    cmdFail
fi
echo "Moving Bluetui source files into a new directory"
sleep 0.5
mv -v "$tmpDir/$gitTag" "$tmpDir/bluetui"
exitStat=$?
errMsg="BlueTUI source files move failed"
successMsg="BlueTUI source files moved successfully"
cmdFail
echo "Building Bluetui from source"
sleep 0.5
cd $tmpDir/bluetui
echo "Building Bluetui release version"
sleep 0.5
cargo build --release
exitStat=$?
errMsg="BlueTUI build failed"
successMsg="BlueTUI build completed successfully"
cmdFail
echo "Installing Bluetui"
sleep 0.5
sudo cp -v target/release/bluetui /usr/bin/
exitStat=$?
errMsg="BlueTUI install failed"
successMsg="BlueTUI installed successfully"
cmdFail
echo
echo "BlueTUI installation completed"
sleep 0.5
echo
echo "Updating the stage file"
sleep 0.5
echo "11" > $stageFile
sleep 0.5
echo "Stage file updated"
sleep 0.5
echo
echo "--------------------------------------------------"
echo "Flatbar and BlueTUI have been installed successfully."
echo "You can continue with the setup process by running the 
echo "main setup.sh script in your home directory."
echo "-----------------------------------------------------------"
sleep 0.5
read -p "Do you want to continue to the next stage? \`[y/n]\`: " cont
if [[ $cont =~ ^[Yy]$ ]]; then
    echo "Continuing to next stage"
    sleep 1
    exit 0
else
    echo "Exiting script. Please run the main setup.sh script in your"
    echo "home directory to continue."
    sleep 1
    exit 1
fi
