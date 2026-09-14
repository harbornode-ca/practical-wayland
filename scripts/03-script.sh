#!/bin/bash
#Installs Rust, Cargo and Just
#Downloads rustup.sh and installs Rust. Installs Just tool via Cargo.
#Removes the downloaded rustup.sh file after installation.
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
echo "Installing Rust and Cargo"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > $tmpDir/rustup.sh
if [ -f $tmpDir/rustup.sh ]; then
    chmod +x $tmpDir/rustup.sh
    $tmpDir/rustup.sh -y
    source $HOME/.cargo/env
    echo
    echo "Rust installation complete!"
else
    echo "Rust installation failed!"
    echo "Please try installing Rust manually"
    Sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [Enter] key to exit..."
    exit 1
fi
echo
echo "Installing Just tool"
sleep 1
cargo install just
echo
echo "Just tool installed successfully!"
sleep 0.5
echo 
echo "Cleaning up temporary files"
sleep 0.5
rm -fv $tmpDir/rustup.sh
if [ $? = 0 ]; then
    echo
    echo "Temporary files removed successfully!"
else
    echo
    echo "Temporary files removal failed!"
    echo "Please try removing them manually"
    sleep 1
fi
echo
echo "Updating the stage file"
sleep 0.5
echo "3" > $stageFile
sleep 0.5
echo "Stage file updated"
sleep 0.5
echo 
echo "Rust,Cargo and Just have been installed successfully."
echo "Your system has been prepared for the next stage of installation."
sleep 1
echo
read -p "Press [Enter] key to continue..."
clear
exit 0