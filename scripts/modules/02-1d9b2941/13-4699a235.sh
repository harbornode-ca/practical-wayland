#!/bin/bash
#2609e17a87.sh - Adds the Noctalia repository to the system and installs the Noctalia Desktop Environment stack.
#Author: kevrevun - kevin@kevrev.run

#Note: niri is currently being installed as the primary compositor/WM.
#Umbriel is still suffering from stability issues. I will be monitoring
#the situation and will update this script once Umbriel is deemed stable enough
#for daily use.

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
style=info
prtInfo
gum style "Updating APT packages cache"
sleep 1
sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
gum spin --spinner="dot" --title="Updating APT packages cache..." $stubDir/2609d6354b.sh
style=win
prtInfo
gum style "APT packages cache updated successfully"
sleep 1
style=info
prtInfo
gum style "Installing LXQt Packages..."
sleep 1
sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
gum spin --spinner="dot" --title="Installing LXQt Packages..." $stubDir/26104a6d6a.sh
style=win
prtInfo
gum style "LXQt packages installed successfully"
sleep 1
style=win
prtInfo
gum style "LXQt Desktop installed successfully."
sleep 1
