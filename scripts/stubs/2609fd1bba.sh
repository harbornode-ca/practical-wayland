#!/bin/bash
#2609fd1bba - Download and install Rust Toolkit

#Download rustup.sh
wget -O $tmpDir/rustup.sh https://sh.rustup.rs
#Make rustup.sh executable
chmod +x $tmpDir/rustup.sh
#Run rustup.sh with -y flag for non-interactive installation
$tmpDir/rustup.sh -y
#Remove rustup.sh from tmpDir
rm $tmpDir/rustup.sh
#Add cargo bin to PATH for this session
source $HOME/.cargo/env
