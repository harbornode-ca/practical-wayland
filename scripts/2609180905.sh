#!/bin/bash
#Installs Rust, Cargo and Just
#Downloads rustup.sh and installs Rust. Installs Just tool via Cargo.
#Removes the downloaded rustup.sh file after installation.
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
echo "Installing Rust and Cargo"
sleep 0.5
echo
echo "Checking for existing installation of Rust"
sleep 0.5
if [ -d "$HOME/.cargo" ]; then
    echo "Rust is already installed"
    sleep 0.5
    echo "Updating Rust and Cargo"
    sleep 0.5
    rustup update
    exitStat=$?
    errMsg="Failed to update Rust and Cargo"
    successMsg="Rust and Cargo updated successfully"
    cmdFail
    source $HOME/.cargo/env
    exitStat=$?
    errMsg="Cargo environment variable export failed"
    successMsg="Cargo environment variable exported successfully"
    cmdFail    
else
    echo "Rust not installed. Starting installation."
    sleep 0.5
    echo "Downloading installation script."
    sleep 0.5
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > $tmpDir/rustup.sh
    exitStat=$?
    errMsg="Failed to download installation script"
    successMsg="Installation script downloaded successfully"
    cmdFail
    echo
    echo "Setting executable permissions on installation script."
    sleep 0.5
    if [ -f $tmpDir/rustup.sh ]; then
        chmod +x $tmpDir/rustup.sh
        exitStat=$?
        errMsg="Failed to set executable permissions on installation script"
        successMsg="Installation script set to executable"
        cmdFail    
    fi
    $tmpDir/rustup.sh -y
    exitStat=$?
    errMsg="Failed to install Rust and Cargo"
    successMsg="Rust and Cargo installed successfully"
    cmdFail
    source $HOME/.cargo/env
    exitStat=$?
    errMsg="Cargo environment variable export failed"
    successMsg="Cargo environment variable exported successfully"
    cmdFail
fi
echo
echo "Installing Just using cargo"
sleep 0.5
cargo install just
exitStat=$?
errMsg="Failed to install Just"
successMsg="Just installed successfully"
cmdFail
echo "Installing Just to /usr/local/sbin for sudo use"
sudo cp $HOME/.cargo/bin/just /usr/local/sbin/just
exitStat=$?
errMsg="Failed to copy Just to /usr/local/sbin"
successMsg="Just copied to /usr/local/sbin successfully"
cmdFail
echo 
echo "Cleaning up temporary files"
sleep 0.5
rm -fv $tmpDir/rustup.sh
exitStat=$?
errMsg="Failed to remove temporary files"
successMsg="Temporary files removed successfully"
cmdFail
echo
echo "--------------------------------------------------"
echo "Rust,Cargo and Just have been installed successfully."
echo "--------------------------------------------------"
sleep 1
