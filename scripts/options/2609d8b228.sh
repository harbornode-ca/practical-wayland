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
MenuSubTitle="Noctalia - Base Installation"
banner
statusBox
}
#END NOCTALIATITLE FUNCTION

#START NOCTALIASTEPS FUNCTION
noctaliaSteps () {
cntStep=0
while [ $cntStep -lt $chkTotal ]; do
    IFS=',' read -r complete action inProgress <<< "${chkList[$cntStep]}"
    if [ "$complete" -eq 0 ]; then
      if [ "$inProgress" -eq 0 ]; then
        chkStep["$cntStep"]="'[>]',$action,$inProgress"
      else
        noctaliaTitle
        case $cntStep in
          0)
            $modDir/2609e9802c.sh 
            chkList["$cntStep"]="'[x]',$action,$inProgress"        
          1)
            echo "Check for Just command"
            ;; #Check for Just command
          2)
            echo "Add Noctalia Repository"
            ;; #Add Noctalia Repository
          3)
            echo "Install Noctalia Packages"
            ;; #Install Noctalia Packages
          4)
            echo "Install niri build dependencies"
            ;; #Install niri build dependencies
          5)
            echo "Download niri compositor source"
            ;; #Download niri compositor source
          6)
            echo "Compile niri compositor"
            ;; #Compile niri compositor
          7)
            echo "Install niri compositor"
            ;; #Install niri compositor
          8)
            echo "Install niri runtime packages"
            ;; #Install niri runtime packages
        esac
    fi
    ((cntStep++))      
done
}
#END NOCTALIASTEPS FUNCTION