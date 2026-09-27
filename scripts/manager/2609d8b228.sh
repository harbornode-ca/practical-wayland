#!/bin/bash
#2609d8b228.sh - Noctalia Installation Management Script
#Author: kevrevun - kevin@kevrev.run

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
    info) 
        FOREGROUND=7;
        ;;
    msg) 
        FOREGROUND=11;
        ;;
    lose) 
        FOREGROUND=1;
        ;;
    win) 
        FOREGROUND=2;
        ;;
    *) 
        FOREGROUND=7;
        ;;
esac
}
#END GUM STYLE FUNCTION
chkListTotal=$(wc -l < "$libDir/noctalia.steps")

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
}
#END CALL DISPLAY FUNCTION

chkList=()
while IFS= read -r line; do
    chkList+=("$line")
done < "$libDir/noctalia.steps"
callDisplay
