#!/bin/bash
#2609de7bae.sh - Adds bitmap font support for Glyph support in TUI and GUIs
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
export aptDir=/opt/practical-wayland/lib/apt
export urlDir=/opt/practical-wayland/lib/urls
export mgrDir=/opt/practical-wayland/scripts/manager
export modDir=/opt/practical-wayland/scripts/modules
export tmpDir=/opt/practical-wayland/tmp
export stubDir=/opt/practical-wayland/scripts/stubs/00-shared
export stub01Dir=/opt/practical-wayland/scripts/stubs/01-d68afc18
export stub02Dir=/opt/practical-wayland/scripts/stubs/02-1d9b2941
export stub03Dir=/opt/practical-wayland/scripts/stubs/03-0586750e
export nocDir=/opt/practical-wayland/scripts/modules/01-d68afc18
export lxqtDir=/opt/practical-wayland/scripts/modules/02-1d9b2941
export ashellDir=/opt/practical-wayland/scripts/modules/03-0586750e
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
gum style "Adding bitmap font support for Glyph support in TUI and GUIs"
sleep 1
style=info
prtInfo
gum style "Checking for disabled bitmap fonts..."
sleep 1
while IFS= read -r file; do
    if [ -f "$file" ]; then
        style=info
        prtInfo
        gum style "Fontconfig File $file found"
        sleep 1
        style=info
        prtInfo
        gum style "Removing fontconfig file $file"
        sudo rm -f "$file"
        sleep 1
    fi
done < $libDir/fontconfig-rm.list
style=info
prtInfo
gum style "Adding bitmap fontconfig file to the font configuration directory"
sleep 1
while IFS="," read -r src dest; do
    style=info
    prtInfo
    gum style "Creating hardlink from $src to $dest"
    sleep 0.5
    sudo ln -f "$src" "$dest"
done < $libDir/fontconfig-add.csv
style=info
prtInfo
gum spin --title "Updating APT package cache" $stubDir/2609d6354b.sh
sleep 1
style=info
prtInfo
gum style "Installing symbol fonts (Noto Color Emoji, Nerd Symbols, FontAwesome)"
sleep 1.5
sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
gum spin --title "Installing symbol fonts..." $stubDir/260942925a.sh
sleep 0.5
style=win
prtInfo
gum style "Bitmap Font support and symbol fonts installed successfully."
sleep 1 
