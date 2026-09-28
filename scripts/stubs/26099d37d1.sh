#!/bin/bash
#26099d37d1.sh - Installs AMD GPU packages and drivers.
#Author: kevrevun - kevin@kevrev.run

depAMD=$(cat $aptDir/gpuAMD.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $depAMD -y