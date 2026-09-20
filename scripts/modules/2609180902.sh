#!/bin/bash
#Sets up install process. Confirms directory structure and creates necessary files/variables. 
#Downloads the repository and places all files in there relative folders.
#START GUM VARIABLES

#GUM CONFIRM VARIABLES
export GUM_CONFIRM_PROMPT_FOREGROUND=7
export GUM_CONFIRM_SELECTED_FOREGROUND=0
export GUM_CONFIRM_SELECTED_BACKGROUND=3
export GUM_CONFIRM_UNSELECTED_FOREGROUND=0
export GUM_CONFIRM_UNSELECTED_BACKGROUND=2
export GUM_CONFIRM_PADDING="2 0"
export GUM_CONFIRM_SHOW_HELP=false
#END GUM CONFIRM VARIABLES

#START GUM CHOOSE VARIABLES
export GUM_CHOOSE_PADDING="1 0"
export GUM_CHOOSE_HEIGHT=10
export GUM_CHOOSE_CURSOR=" > "
export GUM_CHOOSE_CURSOR_PREFIX="[-] "
export GUM_CHOOSE_SELECTED_PREFIX="[x] "
export GUM_CHOOSE_UNSELECTED_PREFIX="[ ] "
export GUM_CHOOSE_CURSOR_FOREGROUND=7
export GUM_CHOOSE_HEADER_FOREGROUND=3
export GUM_CHOOSE_ITEM_FOREGROUND=3
export GUM_CHOOSE_SELECTED_FOREGROUND=10
#END GUM CHOOSE VARIABLES

#END GUM VARIABLES

#MESSAGE TYPE SETTINGS
prt_info () {
case $style in
    info) export FOREGROUND=7; export BOLD=true;;
    msg) export FOREGROUND=3;;
    lose) export FOREGROUND=1; export BOLD=true;;
    win) export FOREGROUND=2; export BOLD=true;;
    *) export FOREGROUND=7; export BOLD=true;;
esac
}

#END MESSAGE TYPE SETTINGS
cmdFail () {
if [ $exitStat -ne 0 ]; then
    style=lose
    prt_info
    gum style "$errMsg"
    sleep 1
    echo
    style=msg
    prt_info
    gum style "This script will now exit"
    sleep 1
    clear
    exit 1
else
    style=win
    prt_info
    gum style "$successMsg"
    sleep 0.5
fi
}
#These variables need to be set directly after a process ends to capture the $? value and output a message, cmdFail runs function.
#exitStat=$?
#errMsg="ERROR MESSAGE"
#successMsg="SUCCESS MESSAGE"
#cmdFail
style=msg
prt_info
gum style "Confirming directory structure"
sleep 1
for folder in "cfg" "status" "scripts" "tmp" "data" "tools"; do
    if [ ! -d "/opt/kevrevrun/$folder" ]; then
        style=msg
        prt_info
        gum style "Folder $folder not found"
        sleep 0.25
        style=msg
        prt_info
        gum style "Creating $folder"
        mkdir -v /opt/kevrevrun/$folder
        exitStat=$?
        errMsg="Creating directory $folder failed"
        successMsg="Creating directory $folder completed"
        cmdFail
    else
        style=win
        prt_info
        gum style "Folder $folder confirmed"
        sleep 0.25
    fi
done
echo
    style=msg
    prt_info
    gum style "Checking file structure"
sleep 1
for file in "/opt/kevrevrun/id.usr" "/opt/kevrevrun/name.usr" "/opt/kevrevrun/status/setup.stage" "/opt/kevrevrun/setup.dir"; do
    if [ ! -f $file ]; then
        style=msg
        prt_info
        gum style "The file - $file - was not found"
        if [ $file = "/opt/kevrevrun/id.usr" ]; then
            echo $UID > $file
            style=win
            prt_info
            gum style "Repaired $file"
            sleep 0.5
        elif [ $file = "/opt/kevrevrun/name.usr" ]; then
            style=win
            prt_info
            gum style "Repaired $file"
            sleep 0.5
        elif [ $file = "/opt/kevrevrun/status/setup.stage" ]; then
            style=win
            prt_info
            gum style "Repaired $file"
            sleep 0.5
        elif [ $file = "/opt/kevrevrun/setup.dir" ]; then
            style=win
            prt_info
            gum style "Repaired $file"
            sleep 0.5
        elif [ $file = "/opt/kevrevrun/status/setup.stage" ]; then
            echo "0" > $file
            style=win
            prt_info
            gum style "Repaired $file"
            sleep 0.5
        elif [ $file = "/opt/kevrevrun/setup.dir" ]; then
            echo "$HOME" > $file
            style=win
            prt_info
            gum style "Repaired $file"
            sleep 0.5
        fi
    else
        style=win
        prt_info
        gum style "File $file confirmed"
        sleep 0.5
    fi
