#!/bin/bash
#Sets up install process. Confirms directory structure and creates necessary files/variables. 
#Downloads the repository and places all files in there relative folders.
cmdFail () {
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
    sleep 0.5
fi
}
#These variables need to be set directly after a process ends to capture the $? value and output a message, cmdFail runs function.
#exitStat=$?
#errMsg="ERROR MESSAGE"
#successMsg="SUCCESS MESSAGE"
#cmdFail
echo "Confirming directory structure"
sleep 1
for folder in "cfg" "status" "scripts" "tmp" "data" "tools"; do
    if [ ! -d "/opt/kevrevrun/$folder" ]; then
        echo "Folder $folder not found"
        sleep 0.25
        echo "Creating $folder"
        mkdir -v /opt/kevrevrun/$folder
        exitStat=$?
        errMsg="Creating directory $folder failed"
        successMsg="Creating directory $folder completed"
        cmdFail
    else
        echo "Folder $folder confirmed"
        sleep 0.25
    fi
done
echo
echo "Checking file structure"
sleep 1
for file in "/opt/kevrevrun/id.usr" "/opt/kevrevrun/name.usr" "/opt/kevrevrun/status/setup.stage" "/opt/kevrevrun/setup.dir"; do
    if [ ! -f $file ]; then
        echo
        echo "The file - $file - was not found"
        if [ $file = "/opt/kevrevrun/id.usr" ]; then
            echo $UID > $file
            echo "Repaired $file"
            sleep 0.5
        elif [ $file = "/opt/kevrevrun/name.usr" ]; then
            echo $USER > $file
            echo "Repaired $file"
            sleep 0.5
        elif [ $file = "/opt/kevrevrun/status/setup.stage" ]; then
            echo "0" > $file
            echo "Repaired $file"
            sleep 0.5
        elif [ $file = "/opt/kevrevrun/setup.dir" ]; then
            echo "$HOME" > $file
            echo "Repaired $file"
            sleep 0.5
        fi
    else
        echo
        echo "File $file confirmed"
        sleep 0.5
    fi
done
sleep 1
# Creates a file that contains all folder used in the installation
echo
echo "Creating lists for setup variables"
echo
echo "Creating a list file of folder variables..."
sleep 1
cat << 'EOF' > /opt/kevrevrun/status/folders.list
mainDir,/opt/kevrevrun
statusDir,/opt/kevrevrun/status
menuDir,/opt/kevrevrun/scripts/menus
moduleDir,/opt/kevrevrun/scripts/modules
scriptDir,/opt/kevrevrun/scripts
cfgDir,/opt/kevrevrun/cfg
tmpDir,/opt/kevrevrun/tmp
dataDir,/opt/kevrevrun/data
toolsDir,/opt/kevrevrun/tools
logDir,/opt/kevrevrun/logs
EOF
echo "Folder variables have been saved to /opt/kevrevrun/status/folders.list"
sleep 1
# Sets the folder variables for each folder in folders.list
echo
echo "Exporting folder variables"
sleep 1
echo
fldrList=$(cat /opt/kevrevrun/status/folders.list)
for f in $fldrList; do
    varName=$(echo $f | cut -d ',' -f 1)
    varValue=$(echo $f | cut -d ',' -f 2)
    export $varName="$varValue" 2>&1
    echo "Folder Variable $varName is set to $varValue"
    sleep 0.5
done
echo "Completed loading folder variables"
sleep 1
echo
echo "Creating a list file of file variables..."
sleep 1
cat << 'EOF' > /opt/kevrevrun/status/files.list
usrIdFile,/opt/kevrevrun/id.usr
usrNameFile,/opt/kevrevrun/name.usr
setupDirFile,/opt/kevrevrun/setup.dir
stageFile,/opt/kevrevrun/status/setup.stage
selDEFile,/opt/kevrevrun/status/selDE.status
debNameFile,/opt/kevrevrun/data/extra/debian.name
debIdFile,/opt/kevrevrun/data/extra/debian.id
EOF
echo
echo "File variables have been saved to /opt/kevrevrun/status/files.list"
sleep 1
# Sets variables for the status files
echo
echo "Exporting file variables"
sleep 1
echo
varFiles=$(cat /opt/kevrevrun/status/files.list)
for v in $varFiles; do
    varName=$(echo $v | cut -d ',' -f 1)
    varValue=$(echo $v | cut -d ',' -f 2)
    export $varName="$varValue"
    echo "File Variable $varName is set to $varValue"
    sleep 0.5
done
# Creates a list file of setup variables and their values
echo "Creating a list file of setup variables and values..."
sleep 1
cat << 'EOF' > /opt/kevrevrun/status/values.list
setupStage,/opt/kevrevrun/status/setup.stage
usrId,/opt/kevrevrun/id.usr
usrName,/opt/kevrevrun/name.usr
setupDir,/opt/kevrevrun/setup.dir
selDEValue,/opt/kevrevrun/status/selDE.status
debVerID,/opt/kevrevrun/data/extra/debian.id
debVerName,/opt/kevrevrun/data/extra/debian.name
EOF
sleep 1
echo
echo "Reading and Exporting All Setup Variables"
sleep 1
valueList=$(cat /opt/kevrevrun/status/values.list)
for v in $valueList; do
    varName=$(echo $v | cut -d ',' -f 1)
    fileName=$(echo $v | cut -d ',' -f 2)
    varValue=$(cat $fileName)
    export $varName="$varValue"
    echo "Variable $varName has been imported with value $varValue"
    sleep 0.25
done
sleep 1
echo 
echo "Downloading Practical Wayland from github"
sleep 1
echo
git -C "$tmpDir" clone https://github.com/harbornode-ca/practical-wayland.git
if [ -d "$tmpDir/practical-wayland" ]; then
    echo
    echo "Practical Wayland sucessfully cloned"
    sleep 1
fi
echo
echo "Moving files from the installation directory to Main directory"
sleep 1
echo
#Move files from the installation directory to Main directory
for f in "$scriptDir" "$cfgDir" "$dataDir" "$toolsDir"; do
    srcFldr=$(echo $f | cut -d '/' -f 4)
    echo "Copying files to folder $f"
    sleep 0.5
    cp -Rvf $tmpDir/practical-wayland/$srcFldr/* $f
    exitStat=$?
    errMsg="Copying files to folder $f failed"
    successMsg="Copying files to folder $f completed successfully"
    cmdFail
done
echo
echo "Cleaning up temporary files"
sleep 1.5
echo
echo "Removing temporary extraction folder"
sleep 1.5
rm -rvf "$tmpDir/practical-wayland"
exitStat=$?
errMsg="Removing temporary extraction folder"
successMsg="Successfully removed temporary extraction folder"
cmdFail
echo
echo "Initial setup is now complete"
echo 
sleep 1
exit 0