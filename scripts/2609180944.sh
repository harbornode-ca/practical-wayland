#!/bin/bash
#This setups up the Danklinux Repository that contains a debian installer for niri and xwayland-sattelite 
#which is requrired for niri to support X11 apps.
#!/bin/bash
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
echo "Starting niri install"
sleep 0.5
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
aptDeps=$(cat $cfgDir/deps/niri-build.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDeps -y
exitStat=$?
errMsg="Niri dependencies failed to install"
successMsg="Niri dependencies installed successfully"
cmdFail
git clone https://github.com/niri-wm/niri.git $tmpDir/niri
cd $tmpDir/niri
git checkout ee8a04bbaa9a20c53b9544cdd098ff54d8c509b4
cd $tmpDir/niri
cargo build --release
while IFS="," read -r src dest; do
    sudo cp -fv $tmpDir/niri/$src $dest
    exitStat=$?
    errMsg="Failed to copy $src to $dest"
    successMsg="Copied $src to $dest"
    cmdFail
done < "$cfgDir/install/niri-install.csv"
# **Add niri build from source here**
# **Add new script for Xwayland-satellite in new script it is a requirement
# for both niri and Umbriel to function properly**
echo "--------------------------------------------------"
echo "Niri has been installed and enabled successfully."
echo "--------------------------------------------------"
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