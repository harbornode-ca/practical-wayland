#!/bin/bash
cmdFail () {
if [ $? -ne 0 ]; then
echo "$errMsg"
sleep 1
echo
echo "This script will now exit"
read -p "Press [ENTER] key to exit"
clear
exit 1
else
    echo "$successMsg"
fi
}
echo "Installing Xwayland Satellite"
sleep 1
echo
echo "Installing APT dependencies for Xwayland Satellite"
sleep 1
aptDeps=$(cat $swAptDir/xwayland-satellite.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDeps --no-install-recommends -y
exitStat=$?
errMsg="Xwayland Satellite dependencies failed to install"
successMsg="Xwayland Satellite dependencies installed successfully"
cmdFail
echo
echo "Cloning Xwayland Satellite repository"
sleep 1
if [ -d "$tmpDir/xwayland-satellite" ]; then
    echo "xwayland-satellite repository already cloned. Skipping"
    sleep 1else
    gitURL=$(cat $installDir/git-commits.csv | grep -i xwayland-satellite | cut -d ',' -f 2)
    gitTag=$(cat $installDir/git-commits.csv | grep -i xwayland-satellite | cut -d ',' -f 3)
    git clone $gitURL $tmpDir/xwayland-satellite
    exitStat=$?
    errMsg="xwayland-satellite repository failed to clone"
    successMsg="xwayland-satellite repository cloned successfully"
    cmdFail
    cd $tmpDir/xwayland-satellite
    git checkout $gitTag
    exitStat=$?
    errMsg="xwayland-satellite repository failed to checkout tag"
    successMsg="xwayland-satellite repository checkout tag successfully"
    cmdFail
fi
echo
echo "Creating build directory for Xwayland Satellite"
sleep 1
echo "Compiling Xwayland Satellite"
cd $tmpDir/xwayland-satellite
cargo build --release
exitStat=$?
errMsg="Failed to compile"
successMsg="Build compiled successfully"
cmdFail
echo
echo "Installing Xwayland Satellite"
sleep 1
sudo cp -fv $tmpDir/xwayland-satellite/target/release/xwayland-satellite /usr/bin/
exitStat=$?
errMsg="Failed to install xwayland-satellite"
successMsg="xwayland-satellite installed successfully"
cmdFail