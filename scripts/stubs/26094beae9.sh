#!/bin/bash
#26094beae9.sh - Script to download and install the NVIDIA driver repository
#Author: kevrevun - kevin@kevrev.run

urlNVIDIA=$(cat $urlDir/nvidia.url)
wget -nv -O $tmpDir/cuda.deb $urlNVIDIA
sudo dpkg -i $tmpDir/cuda.deb
