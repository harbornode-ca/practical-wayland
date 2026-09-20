#!/bin/bash
#260901abbc.sh - Copies files from the cloned repository to their final destination folders.

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

#START FILE COPY
for f in $scriptDir $cfgDir $dataDir $toolsDir; do
    srcFldr=$(echo $f | cut -d '/' -f 4)
    style=info
    prt_info
    gum style "Copying files to folder $f"
    sleep 0.25
    cp -Rvf $tmpDir/practical-wayland/$srcFldr/* $f
    exitStat=$?
    errMsg="Copying files to folder $f failed"
    successMsg="Copying files to folder $f completed successfully"
    cmdFail
done
#END FILE COPY

#END OF SCRIPT
