#!/bin/bash
#2609b283df.sh - Check for Rust Installation and Install/Update if needed
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
gum style "Setting up Rust Toolchain..."
sleep 1.5
if [ -d "$HOME/.cargo" ]; then
    style=info
    prtInfo
    gum style "Rust Toolchain is already installed"
    sleep 1.5
    gum style "Confirming Rust Toolchain is up to date"
    sleep 1.5
    gum spin --title "Updating Rust Toolchain" $stubDir/2609ebcd21.sh
    sleep 1
    style=win
    prtInfo
    gum style "Rust Toolchain is up to date."
    sleep 1.5
else
    style=info
    prtInfo
    gum style "Rust Toolchain is not installed"
    sleep 1
    gum style "Installing Rust Toolchain"
    sleep 1.5
    gum spin --title "Installing Rust Toolchain" $stubDir/2609fd1bba.sh
    sleep 1
    style=win
    prtInfo
    gum style "Rust Toolchain is now installed."
    sleep 1.5
fi
