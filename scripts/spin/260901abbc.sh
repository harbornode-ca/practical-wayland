#!/bin/bash
#260901abbc.sh - Copies files from the cloned repository to their final destination folders.

for f in $scriptDir $cfgDir $dataDir $toolsDir; do
    srcFldr=$(echo $f | cut -d '/' -f 4)
    cp -Rvf $tmpDir/practical-wayland/$srcFldr/* $f
done
