#!/bin/bash
#26092717e8.sh - Installs Intel GPU packages and drivers.
#Author: kevrevun - kevin@kevrev.run

depIntel=$(cat $aptDir/gpuIntel.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $depIntel -y
