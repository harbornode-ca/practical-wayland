#!/bin/bash
#Installs Rust, Cargo and Just
#Downloads rustup.sh and installs Rust. Installs Just tool via Cargo.
#Removes the downloaded rustup.sh file after installation.
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
echo 
echo "Cleaning up temporary files"
sleep 0.5
rm -fv $tmpDir/rustup.sh
exitStat=$?
errMsg="Failed to remove temporary files"
successMsg="Temporary files removed successfully"
cmdFail
echo
echo "Updating the stage file"
sleep 0.5
echo "4" > $stageFile
sleep 0.5
echo "Stage file updated"
sleep 0.5
echo
echo "--------------------------------------------------"
echo "Rust,Cargo and Just have been installed successfully."
echo "--------------------------------------------------"
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