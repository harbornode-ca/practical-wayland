#!/bin/bash
#26095349f2.sh - Installs NVIDIA GPU drivers and packages.
#Author: kevrevun - kevin@kevrev.run

depNVIDIA=$(cat $aptDir/gpuNVIDIA.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $depNVIDIA -y
