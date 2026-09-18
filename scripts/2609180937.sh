#!/bin/bash
#This downloads Lemurs Login Manager repository, builds and installs the login manager.
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
    git clone $gitURL $tmpDir/lemurs
    exitStat=$?
    errMsg="Lemurs repository failed to clone"
    successMsg="Lemurs repository cloned successfully"
    cmdFail
    cd $tmpDir/lemurs
    git checkout $gitTag
    exitStat=$?
    errMsg="Lemurs repository failed to checkout tag"
    successMsg="Lemurs repository checkout tag successfully"
    cmdFail
fi
echo
echo "Building Lemurs from source"
sleep 0.5
cd $tmpDir/lemurs
cargo build --release
exitStat=$?
sleep 1
errMsg="Lemurs failed to build"
successMsg="Lemurs built successfully"
cmdFail
echo
echo "Installing and setting up Lemurs"
sleep 1
echo "Installing lemurs binary from source"
sleep 0.5
sudo cp $tmpDir/lemurs/target/release/lemurs /usr/bin/lemurs
exitStat=$?
errMsg="Lemurs binary failed to copy"
successMsg="Lemurs binary copied successfully"
cmdFail
echo
echo "Creating Lemurs configuration directories"
sleep 1
for dir in /etc/lemurs/wayland /etc/lemurs/wms; do
    if [ -d "$dir" ]; then
        echo "Lemurs configuration directory $dir already exists. Skipping"
        sleep 1
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
sleep 1
sudo cp -fv $tmpDir/lemurs/extra/lemurs.pam /etc/pam.d/lemurs
exitStat=$?
errMsg="Lemurs PAM module failed to copy"
successMsg="Lemurs PAM module copied successfully"
cmdFail
echo
echo "Copying configuration files"
sleep 1
sudo cp -fv $cfgDir/install/lemurs-config.toml /etc/lemurs/config.toml
exitStat=$?
errMsg="Lemurs configuration file failed to copy"
successMsg="Lemurs configuration file copied successfully"
cmdFail
echo
echo "Installing Lemurs systemd service files"
sleep 1
sudo cp -fv $tmpDir/lemurs/extra/lemurs.service /etc/systemd/system/lemurs.service
exitStat=$?
errMsg="Lemurs systemd service file failed to copy"
successMsg="Lemurs systemd service file copied successfully"
cmdFail
echo
echo "Enabling Lemurs systemd service"
sleep 1
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
sleep 1
echo 
echo "--------------------------------------------------"
echo "Lemurs has been installed and enabled successfully."
echo "--------------------------------------------------"
sleep 1