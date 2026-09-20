#!/bin/bash
# 2609ab672b - downloads debian id and name files to kevrevrun/data/extra

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

style=info
prt_info
gum style "Starting setup initialization"
sleep 1
echo
style=info
prt_info
gum style "Creating some needed folders"
sleep 0.5
if [ ! -d /opt/kevrevrun/data/extra ]; then
    style=msg
    prt_info
    gum style "Creating /opt/kevrevrun/data/extra folder."
    mkdir -pv /opt/kevrevrun/data/extra
    exitStat=$?
    errMsg="Failed to create /opt/kevrevrun/data/extra folder."
    successMsg="/opt/kevrevrun/data/extra folder created successfully"
    cmdFail
fi
if [ ! -d /opt/kevrevrun/scripts/modules ]; then
    style=msg
    prt_info
    gum style "Creating /opt/kevrevrun/scripts/modules folder."
    mkdir -pv /opt/kevrevrun/scripts/modules
    exitStat=$?
    errMsg="Failed to create /opt/kevrevrun/scripts/modules folder."
    successMsg="/opt/kevrevrun/scripts/modules folder created successfully"
    cmdFail
fi    
style=info
prt_info
gum style "Retreiving target release information"
echo
sleep 0.5
gum style "Downloading Debian release id file"
sleep 0.5
wget -nv -O /opt/kevrevrun/data/extra/debian.id https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/data/extra/debian.id
exitStat=$?
errMsg="Debian release id download failed."
successMsg="Debian release id downloaded successfully"
cmdFail
style=info
prt_info    
gum style "Downloading Debian release name file"
sleep 0.5
wget -nv -O /opt/kevrevrun/data/extra/debian.name https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/data/extra/debian.name
exitStat=$?
errMsg="Debian release name download failed."
successMsg="Debian release name downloaded successfully"
cmdFail
echo
style=info
prt_info    
gum style "Target release information retrieved."