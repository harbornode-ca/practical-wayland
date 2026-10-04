#!/bin/bash
#2609d64847.sh - Adds the Noctalia repository to the system
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
export nocDir=/opt/scripts/modules/00-d68afc18
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
MenuSubTitle="Noctalia - Installation"
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
gum style "Setting up Noctalia Repository"
sleep 1
echo
style=info
prtInfo
gum style "Downloading keyring"
sleep 1
sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
gum spin --spinner="dot" --title="Downloading keyring..." $stubDir/26095f8e6f.sh
style=win
prtInfo
gum style "Noctalia keyring downloaded successfully"
sleep 1
style=info
prtInfo
gum style "Installing Noctalia Keyring"
sleep 1.5
sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
gum spin --spinner="dot" --title="Installing Noctalia Keyring..." $stubDir/26091d5155.sh
style=win
prtInfo
gum style "Noctalia keyring installed successfully"
sleep 1
style=info
prtInfo
gum style "Setting up Noctalia sources file"
sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
gum spin --spinner="dot" --title="Setting up Noctalia sources file..." $stubDir/26098505c2.sh
style=win
prtInfo
gum style "Noctalia sources file set up successfully"
sleep 1
style=win
prtInfo
gum style "Noctalia Repository set up successfully."
sleep 1
