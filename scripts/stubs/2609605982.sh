#!/bin/bash
#2609605982.sh - Installs Mesa basic GPU drivers and packages.
#Author: kevrevun - kevin@kevrev.run

depMesa=$(cat $aptDir/gpuMesa.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $depMesa -y