#!/bin/bash
#Script Information

declare -a chkStatus
declare -a chkList

declare -i chkListTotal
declare -i count


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

#START GUM STYLE FUNCTION
prtInfo (){
case $style in
    info) export FOREGROUND=7;;
    msg) export FOREGROUND=11;;
    lose) export FOREGROUND=1;;
    win) export FOREGROUND=2;;
    *) export FOREGROUND=7;;
esac
}
#END GUM STYLE FUNCTION

#START STATUSBOX FUNCTION
#statusBox creates a box with a checklist for installation steps
statusBox () {
    chkStatus=()
    while IFS=',' read -r step status action inProgress; do
        if [[ "$status" -eq 0 && "$inProgress" -eq 0 ]]; then
            chkStatus+=([ ] $action)
        elif [[ "$status" -eq 1 && "$inProgress" -eq 0 ]]; then
            chkStatus+=([x] $action)
        elif [[ "$status" -eq 0 && "$inProgress" -eq 1 ]]; then
            chkStatus+=([>] $action)
        else
            chkStatus+=([E] $action)
        fi
    done < "$libDir/noctalia.steps"
    printf "%s\n" "${chkStatus[@]}" | gum style --foreground=11 --border-foreground=3 --border="rounded" --align=left --padding="1 1" --no-strip-ansi 
}
#END STATUSBOX FUNCTION

#START BANNER FUNCTION
# $MenuTitle & $MenuSubTitle are set in the scripts called by this menu
banner () {
gum style --foreground=11 --border-foreground=3 --border="double" --align=center --width="$halfBoxWidth" --margin="1 $halfBoxMargin" --padding="0 0" "$MenuTitle" "$MenuSubTitle"
}
#END BANNER FUNCTION

#START NOCTALIATITLE FUNCTION
noctaliaTitle () {
clear
MenuTitle="Practical Wayland Tools"
MenuSubTitle="Noctalia - Installation"
banner
}
#END NOCTALIATITLE FUNCTION

#START CALL DISPLAY FUNCTION
callDisplay() {
# Calls the display module to update the display
    noctaliaTitle
    statusBox
}
#END CALL DISPLAY FUNCTION

while read -r line; do
    export chkList+=("$line")
done < "$libDir/noctalia.steps"
export chkListTotal=${#chkList[@]}
