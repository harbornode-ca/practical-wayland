#!/bin/bash
#26093ecf51.sh - Download Niri Source Code

git clone https://github.com/niri-wm/niri.git $tmpDir/niri
cd $tmpDir/niri
git checkout 1f03391ea644c2a43597de7f637269e26d1e1b49
