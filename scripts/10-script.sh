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
echo
echo "Updating APT package cache"
sleep 0.5
sudo DEBIAN_FRONTEND=noninteractive apt update
exitStat=$?
errMsg="Failed to update APT package cache"
successMsg="APT package cache updated successfully"
cmdFail
echo "Installing Flatbar APT dependancies"
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
cd $tmpDir/flatbar
cargo build --release
exitStat=$?
errMsg="Flatbar build failed"
successMsg="Flatbar built successfully"
cmdFail
echo "Installing flatbar"
echo "Setting executable permissions for Flatbar binaries"
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
sudo cp -v "$tmpDir/flatbar/target/release/flatbar" "/usr/bin/flatbar"
exitStat=$?
errMsg="Flatbar binary copy failed"
successMsg="Flatbar binary copied successfully"
cmdFail
echo "Creating systemwide flatbar config directory"
sudo mkdir -pv "/etc/flatbar"
exitStat=$?
errMsg="Flatbar config directory creation failed"
successMsg="Flatbar config directory created successfully"
cmdFail
echo "Copying flatbar config to /etc/flatbar"
sudo cp -v "$tmpDir/flatbar/extras/config.toml /etc/flatbar/config.toml"
exitStat=$?
errMsg="Flatbar config copy failed"
successMsg="Flatbar config copied successfully"
cmdFail
echo
echo "Flatbar installation completed"
echo
echo "Installing BlueTUI Bluetooth GUI"
echo
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
cd $tmpDir/bluetui
echo "Building Bluetui release version"
cargo build --release
exitStat=$?
errMsg="BlueTUI build failed"
successMsg="BlueTUI build completed successfully"
cmdFail
echo "Installing Bluetui"
sudo cp -v target/release/bluetui /usr/bin/
exitStat=$?
errMsg="BlueTUI install failed"
successMsg="BlueTUI installed successfully"
cmdFail
echo
echo "BlueTUI installation completed"

echo "Installing Rat Commander File Manager"
echo
echo "Downloading Rat Commander"
sleep 0.5
gitURL=$(cat $cfgDir/install/git-commits.csv | grep -i rat-commander | cut -d ',' -f 2)
gitTag=$(cat $cfgDir/install/git-commits.csv | grep -i rat-commander | cut -d ',' -f 3)
if [ -d "$tmpDir/rat-commander" ]; then
    echo "Rat Commander directory already exists. Skipping download"
    sleep 0.5
else
    git -C "$tmpDir" clone $gitURL $gitTag
    exitStat=$?
    errMsg="Rat Commander download failed"
    successMsg="Rat Commander downloaded successfully"
    cmdFail
fi
echo "Moving Rat Commander source files into a new directory"
sleep 0.5
mv -v "$tmpDir/$gitTag" "$tmpDir/rat-commander"
exitStat=$?
errMsg="Rat Commander source files move failed"
successMsg="Rat Commander source files moved successfully"
cmdFail
echo "Building Rat Commander from source"
cd $tmpDir/rat-commander
echo "Building Rat Commander release version"
cargo build --release
exitStat=$?
errMsg="Rat Commander build failed"
successMsg="Rat Commander build completed successfully"
cmdFail
echo "Installing Rat Commander"
sudo cp -v target/release/rat-commander /usr/bin/
exitStat=$?
errMsg="Rat Commander install failed"
successMsg="Rat Commander installed successfully"
cmdFail
#echo "Updating the stage file"
#echo "100" > $stageFile
#sleep 0.5
#echo "Stage file updated"
#sleep 0.5
echo 
echo "Flatbar, BlueTUI, and Rat Commander have been installed and enabled successfully."
echo "Your system has been prepared for the next stage of installation."
echo
read -p "Press [ENTER] key to continue..."
clear
exit 0