done
sleep 1
# Creates a file that contains all folder used in the installation
style=msg
prt_info
gum style "Creating lists for setup variables"
gum style "Creating a list file of folder variables..."
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
style=win
prt_info
gum style "Folder variables have been saved to /opt/kevrevrun/status/folders.list"
sleep 1
# Sets the folder variables for each folder in folders.list
style=msg
prt_info
gum style "Exporting folder variables"
sleep 1
fldrList=$(cat /opt/kevrevrun/status/folders.list)
for f in $fldrList; do
    varName=$(echo $f | cut -d ',' -f 1)
    varValue=$(echo $f | cut -d ',' -f 2)
    style=msg
    prt_info
    gum style "exporting variable $varName..."
    sleep 0.5
    export $varName="$varValue"
    style=win
    prt_info
    gum style "Folder Variable $varName is set to $varValue"
    sleep 0.5
done
style=win
prt_info
gum style "Completed loading folder variables"
sleep 1
style=msg
prt_info
gum style "Creating a list file of file variables..."
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
style=win
prt_info
gum style "File variables have been saved to /opt/kevrevrun/status/files.list"
sleep 1
# Sets variables for the status files
style=msg
prt_info
gum style "Exporting file variables"
sleep 1
varFiles=$(cat /opt/kevrevrun/status/files.list)
for v in $varFiles; do
    varName=$(echo $v | cut -d ',' -f 1)
    varValue=$(echo $v | cut -d ',' -f 2)
    style=msg
    prt_info
    gum style "Exporting variable $varName..."
    sleep 0.5
    export $varName="$varValue"
    style=win
    prt_info
    gum style "File Variable $varName is set to $varValue"
    sleep 0.5
done
# Creates a list file of setup variables and their values
style=msg
prt_info
gum style "Creating a list file of setup variables and values..."
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
style=win
prt_info
gum style "File variables have been saved to /opt/kevrevrun/status/files.list"
sleep 1
# Sets variables for the status files
style=msg
prt_info
gum style "Exporting file variables"
sleep 1
varFiles=$(cat /opt/kevrevrun/status/files.list)
for v in $varFiles; do
    varName=$(echo $v | cut -d ',' -f 1)
    fileName=$(echo $v | cut -d ',' -f 2)
    varValue=$(cat $fileName)
    style=msg
    prt_info
    gum style "Exporting variable $varName..."
    sleep 0.5
    export $varName="$varValue"
    style=win
    prt_info
    gum style "File Variable $varName is set to $varValue"
    sleep 0.5
done
sleep 1
style=msg
prt_info
gum style "Downloading Practical Wayland from github"
sleep 1
git -C "$tmpDir" clone https://github.com/harbornode-ca/practical-wayland.git
if [ -d "$tmpDir/practical-wayland" ]; then
    style=win
    prt_info
    gum style "Practical Wayland sucessfully cloned"
    sleep 1
fi
style=msg
prt_info
gum style "Moving files from the installation directory to Main directory"
sleep 1
#Move files from the installation directory to Main directory
style=msg
prt_info
gum style "Ensuring empty destination directories"
sleep 0.5
for f in "$scriptDir" "$cfgDir" "$dataDir" "$toolsDir"; do
    style=msg
    prt_info
    gum style "Ensuring folder $f is empty"
    rm -rvf "$f"/*
    exitStat=$?
    errMsg="Removing files from folder $f failed"
    successMsg="Removing files from folder $f completed successfully"
    cmdFail
    sleep 0.5
done
style=msg
prt_info
gum style "Copying files from the installation directory to Main directory"
sleep 0.5
for f in "$scriptDir" "$cfgDir" "$dataDir" "$toolsDir"; do
    srcFldr=$(echo $f | cut -d '/' -f 4)
    style=msg
    prt_info
    gum style "Copying files to folder $f"
    sleep 0.5
    cp -Rvf $tmpDir/practical-wayland/$srcFldr/* $f
    exitStat=$?
    errMsg="Copying files to folder $f failed"
    successMsg="Copying files to folder $f completed successfully"
    cmdFail
done
style=msg
prt_info
gum style "Cleaning up temporary files"
sleep 0.5
style=msg
prt_info
gum style "Removing temporary extraction folder"
sleep 0.5
rm -rvf "$tmpDir/practical-wayland"
exitStat=$?
errMsg="Removing temporary extraction folder"
successMsg="Successfully removed temporary extraction folder"
cmdFail
style=win
prt_info
gum style "Initial setup is now complete"
echo 
sleep 1
exit 0