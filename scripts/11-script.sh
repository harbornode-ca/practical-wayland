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
    sleep 0.5
fi
}
#These variables need to be set directly after a process ends to capture the $? value and output a message, cmdFail runs function.
#exitStat=$?
#errMsg="ERROR MESSAGE"
#successMsg="SUCCESS MESSAGE"
#cmdFail
echo "Installing Rat Commander File Manager"
sleep 0.5
echo
echo "Installing Rat Commander APT dependancies"
sleep 0.5
echo
aptDep=$(cat $cfgDir/deps/rc.apt)
sudo DEBIAN_FRONTEND=noninteractive apt install $aptDep -y
exitStat=$?
errMsg="Rat Commander APT dependancies failed to install"
successMsg="Rat Commander APT dependancies installed successfully"
cmdFail
echo "Downloading Rat Commander"
sleep 0.5
gitURL=$(cat $cfgDir/install/git-commits.csv | grep -i rat-commander | cut -d ',' -f 2)
gitTag=$(cat $cfgDir/install/git-commits.csv | grep -i rat-commander | cut -d ',' -f 3)
if [ -d "$tmpDir/rat-commander" ]; then
    echo "Rat Commander directory already exists. Skipping download"
    sleep 0.5
else
    git -C "$tmpDir" clone $gitURL $gitTag
    exitStat=$?
    errMsg="Rat Commander download failed"
    successMsg="Rat Commander downloaded successfully"
    cmdFail
fi
echo "Moving Rat Commander source files into a new directory"
sleep 0.5
mv -v "$tmpDir/$gitTag" "$tmpDir/rat-commander"
exitStat=$?
errMsg="Rat Commander source files move failed"
successMsg="Rat Commander source files moved successfully"
cmdFail
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
sudo cp -v $tmpDir/rat-commander/target/release/rc /usr/bin/rc
exitStat=$?
errMsg="Rat Commander install failed"
successMsg="Rat Commander installed successfully"
cmdFail
echo "Updating the stage file"
sleep 0.5
echo "12" > $stageFile
sleep 0.5
echo "Stage file updated"
sleep 0.5
echo
echo "-----------------------------------------------------------" 
echo "Rat Commander has been installed and enabled successfully."
echo "-----------------------------------------------------------"
sleep 0.5
read -p "Do you want to continue to the next stage? \`[y/n]\`: " cont
if [[ $cont =~ ^[Yy]$ ]]; then
    echo "Continuing to next stage"
    sleep 1
    exit 0
else
    echo "Exiting script. Please run the main setup.sh script in your"
    echo "home directory to continue."
    sleep 1
    exit 1
fi