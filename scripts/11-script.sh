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
#These variables need to be set directly after a process ends to capture the $? value and output a message, cmdFail runs function.
#exitStat=$?
#errMsg="ERROR MESSAGE"
#successMsg="SUCCESS MESSAGE"
#cmdFail
echo "Setting up Folder Variables"
echo
sleep 0.5
fldrList=$(cat /opt/kevrevrun/status/folders.list)
for f in $fldrList; do
    varName=$(echo $f | cut -d ',' -f 1)
    varValue=$(echo $f | cut -d ',' -f 2)
    export $varName="$varValue" 2>&1
    echo "Folder Variable $varName is set to $varValue"
    sleep 0.25
done
echo
echo "Setting up File Variables"
sleep 0.5
echo
varFiles=$(cat /opt/kevrevrun/status/files.list)
for v in $varFiles; do
    varName=$(echo $v | cut -d ',' -f 1)
    varValue=$(echo $v | cut -d ',' -f 2)
    export $varName="$varValue"
    echo "File Variable $varName is set to $varValue"
    sleep 0.25
done
echo
echo "Reading and Exporting All Setup Variables"
sleep 0.5
echo
valueList=$(cat /opt/kevrevrun/status/values.list)
for v in $valueList; do
    varName=$(echo $v | cut -d ',' -f 1)
    fileName=$(echo $v | cut -d ',' -f 2)
    varValue=$(cat $fileName)
    export $varName="$varValue"
    echo "Variable $varName has been imported with value $varValue"
    sleep 0.25
done
echo "Installing Rat Commander File Manager"
echo
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
cd $tmpDir/rat-commander
echo "Building Rat Commander release version"
cargo build --release
exitStat=$?
errMsg="Rat Commander build failed"
successMsg="Rat Commander build completed successfully"
cmdFail
echo "Installing Rat Commander"
sudo cp -v target/release/rat-commander /usr/bin/
exitStat=$?
errMsg="Rat Commander install failed"
successMsg="Rat Commander installed successfully"
cmdFail
#echo "Updating the stage file"
#echo "100" > $stageFile
#sleep 0.5
#echo "Stage file updated"
#sleep 0.5
echo 
echo "Rat Commander has been installed and enabled successfully."
echo
echo "--------------------------------------------------"
read -p "Do you want to continue to the next stage? [y/n]" cont
if [[ $cont =~ ^[Yy]$ ]]; then
    echo "Continuing to next stage"
    sleep 1
    exit 0
else
    echo "Exiting script. Please run the main setup.sh script in your home directory to continue."
    sleep 1
    exit 1
fi