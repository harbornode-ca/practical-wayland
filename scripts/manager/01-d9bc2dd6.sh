#!/bin/bash
#2610defc9d.sh - LXQt w/ niri Installation Management Script
#Author: kevrevun - kevin@kevrev.run

#START GUM STYLE FUNCTION
prtInfo () {
case $style in
    info) 
        FOREGROUND=7
        MARGIN="1 2"
        ;;
    msg) 
        FOREGROUND=11;
        MARGIN="1 2"
        ;;
    lose)   
        FOREGROUND=1;
        MARGIN="1 2"
        ;;
    win) 
        FOREGROUND=2;
        MARGIN="1 2"
        ;;
    *) 
        FOREGROUND=7;
        MARGIN="1 2"
        ;;
esac
}
#END GUM STYLE FUNCTION

#START VARIABLE DEFINITIONS
export libDir=/opt/practical-wayland/lib
export modDir=/opt/practical-wayland/scripts/modules
export stubDir=/opt/practical-wayland/scripts/stubs
export mgrDir=/opt/practical-wayland/scripts/manager
export tmpDir=/opt/practical-wayland/tmp
export aptDir=/opt/practical-wayland/lib/apt
export urlDir=/opt/practical-wayland/lib/urls
export lxqtDir=/opt/practical-wayland/scripts/01-1d9b2941
#END VARIABLE DEFINITIONS

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
MenuSubTitle="LXQt w/ Niri WM- Installation"
banner
}
#END NOCTALIATITLE FUNCTION

#START CALL DISPLAY FUNCTION
callDisplay() {
# Calls the display module to update the display
noctaliaTitle
printf "%s\n" "${chkStep[@]}" | gum style --foreground=11 --border-foreground=3 --border="rounded" --align=left --width="$halfBoxWidth" --margin="1 1" --padding="1 1"
}
#END CALL DISPLAY FUNCTION

#Steps file: N=Not Started, C=Completed, I=In Progress
#Load noctalia.steps file into an array
declare -a chkList
while IFS= read -r line; do
    chkList+=("$line")
done < "$libDir/noctalia.steps"

#Declare integer and store total number of install steps
declare -i totalList
export totalList=${#chkList[@]}
#Commented line for debugging purposes.
#echo "Total Items: $totalList"

#Commented out section for debugging purposes
# Echos contents of chkList array one by one
#let count=0
#while [ $count -lt $totalList ]; do
#    echo ${chkList[$count]}
#    ((count++))
#done

# Split comma separated file into arrays
declare -a chkStatus
declare -a chkDesc
chkStatus=()
chkDesc=()
let stepCount=0
while IFS=',' read -r chkStatus chkDesc; do
    chkStatus+=("$chkStatus")
    chkDesc+=("$chkDesc")
    ((stepCount++))
done < "$libDir/noctalia.steps"

declare -a chkStep
declare -i stepCount
stepList () {
chkStep=()
let stepCount=0
while [ $stepCount -lt $totalList ]; do
    if [ "${chkStatus[$stepCount]}" == "N" ]; then
        chkStep+=("[ ] ${chkDesc[$stepCount]}")
    elif [ "${chkStatus[$stepCount]}" == "C" ]; then
        chkStep+=("[X] ${chkDesc[$stepCount]}")
    elif [ "${chkStatus[$stepCount]}" == "I" ]; then
        chkStep+=("[>] ${chkDesc[$stepCount]}")
    else
        chkStep+=("[?] ${chkDesc[$stepCount]}")
    fi
    ((stepCount++))
done
#Export the chkStep array to be used in other functions
}

#Write status to a checklist file
chkWrite () {
> "$tmpDir/steps.list"
for item in "${chkStep[@]}"; do
echo "$item" >> "$tmpDir/steps.list"
done
}

# Echos contents of chkStep array one by one
#chkDisplay () {
#for step in "${chkStep[@]}"; do
#    echo "$step"
#done
#}

#chkProgress function - Start
#Change status to "I" (In Progress) for next "N" (Not Started) step
declare -i eachStep
chkProgress() {
let eachStep=0
while [ $eachStep -lt $totalList ]; do
    if [ "${chkStatus[$eachStep]}" == "N" ]; then
        chkStatus[$eachStep]="I"
        nowStep=$eachStep
        break
    else
        ((eachStep++))
    fi
done
} #chkProgress function - End

#chkComplete function - Start
#Change status to "C" (Completed) for current "I" (In Progress) step
declare -i endTotal
let endTotal=$totalList-1
chkComplete() {
let eachStep=0
while [ $eachStep -lt $totalList ]; do
    if [ "${chkStatus[$eachStep]}" == "I" ]; then
        chkStatus[$eachStep]="C" 
        break
    else
        if [ $eachStep -eq $endTotal ]; then
            break
        fi
        ((eachStep++))
    fi
done
} #chkComplete function - End

#Progress Steps
#Generate install steps into list with stepList function
#Diplay check list with callDisplay function
#Run Module and update status with chkComplete function
#Script should exit when eachStep variable reaches endTotal value

#Generate display and execute scripts in order
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 1/14 - Check for Rust Toolchain
$lxqtDir/00-4699a235.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 2/14 - Install Just
$lxqtDir/01-4699a235.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 3/14 - Install GPU Drivers
$lxqtDir/02-4699a235.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 4/14 - Add Bitmap Font Support
$lxqtDir/03-4699a235.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 5/14 - Install niri build dependencies
$lxqtDir/04-4699a235.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 6/14 - Download niri compositor source
$lxqtDir/05-4699a235.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 7/14 - Compile niri compositor
$lxqtDir/06-4699a235.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 8/14 - Install niri compositor
$lxqtDir/07-4699a235.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 9/14 - Install niri runtime packages
$lxqtDir/08-4699a235.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 10/14 - Install Xwayland Satellite dependencies
$lxqtDir/09-4699a235.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 11/14 - Download Xwayland Satellite Source Code
$lxqtDir/10-4699a235.sh
sleep 2
chkComplete
stepList
chkProgress
callDisplay
chkWrite
#Step 12/14 - Compile Xwayland Satellite
$lxqtDir/11-4699a235.sh
sleep 2
chkComplete
stepList
chkProgress
callDisplay
chkWrite
#Step 13/14 - Install Xwayland Satellite
$lxqtDir/12-4699a235.sh
sleep 2
chkComplete
stepList
callDisplay
#Step 14/14 - Install LXQt from Debian Repositories
$lxqtDir/13-4699a235.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite

