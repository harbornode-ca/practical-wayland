#!/bin/bash
#Sets up install process. Confirms directory structure and creates necessary files/variables. Downloads the repository and places all files in there relative folders.
#Right now the script saves the variables to /opt/kevrevrun/status/ for each script. Once the whole install process is complete exporting variables will be used where possible to avoid
#repetative loading of variables for every script.
echo
echo "Confirming directory structure"
sleep 0.5
for folder in "cfg" "status" "scripts" "tmp" "logs"; do
    if [ ! -d "/opt/kevrevrun/$folder" ]; then
        echo
        echo "Folder $folder not found"
        sleep 0.25
        echo "Creating $folder"
        mkdir -v /opt/kevrevrun/$folder
        sleep 0.5
    else
        echo
        echo "Folder $folder confirmed"
        sleep 0.25
    fi
done
sleep 0.5
echo
echo "Checking file structure"
sleep 0.5
for file in "/opt/kevrevrun/id.usr" "/opt/kevrevrun/name.usr" "/opt/kevrevrun/status/setup.stage" "/opt/kevrevrun/status/loop.status" "/opt/kevrevrun/install.dir"; do
    if [ ! -f $file ]; then
        echo
        echo "Error: $file not found"
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
        elif [ $file = "/opt/kevrevrun/install.dir" ]; then
            echo "$HOME" > $file
            echo "Repaired $file"
            sleep 0.5
        fi
    else
        echo
        echo "File $file confirmed"
        sleep 0.25
    fi
done
sleep 0.5
# Creates a file that contains all folder used in the installation
echo
echo "Creating Setup Variables...Folders"
sleep 0.5
cat << 'EOF' > /opt/kevrevrun/status/folders.list
mainDir,/opt/kevrevrun
statusDir,/opt/kevrevrun/status
scriptDir,/opt/kevrevrun/scripts
cfgDir,/opt/kevrevrun/cfg
tmpDir,/opt/kevrevrun/tmp
logDir,/opt/kevrevrun/logs
EOF
echo
echo "Setup variables saved to folders.list"
sleep 0.5
# Sets the folder variables for each folder in folders.list
echo
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
# Creates file that contains all files that hold a status across scripts and reboots.
echo
echo "Creating Setup Variables...Files"
sleep 0.5
cat << 'EOF' > /opt/kevrevrun/status/files.list
stgUsr,/opt/kevrevrun/id.usr
stgUsrN,/opt/kevrevrun/name.usr
installerDir,/opt/kevrevrun/setup.dir
stageFile,/opt/kevrevrun/status/setup.stage
mainLog,/opt/kevrevrun/logs/main.log
selDE,/opt/kevrevrun/status/selDE.status
EOF
echo
echo "Setup variables saved to files.list"
sleep 0.5
# Sets variables for the status files
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
sleep 0.5
# Creates a file that allows the saved variables to be called into the current script
echo
echo "Creating Setup Variables...Values"
sleep 0.5
cat << 'EOF' > /opt/kevrevrun/status/values.list
setupStage,/opt/kevrevrun/status/setup.stage
usrId,/opt/kevrevrun/id.usr
usrName,/opt/kevrevrun/name.usr
setupDir,/opt/kevrevrun/setup.dir
selDEValue,/opt/kevrevrun/status/selDE.status
EOF
echo
echo "Setup variables saved to values.list"
sleep 0.5
# Reads the values from the files in values.list
echo Confirming Setup Variables
echo
while IFS=',' read -r varName fileName ; do
    if [ -f $fileName ]; then
        echo
        echo "File $fileName confirmed"
    else
        echo
        echo "Error: $fileName not found"
        sleep 0.25
        echo "Creating missing file"
        sleep 0.5
        echo "0" > $fileName
        echo "Missing file $fileName created"
        sleep 0.5
fi
done < "/opt/kevrevrun/status/files.list"
echo
echo "Reading and Exporting All Setup Variables"
sleep 0.5
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
echo "Downloading Practical Wayland from github"
sleep 1
echo
git -C "$tmpDir" clone https://github.com/harbornode-ca/practical-wayland.git
if [ -d "$tmpDir/practical-wayland" ]; then
    echo
    echo "Practical Wayland directory confirmed"
    sleep 0.5
fi
echo
echo "Moving files from the installation directory to Main directory"
sleep 0.5
echo
#Move files from the installation directory to Main directory
destFldr="$scriptDir $cfgDir"
for f in $destFldr; do
    echo "Empting folder $f"
    rm -rvf $f/*
    sleep 0.5
done
echo
for f in $destFldr; do
    srcFldr=$(echo $f | cut -d '/' -f 4)
    echo "Copying files to folder $f"
    cp -Rv $tmpDir/practical-wayland/$srcFldr/* $f
    sleep 0.5
done
echo
echo "Cleaning up temporary files"
sleep 0.5
echo
echo "Removing temporary extraction folder"
rm -rvf "$tmpDir/practical-wayland"
sleep 0.5
echo
echo "Temporary files removed"
sleep 0.5
echo 
echo "Updating the stage file"
sleep 0.5
echo "2" > $stageFile
sleep 0.5
echo "Stage file updated"
sleep 0.5
echo
echo "--------------------------------------------------"
echo "Initial setup complete."
echo "Do you want to continue to the next stage?"
echo "--------------------------------------------------"
read -p "[y/n]" cont
if [[ $cont =~ ^[Yy]$ ]]; then
    echo "Continuing to next stage"
    sleep 1
    exit 0
else
    echo "Aborting installation"
    sleep 1
    exit 1
fi