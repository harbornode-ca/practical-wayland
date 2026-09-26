#!/bin/bash
#Script Information

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
declare -a chkList
declare -a chkStatus
while read -r line; do
    chkList+=("$line")
done < "$libDir/noctalia.steps"
chkTotal="${#chkList[@]}"
count=0
while [ $count -lt $chkTotal ]; do
    IFS=',' read -r complete action inProgress string <<< "${chkList[$count]}"
    if [ "$complete" -eq 0 ]; then
      if [ "$inProgress" -eq 1 ]; then
        chkStatus["$count"]="[>] $action"
      else
        chkStatus["$count"]="[ ] $action"
      fi
    else
      chkStatus["$count"]="[x] $action"
    fi
    ((count++))      
done
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

noctaliaTitle
statusBox


