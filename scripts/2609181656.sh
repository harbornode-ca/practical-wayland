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
echo "Setting environment variables for C compiler"
export CC=clang
exitStat=$?
errMsg="C compiler failed to set to clang"
successMsg="C compiler set successfully to clang"
cmdFail
export CXX=clang++
exitStat=$?
errMsg="C++ compiler failed to set to clang++"
successMsg="C++ compiler set successfully to clang++"
cmdFail
echo
echo "Installing APT dependencies for Xwayland Satellite"
sleep 1
aptDeps=$(cat $swAptDir/xwayland-satellite.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDeps -y
exitStat=$?
errMsg="Xwayland Satellite dependencies failed to install"
successMsg="Xwayland Satellite dependencies installed successfully"
cmdFail
echo "Building dump-xsettings"
scons dump-xsettings
exitStat=$?
errMsg="Failed to build dump-xsettings"
successMsg="dump-xsettings built successfully"
cmdFail
echo "Building xsettingsd"
scons xsettingsd
exitStat=$?
errMsg="Failed to build xsettingsd"
successMsg="xsettingsd built successfully"
cmdFail
echo
echo "Cloning Xwayland Satellite repository"
sleep 1
if [ -d "$tmpDir/xwayland-satellite" ]; then
    echo "xwayland-satellite repository already cloned. Skipping"
    sleep 0.5
else
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
mkdir build
exitStat=$?
errMsg="Failed to create build directory"
successMsg="Build directory created successfully"
cmdFail
echo
echo "Configuring Xwayland Satellite build"
sleep 1
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr
exitStat=$?
errMsg="Failed to configure build"
successMsg="Build configured successfully"
cmdFail
echo
echo "Compiling Xwayland Satellite"
sleep 1
make
exitStat=$?
errMsg="Failed to compile"
successMsg="Build compiled successfully"
cmdFail
echo
echo "Installing Xwayland Satellite"
sleep 1
sudo make install
exitStat=$?
errMsg="Failed to install"
successMsg="Installation successful"
cmdFail
