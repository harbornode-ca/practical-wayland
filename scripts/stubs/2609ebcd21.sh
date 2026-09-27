#!/bin/bash
#2609ebcd21 - Update Rust Toolchain

#Ensure the PATH is set for cargo
source $HOME/.cargo/env

#Update Rust Toolchain
rustup update -y
