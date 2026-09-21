#!/bin/bash
#Compiles and installs Rat Commander from source code. Rat commander is a TUI based file manager for linux distros.
if [ $exitStat -ne 0 ]; then
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
#These variables need to be set directly after a process ends to capture the $? value and output a message, cmdFail runs function.
#exitStat=$?
#errMsg="ERROR MESSAGE"
#successMsg="SUCCESS MESSAGE"
#cmdFail
#**Rat Commander is being moved to optional software. After more testing the file manager
#needs work before becoming a core componet. It is showing progress though.**
echo "Installing Rat Commander File Manager"
sleep 0.5
echo
echo "Installing Rat Commander APT dependancies"
sleep 0.5
echo
aptDep=$(cat $swAptDir/rc.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDep -y
exitStat=$?
errMsg="Rat Commander APT dependancies failed to install"
successMsg="Rat Commander APT dependancies installed successfully"
cmdFail
echo "Downloading Rat Commander"
sleep 0.5
gitURL=$(cat $installDir/git-commits.csv | grep -i rat-commander | cut -d ',' -f 2)
gitTag=$(cat $installDir/git-commits.csv | grep -i rat-commander | cut -d ',' -f 3)
echo "Pulling latest stable commit $gitTag"
if [ -d "$tmpDir/rat-commander" ]; then
    echo "Rat Commander directory already exists."
    sleep 0.5
    echo "Skipping download"
else
    echo "Grabbing Rat Commander from Github"
    sleep 0.5
    git clone $gitURL $tmpDir/rat-commander
    exitStat=$?
    errMsg="Rat Commander download failed"
    successMsg="Rat Commander downloaded successfully"
    cmdFail
    echo "Checking out latest stable commit"
    sleep 0.5
    git checkout $gitTag
    exitStat=$?
    errMsg="Rat Commander tag checkout failed"
    successMsg="Rat Commander tag checkout completed successfully"
    cmdFail
fi
echo "Building Rat Commander from source"
sleep 0.5
cd $tmpDir/rat-commander
echo "Building Rat Commander release version"
sleep 0.5
cargo build --release
exitStat=$?
errMsg="Rat Commander build failed"
successMsg="Rat Commander build completed successfully"
cmdFail
echo "Installing Rat Commander"
sleep 0.5
sudo cp -fv $tmpDir/rat-commander/target/release/rc /usr/bin/rc
exitStat=$?
errMsg="Rat Commander install failed"
successMsg="Rat Commander installed successfully"
cmdFail
sleep 1
echo
echo "-----------------------------------------------------------" 
echo "Rat Commander has been installed and enabled successfully."
echo "-----------------------------------------------------------"
sleep 1