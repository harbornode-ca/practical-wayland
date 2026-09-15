#!/bin/bash
#This downloads Lemurs Login Manager repository, builds and installs the login manager.
#A default config file is included, as well as a basic niri laucher script.
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
echo "Installing dependacies for Lemurs"
sleep 0.5
echo
echo "Updating APT package cache"
sleep 0.5
sudo DEBIAN_FRONTEND=noninteractive apt update
exitStat=$?
errMsg="APT package cache update failed"
successMsg="APT package cache updated successfully"
cmdFail
echo "Installing Lemurs dependacies"
sleep 0.5
aptDeps=$(cat $cfgDir/deps/lemurs.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDeps -y
exitStat=$?
errMsg="Lemurs dependacies failed to install"
successMsg="Lemurs dependacies installed successfully"
cmdFail
echo
echo "Cloning Lemurs Repository"
sleep 0.5
if [ -d "$tmpDir/lemurs" ]; then
    echo "Lemurs repository already cloned. Skipping"
    sleep 0.5
else
    gitURL=$(cat $cfgDir/install/git-commits.csv | grep -i lemurs | cut -d ',' -f 2)
    gitTag=$(cat $cfgDir/install/git-commits.csv | grep -i lemurs | cut -d ',' -f 3)
    git -C "$tmpDir" clone $gitURL $gitTag
    exitStat=$?
    errMsg="Lemurs repository failed to clone"
    successMsg="Lemurs repository cloned successfully"
    cmdFail
    echo
    echo "Moving files"
    sleep 0.5
    mv "$tmpDir/$gitTag" "$tmpDir/lemurs"
    exitStat=$?
    errMsg="Lemurs files failed to move"
    successMsg="Lemurs files moved successfully"
    cmdFail
fi
echo
echo "Building Lemurs from source"
sleep 0.5
echo
cd $tmpDir/lemurs
cargo build --release
exitStat=$?
errMsg="Lemurs failed to build"
successMsg="Lemurs built successfully"
cmdFail
echo
echo "Installing and setting up Lemurs"
sleep 0.5
echo "Installing lemurs binary from source"
sleep 0.5
sudo cp $tmpDir/lemurs/target/release/lemurs /usr/bin/lemurs
exitStat=$?
errMsg="Lemurs binary failed to copy"
successMsg="Lemurs binary copied successfully"
cmdFail
echo
echo "Creating Lemurs configuration directories"
sleep 0.5
for dir in /etc/lemurs/wayland /etc/lemurs/wms; do
    if [ -d "$dir" ]; then
        echo "Lemurs configuration directory $dir already exists. Skipping"
        sleep 0.5
    else
        sudo mkdir -pv "$dir"
        exitStat=$?
        errMsg="Lemurs configuration directory $dir failed to create"
        successMsg="Lemurs configuration directory $dir created successfully"
        cmdFail
    fi
done
echo
echo "Installing Lemurs PAM module"
sleep 0.5
sudo cp -fv $tmpDir/lemurs/extra/lemurs.pam /etc/pam.d/lemurs
exitStat=$?
errMsg="Lemurs PAM module failed to copy"
successMsg="Lemurs PAM module copied successfully"
cmdFail
echo
echo "Copying configuration files"
sleep 0.5
sudo cp -fv $cfgDir/install/lemurs-config.toml /etc/lemurs/config.toml
exitStat=$?
errMsg="Lemurs configuration file failed to copy"
successMsg="Lemurs configuration file copied successfully"
cmdFail
echo
echo "Installing Lemurs systemd service files"
sleep 0.5
sudo cp -fv $tmpDir/lemurs/extra/lemurs.service /etc/systemd/system/lemurs.service
exitStat=$?
errMsg="Lemurs systemd service file failed to copy"
successMsg="Lemurs systemd service file copied successfully"
cmdFail
echo
echo "Enabling Lemurs systemd service"
sleep 0.5
sudo systemctl daemon-reload
exitStat=$?
errMsg="Lemurs systemd daemon-reload failed"
successMsg="Lemurs systemd daemon-reload successful"
cmdFail
sudo systemctl enable --now lemurs.service
exitStat=$?
errMsg="Lemurs systemd service failed to enable"
successMsg="Lemurs systemd service enabled successfully"
cmdFail
echo
echo "Lemurs has been installed and enabled successfully."
sleep 0.5
echo "Adding Niri startup file to /etc/lemurs/wayland directory"
sleep 0.5
sudo cp -fv $cfgDir/install/run-niri.sh /etc/lemurs/wayland/run-niri.sh
exitStat=$?
errMsg="Niri startup file failed to copy"
successMsg="Niri startup file copied successfully"
cmdFail
echo "Setting execute permissions on Niri startup file"
sleep 0.5
sudo chmod +x /etc/lemurs/wayland/run-niri.sh
exitStat=$?
errMsg="Niri startup file failed to set execute permissions"
successMsg="Niri startup file set execute permissions successfully"
cmdFail
echo
echo "Updating the stage file"
echo "9" > $stageFile
sleep 0.5
echo "Stage file updated"
sleep 0.5
echo 
echo "--------------------------------------------------"
echo "Lemurs has been installed and enabled successfully."
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
