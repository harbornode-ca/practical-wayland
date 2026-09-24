#!/bin/bash
#2609fd1bba - Download Rust from rustup.sh

#Download and run rustup.sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#Load cargo environment variables
source $HOME/.cargo/env
