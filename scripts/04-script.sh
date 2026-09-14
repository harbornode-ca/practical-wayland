#!/bin/bash
#Adds i386 architecture support and updates package cache. While not required NVIDIA Drivers still have i386 support.
#This is required for running steam. Adding does not affect performance or system stability.
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
    echo "$sucessMsg"
fi
}
#These variables need to be set directly after a process ends to capture the $? value and output a message, cmdFail runs function.
#exitStat=$?
#errMsg="ERROR MESSAGE"
#sucessMsg="SUCCESS MESSAGE"
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
echo
echo "Adding i386 architecture"
sleep 0.5
sudo dpkg --add-architecture i386
exitStat=$?
errMsg="Failed to add i386 architecture"
sucessMsg="i386 architecture added successfully"
cmdFail
echo
echo "Updating APT package cache"
sleep 0.5
sudo DEBIAN_FRONTEND=noninteractive apt update
exitStat=$?
errMsg="Failed to update APT package cache"
sucessMsg="APT package cache updated successfully"
cmdFail
echo "Updating the stage file"
sleep 0.5
echo "4" > $stageFile
sleep 0.5
echo "Stage file updated"
sleep 0.5
echo 
echo "i386 architchture support has been sucessfully added"
echo "Your system has been prepared for the next stage of installation."
sleep 1
echo
read -p "Press [Enter] key to continue..."
clear
exit 0