#!/bin/bash
#2610cc264c.sh - Download Lemurs Source Code

git clone https://github.com/coastalwhite/lemurs.git $tmpDir/lemurs
cd $tmpDir/lemurs
git checkout 7151336a100e7a6266ec329d6cc356dec5c087ad
