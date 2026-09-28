#!/bin/bash
#26099ee645.sh - Detects GPU and installs appropriate drivers. If running in mesa basic drivers wi;l be installed.
#Intel and AMD use the Mesa drivers and are installed via APT. NVIDIA drivers are installed through the nvidia drivers repository.
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

#Check for GPU types via lspci command
#Display output and set flags based on GPU type
stepList
callDisplay
style=info
prtInfo
gum style "Checking for GPU types..."
sleep 1.5
intelGPU=$(lspci | grep -i vga | grep -i "Intel")
callDisplay
style=info
prtInfo
gum style "The following Intel GPU adapters were detected"
sleep 1.5
callDisplay
style=info
prtInfo
gum style "$intelGPU"
sleep 1.5
amdGPU=$(lspci | grep -i vga | grep -i "AMD")
callDisplay
style=info
prtInfo
gum style "The following AMD GPU adapters were detected"
sleep 1.5
callDisplay
style=info
prtInfo
gum style "$amdGPU"
sleep 1.5
nvidiaGPU=$(lspci | grep -i vga | grep -i "NVIDIA")
callDisplay
style=info
prtInfo
gum style "The following NVIDIA GPU adapters were detected"
sleep 1.5
callDisplay
style=info
prtInfo
gum style "$nvidiaGPU"
sleep 1.5
#Setup install GPU flags to false (Default)
installIntel=false
installAMD=false
installNVIDIA=false
installMesa=false
#Check which GPU types are present and set the appropriate flag
#Check for Intel GPU
if [ -n "$intelGPU" ]; then
    callDisplay
    style=info
    prtInfo
    gum style "Intel GPU detected"
    sleep 1.5
    installIntel=true
#Check for AMD GPU
elif [ -n "$amdGPU" ]; then
    callDisplay
    style=info
    prtInfo
    gum style "AMD GPU detected"
    sleep 1.5
    installAMD=true
#Check for NVIDIA GPU
elif [ -n "$nvidiaGPU" ]; then
    callDisplay
    style=info
    prtInfo
    gum style "NVIDIA GPU detected"
    sleep 1.5
    installNVIDIA=true
#No dedicated GPU detected. Installing Mesa basic drivers
else
    callDisplay
    style=info
    prtInfo
    gum style "No dedicated GPU detected. Installing Mesa basic drivers"
    sleep 1.5
    installMesa=true
fi
#Install Intel GPU drivers
if [ $installIntel == true ]; then
    callDisplay
    style=info
    prtInfo
    gum style "Intel GPU Detected Installing...Intel GPU Drivers"
    sleep 1.5
    callDisplay
    depIntel=$(cat $swAptDir/gpuIntel.apt)
    style=info
    prtInfo
    gum style "Installing Intel GPU drivers"
    sleep 1.5
    gum spin --spinner "dots" --title "Installing Intel GPU drivers..."
    style=msg
    prtInfo
    gum style "Intel driver installation completed successfully"
    sleep 1.5
fi
#Install AMD GPU drivers
if [ $installAMD == true ]; then
    callDisplay
    style=info
    prtInfo
    gum style "AMD GPU Detected Installing...AMD GPU Drivers"
    sleep 1.5
    callDisplay
    depAMD=$(cat $swAptDir/gpuAMD.apt)
    style=info
    prtInfo
    gum style "Installing AMD GPU drivers"
    sleep 1.5
    callDisplay
    sudo gum spin --spinner "dots" --title "Installing AMD GPU drivers..." DEBIAN_FRONTEND=noninteractive apt install $depAMD -y 2>&1
    callDisplay
    style=msg
    prtInfo
    gum style "AMD driver installation completed successfully"
    sleep 1.5
fi
#Install NVIDIA GPU drivers
if [ $installNVIDIA == true ]; then
    callDisplay
    style=info
    prtInfo
    gum style "NVIDIA GPU Detected Installing...NVIDIA GPU Drivers"
    sleep 1.5
    callDisplay
    depNVIDIA=$(cat $swAptDir/gpuNVIDIA.apt)
    style=info
    prtInfo
    gum style "Installing NVIDIA GPU dependencies"
    sleep 1.5
    callDisplay
    sudo gum spin --spinner "dots" --title "Installing NVIDIA GPU dependencies..." DEBIAN_FRONTEND=noninteractive apt install $depNVIDIA -y 2>&1
    callDisplay
    style=msg
    prtInfo
    gum style "NVIDIA driver installation completed successfully"
    sleep 1.5
    urlNVIDIA=$(cat $installDir/nvidia.url)
    callDisplay
    style=info
    prtInfo
    gum style "Adding Nvidia Driver Repository"
    sleep 1.5
    gum spin --spinner "dots" --title "Adding Nvidia Driver Repository" wget -nv -O $tmpDir/cuda.deb $urlNVIDIA
    callDisplay
    style=info
    prtInfo
    gum style "Installing Nvidia Driver Repository"
    sleep 1.5
    callDisplay
    sudo dpkg -i $tmpDir/cuda.deb
    callDisplay
    style=info
    prtInfo
    gum style "Updating APT package cache"
    sleep 1.5
    callDisplay
    sudo gum spin --spinner "dots" --title "Updating APT package cache" DEBIAN_FRONTEND=noninteractive apt update
    callDisplay
    style=info
    prtInfo
    gum style "Cleaning up temporary files"
    sleep 1.5
    rm -fv $tmpDir/cuda.deb
    callDisplay
    style=info
    prtInfo
    gum style "Installing Nvidia Dependancies"
    sleep 1.5
    callDisplay
    sudo DEBIAN_FRONTEND=noninteractive apt install $depNVIDIA -y
    callDisplay
    style=info
    prtInfo
    gum style "Installing NVIDIA Driver Packages"
    sleep 1.5
    callDisplay
    sudo DEBIAN_FRONTEND=noninteractive apt install nvidia-open -y
    callDisplay
    style=info
    prtInfo
    gum style "NVIDIA Driver installation completed successfully"
    sleep 1.5
    # The package is signed if secure boot it the key may need to be added via mokutil. Will try install on Nvidia system to confirm if it is needed.
fi
#Install Mesa basic drivers
if [ $installMesa == true ]; then
    callDisplay
    style=info
    prtInfo
    gum style "Installing Mesa basic drivers"
    sleep 1.5
    callDisplay
    depMesa=$(cat $swAptDir/gpuMesa.apt)
    style=info
    prtInfo
    gum style "Installing Mesa basic drivers"
    sleep 1.5
    callDisplay
    sudo gum spin --spinner "dots" --title "Installing Mesa basic drivers..." DEBIAN_FRONTEND=noninteractive apt install $depMesa -y 2>&1
    callDisplay
    style=msg
    prtInfo
    gum style "Mesa basic driver installation completed successfully"
    sleep 1.5
fi
#Show completion messages
callDisplay
style=win
prtInfo
gum style "GPU driver(s) installation complete. A reboot is required to apply changes"
sleep 2
callDisplay
style=win
prtInfo
gum style "Once the system reboots please run the main setup.sh script in your home directory to continue."
sleep 2
