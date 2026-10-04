#!/bin/bash
#26099ee645.sh - Detects GPU and installs appropriate drivers. If running in VM or no display adapter detected, Mesa basic drivers will be installed.
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

#Check for GPU types via lspci command
#Display output and set flags based on GPU type
stepList
callDisplay
style=info
prtInfo
gum style "Checking for GPU types..."
sleep 1.5
style=info
prtInfo
gum style "Checking for Intel GPU adapters..."
sleep 1.5
intelGPU=$(lspci | grep -i vga | grep -i "Intel")
style=info
prtInfo
gum style "Checking for AMD GPU adapters..."
sleep 1.5
amdGPU=$(lspci | grep -i vga | grep -i "AMD")
style=info
prtInfo
gum style "Checking for NVIDIA GPU adapters..."
sleep 1.5
nvidiaGPU=$(lspci | grep -i vga | grep -i "NVIDIA")
#Setup install GPU flags to false (Default)
installIntel=false
installAMD=false
installNVIDIA=false
installMesa=false
#Check which GPU types are present and set the appropriate flag
#Check for Intel GPU
if [ -n "$intelGPU" ]; then
    installIntel=true
#Check for AMD GPU
elif [ -n "$amdGPU" ]; then
    installAMD=true
#Check for NVIDIA GPU
elif [ -n "$nvidiaGPU" ]; then
    installNVIDIA=true
#No dedicated GPU detected. Installing Mesa basic drivers
else
    installMesa=true
fi
#Install Intel GPU drivers
if [ $installIntel = true ]; then
    style=info
    prtInfo
    gum style "Intel GPU Detected - Installing Intel GPU Drivers"
    sleep 1.5
    style=info
    prtInfo
    gum style "Updating APT package cache"
    sleep 1.5
    sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
    gum spin --spinner="dot" --title="Updating APT package cache" $stubDir/2609d6354b.sh
    style=info
    prtInfo
    gum style "Installing Intel GPU drivers"
    sleep 1.5
    sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
    gum spin --spinner "dots" --title "Installing Intel GPU drivers..." $stubDir/26092717e8.sh
    sleep 0.5
    style=win
    prtInfo
    gum style "Intel driver installation completed successfully"
    sleep 1.5
fi
#Install AMD GPU drivers
if [ $installAMD == true ]; then
    style=info
    prtInfo
    gum style "AMD GPU Detected - Installing AMD GPU Drivers"
    sleep 1.5
    style=info
    prtInfo
    gum style "Updating APT package cache"
    sleep 1.5
    sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
    gum spin --spinner="dot" --title="Updating APT package cache" $stubDir/2609d6354b.sh
    style=info
    prtInfo
    gum style "Installing AMD GPU drivers"
    sleep 1.5
    sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
    gum spin --spinner "dots" --title "Installing AMD GPU drivers..." $stubDir/26099d37d1.sh
    sleep 0.5
    style=win
    prtInfo
    gum style "AMD driver installation completed successfully"
    sleep 1.5
fi
#Install NVIDIA GPU drivers
if [ $installNVIDIA = true ]; then
    callDisplay
    style=info
    prtInfo
    gum style "NVIDIA GPU Detected - Installing NVIDIA GPU Drivers"
    sleep 1.5
    style=info
    prtInfo
    gum style "Updating APT package cache"
    sleep 1.5
    sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
    gum spin --spinner="dot" --title="Updating APT package cache" $stubDir/2609d6354b.sh
    style=info
    prtInfo
    gum style "Installing NVIDIA GPU dependencies"
    sleep 1.5
    sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
    gum spin --spinner="dot" --title="Installing NVIDIA GPU dependencies..." $stubDir/26095349f2.sh
    sleep 0.5
    style=win
    prtInfo
    sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
    gum style "NVIDIA driver dependencies installed successfully"
    sleep 1.5
    style=info
    prtInfo
    gum style "Adding Nvidia Driver Repository"
    sleep 1.5
    sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
    gum spin --spinner="dot" --title="Adding Nvidia Driver Repository"
    style=info
    prtInfo
    gum style "Installing Nvidia Driver Repository"
    sleep 1.5
    sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
    gum spin --spinner="dot" --title="Installing Nvidia Driver Repository" $stubDir/26094beae9.sh
    sleep 0.5
    style=win
    prtInfo
    gum style "Nvidia Driver repository installed successfully"
    sleep 1.5
    style=info
    prtInfo
    gum style "Updating APT package cache"
    sleep 1.5
    sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
    gum spin --spinner="dot" --title="Updating APT package cache" $stubDir/2609d6354b.sh
    sleep 0.5
    style=win
    prtInfo
    sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
    gum style "APT package cache updated successfully"
    sleep 1.5
    style=info
    prtInfo
    gum style "Cleaning up temporary files"
    sleep 1.5
    rm -f $tmpDir/cuda.deb
    style=info
    prtInfo
    gum style "Installing NVIDIA Driver Packages"
    sleep 1.5
    sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
    gum spin --spinner="dot" --title="Installing NVIDIA Driver Packages" $stubDir/2609d6d318.sh
    sleep 0.5
    style=win
    prtInfo
    gum style "NVIDIA Driver installation completed successfully"
    sleep 1.5
    # The package is signed if secure boot it the key may need to be added via mokutil. Will try install on Nvidia system to confirm if it is needed.
fi
#Install Mesa basic drivers
if [ $installMesa = true ]; then
    style=info
    prtInfo
    gum style "Mesa basic drivers - Installing"
    sleep 1.5
    style=info
    prtInfo
    gum style "Updating APT package cache"
    sleep 1.5
    sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
    gum spin --spinner="dot" --title="Updating APT package cache" $stubDir/2609d6354b.sh
    style=info
    prtInfo
    gum style "Installing Mesa video drivers"
    sleep 1.5
    sudo gum style --foreground=11 --margin="1 2" "Sudo access sucessful"
    gum spin --spinner="dot" --title="Installing Mesa video drivers..." $stubDir/2609605982.sh
    sleep 0.5
    style=win
    prtInfo
    gum style "Mesa video drivers installed successfully"
    sleep 1.5
fi
#Show completion messages
style=win
prtInfo
gum style "GPU driver installation(s) completed successfully!"