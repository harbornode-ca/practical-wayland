#!/bin/bash
#Identifies GPU types and installs the appropriate drivers. If running in VM it will exit without adapter.
#Intel and AMD use the Mesa drivers and are installed via APT. NVIDIA drivers are installed through the nvidia drivers repository.
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
amdGPU=$(lspci | grep -i vga | grep -i "AMD")
nvidiaGPU=$(lspci | grep -i vga | grep -i "NVIDIA")
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
depIntel=$(cat /opt/kevrevrun/cfg/deps//intel.dep)
 if [ $installIntel == true ]; then
    echo
    echo "Installing Intel GPU drivers"
    sleep 1
    sudo apt install $depIntel -y 2>&1
fi
depAMD=$(cat /opt/kevrevrun/cfg/deps/amdgpu.dep)
if [ $installAMD == true ]; then
    echo
    echo "Installing AMD GPU drivers"
    sleep 1
    sudo apt install $depAMD -y 2>&1
fi
depNVIDIA=$(cat /opt/kevrevrun/cfg/deps/nvidia.dep)
urlNVIDIA=$(cat /opt/kevrevrun/cfg/nvidia.url)
if [ $installNVIDIA == true ]; then
    echo
    echo "Adding Nvidia Driver Repository"
    sleep 1
    wget -nv -O $tmpDir/cuda.deb $urlNVIDIA
    sudo dpkg -i $tmpDir/cuda.deb 2>&1
    exitCode=$?
    if [ $exitCode -ne 0 ]; then
        echo "Nvidia Driver Repository installation failed!"
        echo "Please try installing Nvidia Driver Repository manually"
        Sleep 1
        echo
        echo "This script will now exit"
        read -p "Press [Enter] key to exit..."
        exit 1
    else
        echo "Nvidia Driver Repository installed successfully"
        sleep 0.5
    fi
    echo
    echo "Updating APT package cache"
    0.5
    echo
    sudo apt update 2>&1
    echo
    echo "APT package cache updated successfully"
    sleep 0.5
    echo "Cleaning up temporary files"
    echo
    rm -fv $tmpDir/cuda.deb
    echo
    echo "Temporary files removed"
    sleep 0.5
    echo
    echo "Installing Nvidia Dependancies"
    sleep 0.5
    echo
    sudo apt install $depNVIDIA -y 2>&1
    echo
    echo "Nvidia Dependancies installed successfully"
    sleep 0.5
    echo
    echo "Installing NVIDIA Driver Packages"
    sleep 0.5
    echo
    sudo apt install nvidia-open -y 2>&1
    echo
    echo "NVIDIA Driver installation completed successfully"
    sleep 0.5
    # The package is signed if secure boot it the key may need to be added via mokutil. Will try install on Nvidia system to confirm if it is needed.
    echo
    read -p "Press [Enter] key to continue..."
fi
echo
echo "Updating the stage file"
echo "5" > $stageFile
sleep 0.5
echo "Stage file updated"
sleep 0.5
echo 
echo "GPU driver installation complete. A reboot is required to apply changes"
echo "Once the system reboots please run the main setup.sh script in your home directory to continue."
sleep 1
echo 
read -p "Press [Enter] key when ready to reboot..."
clear
reboot
exit 0