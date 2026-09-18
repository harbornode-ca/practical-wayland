#!/bin/bash
#Sets up install process. Confirms directory structure and creates necessary files/variables. Downloads the repository and places all files in there relative folders.
#Right now the script saves the variables to /opt/kevrevrun/status/ for each script. Once the whole install process is complete exporting variables will be used where possible to avoid
#repetative loading of variables for every script.
echo
echo "Confirming directory structure"
sleep 1
for folder in "cfg" "status" "scripts" "tmp" "logs"; do
    if [ ! -d "/opt/kevrevrun/$folder" ]; then
        echo
        echo "Folder $folder not found"
        sleep 0.5
        echo "Creating $folder"
        mkdir -v /opt/kevrevrun/$folder
        sleep 0.5
    else
        echo
        echo "Folder $folder confirmed"
        sleep 0.25
    fi
done
echo
echo "Checking file structure"
sleep 1
for file in "/opt/kevrevrun/id.usr" "/opt/kevrevrun/name.usr" "/opt/kevrevrun/status/setup.stage" "/opt/kevrevrun/status/loop.status" "/opt/kevrevrun/setup.dir"; do
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
        sleep 1
    fi
done
# Creates a file that contains all folder used in the installation
echo
echo "Creating Setup Variables...Folders"
sleep 1
cat << 'EOF' > /opt/kevrevrun/status/folders.list
mainDir,/opt/kevrevrun
statusDir,/opt/kevrevrun/status
scriptDir,/opt/kevrevrun/scripts
cfgDir,/opt/kevrevrun/cfg
tmpDir,/opt/kevrevrun/tmp
installDir,/opt/kevrevrun/cfg/installInfo
swAptDir,/opt/kevrevrun/cfg/softwareApt
themeDir,/opt/kevrevrun/cfg/systemTheme
EOF
echo
echo "Setup variables have been saved to folders.list"
sleep 1
# Sets the folder variables for each folder in folders.list
echo
echo "Setting up Folder Variables"
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
sleep 1
# Creates file that contains all files that hold a status across scripts and reboots.
echo
echo "Creating Setup Variables...Files"
sleep 1
cat << 'EOF' > /opt/kevrevrun/status/files.list
stgUsr,/opt/kevrevrun/id.usr
stgUsrN,/opt/kevrevrun/name.usr
setupDirFile,/opt/kevrevrun/setup.dir
stageFile,/opt/kevrevrun/status/setup.stage
mainLog,/opt/kevrevrun/logs/main.log
selDE,/opt/kevrevrun/status/selDE.status
debNameFile,/opt/kevrevrun/installerInfo/debian.name
debIdFile,/opt/kevrevrun/installerInfo/debian.id
EOF
echo
echo "Setup variables saved to files.list"
sleep 1
# Sets variables for the status files
echo
echo "Setting up File Variables"
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
sleep 1
# Creates a file that allows the saved variables to be called into the current script
echo
echo "Creating Setup Variables...Values"
sleep 1
cat << 'EOF' > /opt/kevrevrun/status/values.list
setupStage,/opt/kevrevrun/status/setup.stage
usrId,/opt/kevrevrun/id.usr
usrName,/opt/kevrevrun/name.usr
setupDir,/opt/kevrevrun/setup.dir
selDEValue,/opt/kevrevrun/status/selDE.status
debVerID,/opt/kevrevrun/installerInfo/debian.id
debVerName,/opt/kevrevrun/installerInfo/debian.name
EOF
echo
echo "Setup variables have been saved to values.list"
sleep 1
# Reads the values from the files in values.list
echo
echo "Confirming Setup Variables"
while IFS=',' read -r varName fileName ; do
    if [ -f $fileName ]; then
        echo
        echo "File $fileName confirmed"
    else
        echo
        echo "The file - $fileName - was not found"
        sleep 1
        echo "Creating missing file"
        sleep 0.5
        echo "0" > $fileName
        echo "Missing file $fileName created"
        sleep 0.5
fi
done < "/opt/kevrevrun/status/files.list"
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
destFldr="$scriptDir $cfgDir"
for f in $destFldr; do
    echo "Empting folder $f"
    sleep 1
    rm -rvf $f/*
    
done
echo
sleep 1
for f in $destFldr; do
    srcFldr=$(echo $f | cut -d '/' -f 4)
    echo "Copying files to folder $f"
    sleep 0.5
    cp -Rv $tmpDir/practical-wayland/$srcFldr/* $f
    sleep 0.5
done
echo
echo "Cleaning up temporary files"
sleep 1.5
echo
echo "Removing temporary extraction folder"
sleep 1.5
rm -rvf "$tmpDir/practical-wayland"
echo
echo "--------------------------------------------------"
echo "Initial setup complete."
echo "--------------------------------------------------"
sleep 1