#!/bin/bash
#Identifies GPU types and installs the appropriate drivers. If running in VM it will exit without adapter.
#Intel and AMD use the Mesa drivers and are installed via APT. NVIDIA drivers are installed through the nvidia drivers repository.
cmdFail () {
if [ $? -ne 0 ]; then
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
echo "Setting up Folder Variables"
echo
sleep 0.5
fldrList=$(cat /opt/kevrevrun/status/folders.list)
for f in $fldrList; do
    varName=$(echo $f | cut -d ',' -f 1)
    varValue=$(echo $f | cut -d ',' -f 2)
    export $varName="$varValue" 2>&1
    echo "Folder Variable $varName is set to $varValue"
    sleep 0.25
done
echo
echo "Setting up File Variables"
sleep 0.5
echo
varFiles=$(cat /opt/kevrevrun/status/files.list)
for v in $varFiles; do
    varName=$(echo $v | cut -d ',' -f 1)
    varValue=$(echo $v | cut -d ',' -f 2)
    export $varName="$varValue"
    echo "File Variable $varName is set to $varValue"
    sleep 0.25
done
echo
echo "Reading and Exporting All Setup Variables"
sleep 0.5
echo
valueList=$(cat /opt/kevrevrun/status/values.list)
for v in $valueList; do
    varName=$(echo $v | cut -d ',' -f 1)
    fileName=$(echo $v | cut -d ',' -f 2)
    varValue=$(cat $fileName)
    export $varName="$varValue"
    echo "Variable $varName has been imported with value $varValue"
    sleep 0.25
done
echo
echo "Checking for GPU types..."
sleep 0.5
intelGPU=$(lspci | grep -i vga | grep -i "Intel")
exitStat=$?
errMsg="Error on Intel GPU check"
successMsg="Intel GPU check passed"
cmdFail
amdGPU=$(lspci | grep -i vga | grep -i "AMD")
exitStat=$?
errMsg="Error on AMD GPU check"
successMsg="AMD GPU check passed"
cmdFail
nvidiaGPU=$(lspci | grep -i vga | grep -i "NVIDIA")
exitStat=$?
errMsg="Error on NVIDIA GPU check"
successMsg="NVIDIA GPU check passed"
cmdFail
installIntel=false
installAMD=false
installNVIDIA=false
if [ -n "$intelGPU" ]; then
    echo
    echo "Intel GPU detected"
    echo "The following Intel GPUs detected:"
    cat $intelGPU
    sleep 1.5
    installIntel=true
elif [ -n "$amdGPU" ]; then
    echo
    echo "AMD GPU detected"
    echo "The following AMD GPUs detected:"
    cat $amdGPU
    sleep 1.5
    installAMD=true
elif [ -n "$nvidiaGPU" ]; then
    echo
    echo "NVIDIA GPU detected"
    echo "The following NVIDIA GPUs detected:"
    cat $nvidiaGPU
    sleep 1.5
    installNVIDIA=true
else
    echo
    echo "No GPU detected"
fi
if [ $installIntel == true ]; then
    depIntel=$(cat /opt/kevrevrun/cfg/deps/intelgpu.apt)
    echo
    echo "Installing Intel GPU drivers"
    sleep 1
    sudo DEBIAN_FRONTEND=noninteractive apt install $depIntel -y 2>&1
    exitStat=$?
    errMsg="Failed to install Intel GPU drivers"
    successMsg="Intel GPU drivers installed successfully"
    cmdFail
    echo "Intel driver installation completed successfully"
    read -p "Press [ENTER] key to continue..."
fi
if [ $installAMD == true ]; then
    depAMD=$(cat /opt/kevrevrun/cfg/deps/amdgpu.apt)
    echo
    echo "Installing AMD GPU drivers"
    sleep 1
    sudo DEBIAN_FRONTEND=noninteractive apt install $depAMD -y 2>&1
    exitStat=$?
    errMsg="Failed to install AMD GPU drivers"
    successMsg="AMD GPU drivers installed successfully"
    cmdFail
    echo "AMD GPU driver installation completed successfully"
    read -p "Press [ENTER] key to continue..."
fi
if [ $installNVIDIA == true ]; then
    depNVIDIA=$(cat /opt/kevrevrun/cfg/deps/nvidia.apt)
    urlNVIDIA=$(cat /opt/kevrevrun/cfg/nvidia.url)
    echo
    echo "Adding Nvidia Driver Repository"
    sleep 1
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
echo "Updating the stage file"
echo "6" > $stageFile
sleep 0.5
echo "Stage file updated"
sleep 0.5
echo 
echo "GPU driver installation complete. A reboot is required to apply changes"
echo "Once the system reboots please run the main setup.sh script in your home directory to continue."
echo "--------------------------------------------------"
echo "GPU driver installation complete. A reboot is required to apply changes"
echo "Once the system reboots please run the main setup.sh script in your home directory to continue."
echo "Ready to reboot?"
echo "--------------------------------------------------"
read -p "[y/n]" cont
if [[ $cont =~ ^[Yy]$ ]]; then
    echo "Rebooting"
    sleep 1
    clear
    sudo reboot
else
    echo "Aborting installation"
    sleep 1
    exit 1
fi