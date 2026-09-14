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
    echo "$sucessMsg"
fi
}
#These variables need to be set directly after a process ends to capture the $? value and output a message, cmdFail runs function.
#exitStat=$?
#errMsg="ERROR MESSAGE"
#sucessMsg="SUCCESS MESSAGE"
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
sucessMsg="APT package cache updated successfully"
cmdFail
echo "Installing Flatbar APT dependancies"
echo
aptDep=$(cat $cfgDir/deps/flatbar.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDep -y
exitStat=$?
errMsg="Flatbar APT dependancies failed to install"
sucessMsg="Flatbar APT dependancies installed successfully"
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
    sucessMsg="Flatbar downloaded successfully"
    cmdFail
fi
echo "Moving flatbar source files into a new directory"
sleep 0.5
mv -v "$tmpDir/$gitTag" "$tmpDir/flatbar"
exitStat=$?
errMsg="Flatbar source files move failed"
sucessMsg="Flatbar source files moved successfully"
echo
echo "Building flatbar from source"
cd $tmpDir/flatbar
cargo build --release
exitStat=$?
errMsg="Flatbar build failed"
sucessMsg="Flatbar built successfully"
cmdFail
echo "Installing flatbar"
echo "Setting executable permissions for Flatbar binaries"
chmod -v +x "$tmpDir/flatbar/target/release/flatbar"
exitStat=$?
errMsg="Flatbar executable permission failed"
sucessMsg="Flatbar executable permission set successfully"
cmdFail
chmod -v +x "$tmpDir/flatbar/target/release/flatbar-core"
exitStat=$?
errMsg="Flatbar-core executable permission failed"
sucessMsg="Flatbar-core executable permission set successfully"
cmdFail
echo "Copying Flatbar binaries to /usr/bin"
sudo cp -v "$tmpDir/flatbar/target/release/flatbar" "/usr/bin/flatbar"
exitStat=$?
errMsg="Flatbar binary copy failed"
sucessMsg="Flatbar binary copied successfully"
cmdFail
echo "Creating systemwide flatbar config directory"
sudo mkdir -pv "/etc/flatbar"
exitStat=$?
errMsg="Flatbar config directory creation failed"
sucessMsg="Flatbar config directory created successfully"
cmdFail
echo "Copying flatbar config to /etc/flatbar"
sudo cp -v "$tmpDir/flatbar/extras/config.toml /etc/flatbar/config.toml"
exitStat=$?
errMsg="Flatbar config copy failed"
sucessMsg="Flatbar config copied successfully"
cmdFail
echo
echo "Flatbar installation completed"
echo
echo "Installing Foot terminal editor"
echo
echo "Installing Foot APT dependancies"
aptDep=$(cat $cfgDir/deps/foot.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDep -y
exitStat=$?
errMsg="Foot APT dependancies failed to install"
sucessMsg="Foot APT dependancies installed successfully"
echo
echo "Downloading Foot"
sleep 0.5
gitURL=$(cat $cfgDir/install/git-commits.csv | grep -i foot | cut -d ',' -f 2)
gitTag=$(cat $cfgDir/install/git-commits.csv | grep -i foot | cut -d ',' -f 3)
if [ -d "$tmpDir/foot" ]; then
    echo "Foot directory already exists. Skipping download"
    sleep 0.5
else
    git -C "$tmpDir" clone $gitURL $gitTag
    exitStat=$?
    errMsg="Foot download failed"
    sucessMsg="Foot downloaded successfully"
    cmdFail
fi
echo "Moving foot source files into a new directory"
sleep 0.5
mv -v "$tmpDir/$gitTag" "$tmpDir/foot"
exitStat=$?
errMsg="Foot source files move failed"
sucessMsg="Foot source files moved successfully"
echo
echo "Building foot from source"
cd $tmpDir/foot
export CC=clang-22
echo "Creating meson build directory"
mkdir -pv bld/release
exitStat=$?
errMsg="Foot directory creation failed"
sucessMsg="Foot directory created successfully"
cmdFail
echo "Configuring meson build for foot"
meson setup --buildtype=release bld/release
exitStat=$?
errMsg="Foot configuration failed"
sucessMsg="Foot configuration completed successfully"
cmdFail
cd $tmpDir/foot/bld/release
echo "Building foot from source"
ninja
exitStat=$?
errMsg="Foot build failed"
sucessMsg="Foot build completed successfully"
cmdFail
echo "Installing foot from source"
sudo ninja install
exitStat=$?
errMsg="Foot install failed"
sucessMsg="Foot installed successfully"
cmdFail 