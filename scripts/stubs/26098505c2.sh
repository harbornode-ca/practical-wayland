#!/bin/bash
#tempate.sh - Template Script (PUT SCRIPT DESCRIPTION HERE)

wget -nv -O $tmpDir/noctalia-unstable.sources https://pkg.noctalia.dev/deb/noctalia-unstable.sources
sleep 0.5
sudo mv -vf $tmpDir/noctalia-unstable.sources /etc/apt/sources.list.d/
sleep 1
