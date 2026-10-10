#!/bin/bash
#26103cf72e.sh - Download Ashell Source Code

git clone https://github.com/MalpenZibo/ashell.git $tmpDir/ashell
cd $tmpDir/ashell
git checkout 8623dfb18ebc1cc18c9d75a0d4103a2f9c831bed
