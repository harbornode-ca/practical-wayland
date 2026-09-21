#!/bin/bash
#Identifies GPU types and installs the appropriate drivers. If running in VM it will exit without adapter.
#Intel and AMD use the Mesa drivers and are installed via APT. NVIDIA drivers are installed through the nvidia drivers repository.
if [ $exitStat -ne 0 ]; then
    echo "$errMsg"
    sleep 1
    echo
    echo "This script will now exit"
    read -p "Press [ENTER] key to exit"
    clear
    exit 1
else
    echo "$successMsg"
fi
}
#These variables need to be set directly after a process ends to capture the $? value and output a message, cmdFail runs function.
#exitStat=$?
#errMsg="ERROR MESSAGE"
#successMsg="SUCCESS MESSAGE"
#cmdFail
echo "Checking for GPU types..."
sleep 0.5
intelGPU=$(lspci | grep -i vga | grep -i "Intel")
exitStat=$?
errMsg="Error on Intel GPU check"
successMsg="Intel GPU check passed"
cmdFail
echo "The following Intel GPU adapters were detected"
lspci | grep -i vga | grep -i "Intel"
read -p "Press [ENTER] key to continue..."
amdGPU=$(lspci | grep -i vga | grep -i "AMD")
exitStat=$?
errMsg="Error on AMD GPU check"
successMsg="AMD GPU check passed"
cmdFail
echo "The following AMD GPU adapters were detected"
lspci | grep -i vga | grep -i "AMD"
read -p "Press [ENTER] key to continue..."
nvidiaGPU=$(lspci | grep -i vga | grep -i "NVIDIA")
exitStat=$?
errMsg="Error on NVIDIA GPU check"
successMsg="NVIDIA GPU check passed"
cmdFail
echo "The following NVIDIA GPU adapters were detected"
lspci | grep -i vga | grep -i "NVIDIA"
read -p "Press [ENTER] key to continue..."
installIntel=false
installAMD=false
installNVIDIA=false
if [ -n "$intelGPU" ]; then
    echo
    echo "Intel GPU detected"
    sleep 0.5
    installIntel=true
elif [ -n "$amdGPU" ]; then
    echo
    echo "AMD GPU detected"
    sleep 0.5
    installAMD=true
elif [ -n "$nvidiaGPU" ]; then
    echo
    echo "NVIDIA GPU detected"
    sleep 0.5
    installNVIDIA=true
else
    echo
    echo "No GPU detected"
    sleep 1.5
fi
if [ $installIntel == true ]; then
    depIntel=$(cat $swAptDir/gpuIntel.apt)
    echo
    echo "Installing Intel GPU drivers"
    sleep 0.5
    sudo DEBIAN_FRONTEND=noninteractive apt install $depIntel -y 2>&1
    exitStat=$?
    errMsg="Failed to install Intel GPU drivers"
    successMsg="Intel GPU drivers installed successfully"
    cmdFail
    echo "Intel driver installation completed successfully"
    sleep 0.5
    read -p "Press [ENTER] key to continue..."
fi
if [ $installAMD == true ]; then
    depAMD=$(cat $swAptDir/gpuAMD.apt)
    echo
    echo "Installing AMD GPU drivers"
    sleep 0.5
    sudo DEBIAN_FRONTEND=noninteractive apt install $depAMD -y 2>&1
    exitStat=$?
    errMsg="Failed to install AMD GPU drivers"
    successMsg="AMD GPU drivers installed successfully"
    cmdFail
    echo "AMD GPU driver installation completed successfully"
    sleep 0.5
    read -p "Press [ENTER] key to continue..."
fi
if [ $installNVIDIA == true ]; then
    depNVIDIA=$(cat $swAptDir/gpuNVIDIA.apt)
    urlNVIDIA=$(cat $installDir/nvidia.url)
    echo
    echo "Adding Nvidia Driver Repository"
    sleep 0.5
    wget -nv -O $tmpDir/cuda.deb $urlNVIDIA
    exitStat=$?
    errMsg="Failed to download Nvidia Driver Repository"
    successMsg="Nvidia Driver Repository downloaded successfully"
    cmdFail
    sudo dpkg -i $tmpDir/cuda.deb
    exitStat=$?
    errMsg="Failed to install Nvidia Driver Repository"
    successMsg="Nvidia Driver Repository installed successfully"
    cmdFail
    echo
    echo "Updating APT package cache"
    sleep 0.5
    echo
    sudo DEBIAN_FRONTEND=noninteractive apt update
    exitStat=$?
    errMsg="Failed to update APT package cache"
    successMsg="APT package cache updated successfully"
    cmdFail
    echo
    echo "Cleaning up temporary files"
    sleep 0.5
    echo
    rm -fv $tmpDir/cuda.deb
    exitStat=$?
    errMsg="Failed to remove temporary files"
    successMsg="Temporary files removed successfully"
    cmdFail
    echo
    echo "Installing Nvidia Dependancies"
    sleep 0.5
    echo
    sudo DEBIAN_FRONTEND=noninteractive apt install $depNVIDIA -y
    exitStat=$?
    errMsg="Failed to install Nvidia Dependancies"
    successMsg="Nvidia Dependancies installed successfully"
    cmdFail
    echo
    echo "Installing NVIDIA Driver Packages"
    sleep 0.5
    echo
    sudo DEBIAN_FRONTEND=noninteractive apt install nvidia-open -y
    exitStat=$?
    errMsg="Failed to install NVIDIA Driver Packages"
    successMsg="NVIDIA Driver installation completed successfully"
    cmdFail
    # The package is signed if secure boot it the key may need to be added via mokutil. Will try install on Nvidia system to confirm if it is needed.
    echo
    read -p "Press [Enter] key to continue..."
fi
echo 
echo "--------------------------------------------------"
echo "GPU driver installation complete. A reboot is required to apply changes"
echo "Once the system reboots please run the main setup.sh script in your home directory to continue."
echo "--------------------------------------------------"
sleep 1