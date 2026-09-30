#!/bin/bash
#26098505c2.sh - Setup Noctalia sources file
#Author: kevinrevun - kevin@kevrev.run

wget -nv -O $tmpDir/noctalia-unstable.sources https://pkg.noctalia.dev/deb/noctalia-unstable.sources
sleep 1
sudo mv -vf $tmpDir/noctalia-unstable.sources /etc/apt/sources.list.d/
sleep 1
