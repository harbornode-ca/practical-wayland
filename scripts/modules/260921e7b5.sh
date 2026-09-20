#!/bin/bash
#260921e7b5.sh - Installs Rustup, Cargo and Just

#START GUM STYLE FUNCTION
prt_info (){
case $style in
    info) export FOREGROUND=7; export BOLD=true;;
    msg) export FOREGROUND=3;;
    lose) export FOREGROUND=1; export BOLD=true;;
    win) export FOREGROUND=2; export BOLD=true;;
    *) export FOREGROUND=7; export BOLD=true;;
esac
}
#END GUM STYLE FUNCTION

#START CMD FAIL FUNCTION
cmdFail () {
if [ $exitStat -ne 0 ]; then
    style=lose
    prt_info    
    gum style "$errMsg"
    sleep 1
    echo
    style=msg
    prt_info
    gum style "This script will now exit"
    exit 1
else
    style=win
    prt_info
    gum style "$successMsg"
    sleep 0.5
fi
# These variables need to be set directly after a process ends to capture the $? value 
# and output a message, cmdFail runs function.
# exitStat=$?
# errMsg="ERROR MESSAGE"
# successMsg="SUCCESS MESSAGE"
# cmdFail
}
#END CMD FAIL FUNCTION


#START RUST INSTALLATION
style=info
prt_info
gum style "Installing Rust and Cargo"
sleep 0.5
echo
style=msg
prt_info
gum style "Checking for existing installation of Rust"
sleep 0.5
if [ -d "$HOME/.cargo" ]; then
    style=msg
    prt_info
    gum style "Rust is already installed"
    sleep 0.5
    echo
    style=info
    prt_info
    gum style "Updating Rust and Cargo"
    sleep 0.5
    gum spin 2609ad0bbc.sh
    exitStat=$?
    errMsg="Failed to update Rust and Cargo"
    successMsg="Rust and Cargo updated successfully"
    cmdFail
    echo
    style=info
    prt_info
    gum style "Exporting Cargo environment variable"
    sleep 0.5
    source $HOME/.cargo/env
    exitStat=$?
    errMsg="Cargo environment variable export failed"
    successMsg="Cargo environment variable exported successfully"
    cmdFail    
else
    style=info
    prt_info
    gum style "Rust not installed. Starting installation."
    sleep 0.5
    style=info
    prt_info
    gum style "Downloading installation script."
    sleep 0.5
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > $tmpDir/rustup.sh
    exitStat=$?
    errMsg="Failed to download installation script"
    successMsg="Installation script downloaded successfully"
    cmdFail
    echo
    style=info
    prt_info
    gum style "Setting executable permissions on installation script."
    sleep 0.5
    if [ -f $tmpDir/rustup.sh ]; then
        chmod +x $tmpDir/rustup.sh
        exitStat=$?
        errMsg="Failed to set executable permissions on installation script"
        successMsg="Installation script set to executable"
        cmdFail    
    fi
    echo
    style=info
    prt_info
    gum style "Installing Rust and Cargo"
    echo
    sleep 0.5
    gum spin 26099cd945.sh
    exitStat=$?
    errMsg="Failed to install Rust and Cargo"
    successMsg="Rust and Cargo installed successfully"
    cmdFail
    echo
    style=msg
    prt_info
    gum style "Exporting Cargo environment variable"
    sleep 0.5
    source $HOME/.cargo/env
    exitStat=$?
    errMsg="Cargo environment variable export failed"
    successMsg="Cargo environment variable exported successfully"
    cmdFail
fi
#END RUST INSTALLATION

#START JUST INSTALLATION
echo
style=info
prt_info
gum style "Installing Just using cargo"
sleep 0.5
gum spin 26092d9817.sh
exitStat=$?
errMsg="Failed to install Just"
successMsg="Just installed successfully"
cmdFail
sleep 0.5
echo
style=info
prt_info
gum style "Installing Just to /usr/local/sbin for sudo use"
sleep 0.5
sudo cp $HOME/.cargo/bin/just /usr/local/sbin/just
exitStat=$?
errMsg="Failed to copy Just to /usr/local/sbin"
successMsg="Just copied to /usr/local/sbin successfully"
cmdFail
echo 
style=info
prt_info
gum style "Cleaning up temporary files"
sleep 0.5
rm -fv $tmpDir/rustup.sh
exitStat=$?
errMsg="Failed to remove temporary files"
successMsg="Temporary files removed successfully"
#END JUST INSTALLATION

#END OF SCRIPT
