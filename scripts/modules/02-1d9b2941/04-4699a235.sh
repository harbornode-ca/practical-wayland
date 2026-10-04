#!/bin/bash
#2609b42c25.sh - Install niri Build Dependencies
#Author: kevinrevun - kevin@kevrev.run

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
export lxqtDir=/opt/practical-wayland/scripts/02-1d9b2941
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
MenuSubTitle="LXQt w/ Niri WM - Installation"
banner
}
#END NOCTALIATITLE FUNCTION

stepList () {
while IFS= read -r line; do
    chkStep+=("$line")
done < "$tmpDir/steps.list"
}

#START CALL DISPLAY FUNCTION
callDisplay() {
# Calls the display module to update the display
noctaliaTitle
printf "%s\n" "${chkStep[@]}" | gum style --foreground=11 --border-foreground=3 --border="rounded" --align=left --width="$halfBoxWidth" --margin="1 1" --padding="1 1"
}
#END CALL DISPLAY FUNCTION

stepList
callDisplay
sleep 1
style=info
prtInfo
gum style "Updating APT package cache"
sleep 1
sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
gum spin --spinner=dot --title="Updating APT package cache" $stubDir/2609d6354b.sh
style=win
prtInfo
gum style "APT package cache updated successfully"
sleep 1
style=info
prtInfo
gum style "Installing niri Build Dependencies"
sleep 1
gum spin --spinner=dot --title="Installing niri Build Dependencies" $stubDir/2609f9417f.sh
sleep 1
style=win
prtInfo
gum style "Completed installation of niri Build Dependencies"
sleep 1
