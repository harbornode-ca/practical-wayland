#!/bin/bash
#This downloads Lemurs Login Manager repository, builds and installs the login manager.
#A default config file is included, as well as a basic niri laucher script.
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
echo "Installing dependacies for Lemurs"
sleep 0.5
echo
echo "Updating APT package cache"
sleep 0.5
echo
sudo apt update
if [ $? -ne 0 ]; then
    echo "apt package cache update failed"
    echo "Please try running the script again"
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
else
    echo "APT package cache updated successfully"
    sleep 0.5
fi
echo
echo "Installing Lemurs dependacies"
sleep 0.5
echo
sudo DEBIAN_FRONTEND=noninteractive apt install build-essential libpam0g-dev -y
if [ $? -ne 0 ]; then
    echo "Lemurs dependacies failed to install"
    echo "Please try running the script again"
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
else
    echo "Lemurs dependacies installed successfully"
    sleep 0.5
fi
echo
echo "Downloading and setting up Lemurs"
sleep 0.5
echo
echo "Cloning Lemurs Repository"
sleep 0.5
if [ -d "$tmpDir/lemurs" ]; then
    echo "Lemurs repository already cloned. Skipping"
    sleep 0.5
else
    cd $tmpDir
    git clone https://github.com/coastalwhite/lemurs.git 7151336a100e7a6266ec329d6cc356dec5c087ad
    if [ $? -ne 0 ]; then
        echo "Lemurs repository failed to clone"
        echo "Please try running the script again"
        sleep 1
        echo
        echo "This script will now exit"
        read -p "Press [ENTER] key to exit"
        clear
        exit 1
    else
        echo "Lemurs repository cloned successfully"
        sleep 0.5
        echo "Moving files"
        mv $tmpDir/7151336a100e7a6266ec329d6cc356dec5c087ad $tmpDir/lemurs
        if [ $? -ne 0 ]; then
            echo "Lemurs files failed to move"
            echo "Please try running the script again"
            sleep 1
            echo
            echo "This script will now exit"
            read -p "Press [ENTER] key to exit"
            clear
            exit 1
        else
            echo "Lemurs files moved successfully"
            sleep 0.5
        fi
    fi
fi
echo
echo "Building Lemurs from source"
sleep 0.5
echo
cd $tmpDir/lemurs
cargo build --release
if [ $? -ne 0 ]; then
    echo "Lemurs failed to build"
    echo "Please try running the script again"
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
else
    echo
    echo "Lemurs built successfully"
    sleep 0.5
fi
echo
echo "Installing and setting up Lemurs"
sleep 0.5
echo
echo "Installing lemurs binary from source"
sleep 0.5
sudo cp $tmpDir/lemurs/target/release/lemurs /usr/bin/lemurs
if [ $? -ne 0 ]; then
    echo "Lemurs binary failed to copy"
    echo "Please try running the script again"
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
else
    echo "Lemurs binary copied successfully"
    sleep 0.5
fi
echo
echo "Creating Lemurs configuration directories"
for dir in /etc/lemurs/wayland /etc/lemurs/wms; do
    if [ -d "$dir" ]; then
        echo "Lemurs configuration directory $dir already exists. Skipping"
        sleep 0.5
    else
        sudo mkdir -pv "$dir"
        if [ $? -ne 0 ]; then
            echo "Lemurs configuration directory $dir failed to create"
            echo "Please try running the script again"
            sleep 1
            echo
            echo "This script will now exit"
            read -p "Press [ENTER] key to exit"
            clear
            exit 1
        else
            echo "Lemurs configuration directory $dir created successfully"
            sleep 0.5
        fi
    fi
done
echo
echo "Installing Lemurs PAM module"
sleep 0.5
sudo cp -fv $tmpDir/lemurs/extra/lemurs.pam /etc/pam.d/lemurs
if [ $? -ne 0 ]; then
    echo "Lemurs PAM module failed to copy"
    echo "Please try running the script again"
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
else
    echo "Lemurs PAM module copied successfully"
    sleep 0.5
fi
echo
echo "Copying configuration files"
sudo cp -fv $cfgDir/dotfiles/lemurs-config.toml /etc/lemurs/config.toml
if [ $? -ne 0 ]; then
    echo "Lemurs configuration file failed to copy"
    echo "Please try running the script again"
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
else
    echo "Lemurs configuration file copied successfully"
    sleep 0.5
fi
echo
echo "Installing Lemurs systemd service files"
sudo cp -fv $tmpDir/lemurs/extra/lemurs.service /etc/systemd/system/lemurs.service
if [ $? -ne 0 ]; then
    echo "Lemurs systemd service file failed to copy"
    echo "Please try running the script again"
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
else
    echo "Lemurs systemd service file copied successfully"
    sleep 0.5
fi
echo
echo "Enabling Lemurs systemd service"
sleep 0.5
sudo systemctl daemon-reload
sudo systemctl enable --now lemurs.service
if [ $? -ne 0 ]; then
    echo "Lemurs systemd service failed to enable"
    echo "Please try running the script again"
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
else
    echo "Lemurs systemd service enabled successfully"
    sleep 0.5
fi
echo
echo "Lemurs has been installed and enabled successfully."
#TODO: Add default configuration file as well as Niri as a session option
sleep 0.5
