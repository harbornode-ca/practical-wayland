#!/bin/bash
#2609d8b228.sh - Noctalia Installation Management Script
#Author: kevrevun - kevin@kevrev.run

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
    declare -a chkStatus
    chkStatus=()
    for item in "${chkList[@]}"; do
        IFS=',' read -r status action progress <<< "$item"
        if [[ $status -eq 0 && $progress -eq 0 ]]; then
            chkStatus+=("[ ] $action")
        elif [[ $status -eq 1 && $progress -eq 0 ]]; then
            chkStatus+=("[x] $action")
        elif [[ $status -eq 0 && $progress -eq 1 ]]; then
            chkStatus+=("[>] $action")
        else
            chkStatus+=("[E] $action")
        fi
    done 
    gum style --foreground=11 --border-foreground=3 --width="$halfBoxWidth" --margin="1 1" --border="rounded" --align=left --padding="1 1" --no-strip-ansi "${chkStatus[@]}"
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

declare -i chkListTotal
while IFS= read -r line; do
    export chkList+=("$line")
done < "$libDir/noctalia.steps"
export chkListTotal=${#chkList[@]}
echo "chkListTotal = $chkListTotal"

for item in "${chkList[@]}"; do
    echo "item = $item"
done

declare -a chkStatus
declare -a chkList
declare -a chkProgress
let count=0
while [[ $count -lt $chkListTotal ]]; do
    IFS=',' read -r status action progress <<< "${chkList[$count]}"
    chkStatus+=("$status")
    chkAction+=("$action")
    chkProgress+=("$progress")
    ((count++))
done

for item in "${chkStatus[@]}"; do
    echo "item = $item"
done

for item in "${chkAction[@]}"; do
    echo "item = $item"
done

for item in "${chkProgress[@]}"; do
    echo "item = $item"
done

#START STEP 0 FUNCTION
step_0() {
echo "Step 0 Function"
}
#END STEP 0 FUNCTION

#START STEP 1 FUNCTION
step_1() {
echo "Step 1 Function"
}
#END STEP 1 FUNCTION

#START STEP 2 FUNCTION
step_2() {
echo "Step 2 Function"
}
#END STEP 2 FUNCTION

#START STEP 3 FUNCTION
step_3() {
echo "Step 3 Function"
}
#END STEP 3 FUNCTION

#START STEP 4 FUNCTION
step_4() {
echo "Step 4 Function"
}
#END STEP 4 FUNCTION

#START STEP 5 FUNCTION
step_5() {
echo "Step 5 Function"
}
#END STEP 5 FUNCTION

#START STEP 6 FUNCTION
step_6() {
echo "Step 6 Function"
}
#END STEP 6 FUNCTION

#START STEP 7 FUNCTION
step_7() {
echo "Step 7 Function"
}
#END STEP 7 FUNCTION

#START STEP 8 FUNCTION
step_8() {
echo "Step 8 Function"
}
#END STEP 8 FUNCTION

let count=0
while [[ $count -lt $chkListTotal ]]; do
    if [[ ${chkStatus[$count]} -eq 0 ]]; then
        if [[ ${chkProgress[$count]} -eq 0 ]]; then
            chkList[$count]="${chkStatus[$count]},${chkAction[$count]},1"
            callDisplay
            step_"$count"
            sleep 2
            chkList[$count]="1,${chkAction[$count]},0"
        fi
    fi
    ((count++))
done
callDisplay

