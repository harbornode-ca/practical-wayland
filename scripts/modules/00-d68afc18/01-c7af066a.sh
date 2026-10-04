#!/bin/bash
#2609d9f593.sh - Checks if Just is installed and installs or updates it
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
gum style "Setting up Just..."
sleep 1.5
if [ -f "$HOME/.cargo/bin/just" ]; then
    style=info
    prtInfo
    gum style "Just is already installed"
    sleep 1
    gum style "Making sure that Just is up to date"
    sleep 1
    gum spin --title "Upgrading Just" $stubDir/2609b4dcf6.sh
    sleep 0.5
    style=win
    prtInfo
    gum style "Just is now up to date."
    sleep 1
else
    style=info
    prtInfo
    gum style "Just is not installed"
    sleep 1
    gum style "Installing Just"
    sleep 1
    gum spin --title "Installing Just" $stubDir/2609b4dcf6.sh
    sleep 0.5
    style=win
    prtInfo
    gum style "Just is now installed."
    sleep 1
fi
