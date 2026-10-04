#!/bin/bash
#2610f3b8ae.sh - Niri w/ Ashell Installation Management Script
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
export stubDir=/opt/practical-wayland/scripts/stubs/00-shared
export stub01Dir=/opt/practical-wayland/scripts/stubs/01-ec4b9530
export stub02Dir=/opt/practical-wayland/scripts/stubs/02-1d9b2941
export stub03Dir=/opt/practical-wayland/scripts/stubs/03-0586750e
export mgrDir=/opt/practical-wayland/scripts/manager
export tmpDir=/opt/practical-wayland/tmp
export aptDir=/opt/practical-wayland/lib/apt
export urlDir=/opt/practical-wayland/lib/urls
export ashellDir=/opt/practical-wayland/scripts/03-0586750e
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
MenuSubTitle="niri WM /w Ashell Installation"
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
done < "$libDir/niri-ashell.steps"

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
done < "$libDir/niri-ashell.steps"

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
#Step 1/20 - Check for Rust Toolchain
$$ashellDir/00-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 2/20 - Check for Installation of Just
$ashellDir/01-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 3/20 - Install GPU Drivers
$ashellDir/02-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 4/20 - Install & Configure Bitmap Fonts
$ashellDir/03-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 5/20 - Install Lemurs Dependencies
$ashellDir/04-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 6/20 - Download Lemurs Login Manager Source
$ashellDir/05-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 7/20 - Compile Lemurs Login Manager from sources
$ashellDir/06-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 8/20 - Install Lemurs Login Manager binaries and configuration
$ashellDir/07-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 9/20 - Install niri WM Build Dependencies
$ashellDir/08-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 10/20 - Download niri WM Source
$ashellDir/09-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 11/20 - Install niri runtime packages
$ashellDir/10-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 12/20 - Compile niri WM from source
$ashellDir/11-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
stepList
callDisplay
chkWrite
#Step 13/20 - Install niri WM binaries and configuration
$ashellDir/12-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
callDisplay
chkWrite
#Step 14/20 - Install Xwayland Satellite Dependencies
$ashellDir/13-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
callDisplay
chkWrite
#Step 15/20 - Download Xwayland Satellite Source Code
$ashellDir/14-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
callDisplay
chkWrite
#Step 16/20 - Compile Xwayland Satellite from Source
$ashellDir/15-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
callDisplay
chkWrite
#Step 17/20 - Install Xwayland Satellite binary
$ashellDir/16-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
callDisplay
chkWrite
#Step 18/20 - Install Ashell Dependencies
$ashellDir/17-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
callDisplay
chkWrite
#Step 19/20 - Install Ashell from Source
$ashellDir/18-dbec762b.sh
sleep 2
chkComplete
stepList
chkProgress
callDisplay
chkWrite
#Step 20/20 - Install Ashell binaries and configuration
$ashellDir/19-dbec762b.sh
sleep 2
stepList
chkComplete
callDisplay
