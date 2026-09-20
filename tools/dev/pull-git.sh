#!/bin/bash
#pull-git.sh - Downloads latest Practical Wayland to temp directory and copies it to the running Practical Wayland directory.

#START PULL-GIT
git -C "$tmpDir" clone https://github.com/harbornode-ca/practical-wayland.git
for f in $scriptDir $cfgDir $dataDir $toolsDir; do
    srcFldr=$(echo $f | cut -d '/' -f 4)
    cp -Rvf $tmpDir/practical-wayland/$srcFldr/* $f
done
#END PULL-GIT