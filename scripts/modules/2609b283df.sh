#!/bin/bash
#2609b283df.sh - Check for Rust Installation and Install/Update if needed

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

#START STATUSBOX FUNCTION
#statusBox creates a box with a checklist for installation steps
statusBox () {
count=0
while [ $count -lt $chkTotal ]; do
    IFS=',' read -r step status action inProgress <<< "${chkList[$count]}"
    if [ "$status" -eq 0 -a "$inProgress" -eq 0 ]; then
        chkStatus["$count"]="[ ] $action"
    elif [ "$status" -eq 1 -a "$inProgress" -eq 0 ]; then
      chkStatus["$count"]="[x] $action"
    elif [ "$status" -eq 0 -a "$inProgress" -eq 1 ]; then
      chkStatus["$count"]="[>] $action"
    else
      chkStatus["$count"]="[E] $action"
    fi
    ((count++))      
done
printf "%s\n" "${chkStatus[@]}" | gum style --foreground=11 --border-foreground=3 --border="rounded" --align=left --padding="1 1" --no-strip-ansi 
}
#END STATUSBOX FUNCTION

#START CALL DISPLAY FUNCTION
callDisplay() {
# Calls the display module to update the display
    noctaliaTitle
    statusBox
}
#END CALL DISPLAY FUNCTION

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

#START RUN MODULE
gum style "Checking for existing installation of Rust"
sleep 1.5
callDisplay
if [ -d "$HOME/.cargo" ]; then
    style=info
    prtInfo
    gum style "Rust is already installed"
    sleep 1
    callDisplay
    gum spin --title "Making sure that the Rust Toolkit is up to date" $stubDir/2609ebcd21.sh
    sleep 0.5
    callDisplay
    gum style "Rust Toolkit is now up to date."
    sleep 1
else 
    style=info
    prtInfo
    gum style "Rust not installed"
    sleep 1
    callDisplay
    gum spin --title "Installing Rust" $stubDir/2609fd1bba.sh
    sleep 0.5
    callDisplay
    gum style "Rust is now installed."
    sleep 1
fi
#END RUN MODULE
