#!/bin/bash
# 2609783e82 - Sets up install process. Confirms directory structure and creates necessary files/variables.

#START CMD FAIL FUNCTION
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
# These variables need to be set directly after a process ends to capture the $? value 
# and output a message, cmdFail runs function.
# exitStat=$?
# errMsg="ERROR MESSAGE"
# successMsg="SUCCESS MESSAGE"
# cmdFail
}
#END CMD FAIL FUNCTION


#START GUM VARIABLES
#GUM CONFIRM VARIABLES
export GUM_CONFIRM_PROMPT_FOREGROUND=7
export GUM_CONFIRM_SELECTED_FOREGROUND=0
export GUM_CONFIRM_SELECTED_BACKGROUND=2
export GUM_CONFIRM_UNSELECTED_FOREGROUND=0
export GUM_CONFIRM_UNSELECTED_BACKGROUND=3
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

#START GUM SPIN VARIABLES
export GUM_SPIN_TITLE="Processing..."
export GUM_SPIN_SPINNER_FOREGROUND=7
export GUM_SPIN_TITLE_FOREGROUND=3 
export GUM_SPIN_SPINNER="dot"
export GUM_SPIN_PADDING="2 0"
#END GUM SPIN VARIABLES

#START GUM STYLE FUNCTION
prt_info (){
case $style in
    info) export FOREGROUND=7; export BOLD=true;;
    msg) export FOREGROUND=3;;
    lose) export FOREGROUND=1; export BOLD=true;;
    win) export FOREGROUND=2; export BOLD=true;;
    *) export FOREGROUND=7; export BOLD=true;;
esac
}
#END GUM STYLE FUNCTION
#END GUM VARIABLES

#START DIRECTORY CHECK
style=info
prt_info
gum style "Confirming directory structure"
echo
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
#END DIRECTORY CHECK

#START FILE CHECK
style=info
prt_info
gum style "Checking file structure"
echo
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
            sleep 0.25
        elif [ $file = "/opt/kevrevrun/name.usr" ]; then
            style=win
            prt_info
            gum style "Repaired $file"
            sleep 0.25
        elif [ $file = "/opt/kevrevrun/status/setup.stage" ]; then
            style=win
            prt_info
            gum style "Repaired $file"
            sleep 0.25
        elif [ $file = "/opt/kevrevrun/setup.dir" ]; then
            style=win
            prt_info
            gum style "Repaired $file"
            sleep 0.25
        elif [ $file = "/opt/kevrevrun/status/setup.stage" ]; then
            echo "0" > $file
            style=win
            prt_info
            gum style "Repaired $file"
            sleep 0.25
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
        sleep 0.25
    fi
done
style=info
prt_info
gum style "Completed file checking"
echo
sleep 0.5
#END FILE CHECK

#START LIST CREATION SECTION
#FOLDER LIST CREATION START
style=info
prt_info
gum style "Creating list files for setup variables"
sleep 1
echo
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
style=info
prt_info
gum style "Folder variables have been saved to /opt/kevrevrun/status/folders.list"
echo
sleep 0.5
#FOLDER LIST CREATION END

#FILE LIST CREATION
style=info
prt_info
gum style "Creating a list file of file variables..."
sleep 1
cat << 'EOF' > /opt/kevrevrun/status/files.list
usrIdFile,/opt/kevrevrun/id.usr
usrNameFile,/opt/kevrevrun/name.usr
setupDirFile,/opt/kevrevrun/setup.dir
stageFile,/opt/kevrevrun/status/setup.stage
deSetFile,/opt/kevrevrun/status/deSet.status
debNameFile,/opt/kevrevrun/data/extra/debian.name
debIdFile,/opt/kevrevrun/data/extra/debian.id
EOF
style=info
prt_info
gum style "File variables have been saved to /opt/kevrevrun/status/files.list"
echo
sleep 0.5
#FILE LIST CREATION END

#VALUE LIST CREATION START
style=info
prt_info
gum style "Creating a list file of setup variables and values..."
sleep 1
cat << 'EOF' > /opt/kevrevrun/status/values.list
setupStage,/opt/kevrevrun/status/setup.stage
usrId,/opt/kevrevrun/id.usr
usrName,/opt/kevrevrun/name.usr
setupDir,/opt/kevrevrun/setup.dir
deSet,/opt/kevrevrun/status/deSet.status
debVerID,/opt/kevrevrun/data/extra/debian.id
debVerName,/opt/kevrevrun/data/extra/debian.name
EOF
style=win
prt_info
gum style "Variable values have been saved to /opt/kevrevrun/status/values.list"
echo
sleep 1
#VALUE LIST CREATION END
#LIST CREATION SECTION END

#INITIALIZATION PROCESS COMPLETE
style=win
prt_info
gum style "Initilialization completed successfully"
sleep 1
