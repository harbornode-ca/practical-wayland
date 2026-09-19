#!/bin/bash

cfgDir=/opt/kevrevrun
setupDir=$PWD
echo $setupDir > $cfgDir/setup.dir

banner () {
echo
echo "---------------------------------------------------------------------------"
echo "|                           *** KEVREVRUN ***                             |"
echo "|                                 * & *                                   |"
echo "|                  *** The Crappy Bash Scripts Group ***                  |"
echo "|                              * Presents *                               |"
echo "|                  Practical Debian Wayland DE Installer                  |"
echo "---------------------------------------------------------------------------"
echo
echo
sleep 1
}

# Print error message to screen when command fails.
cmdFail () {
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

# Display when an invalid response is entered
invalid () {
clear
banner
echo "INVAILD RESPONSE ENTERED!"
echo "Please enter a vailid response"
read -p "Press Enter to retry"
}
# Add sudo priviledges to a user
add_sudo () {
echo
echo "Gathering user information"
sleep 1
echo
echo "Enter the username of user to be given sudo permission below"
read -p "> " sudoUser
echo "Checking if $sudoUser is a valid user"
sleep 1
chkSudoUser=$(cat /etc/passwd | grep -c $sudoUser)
sleep 1
if [ "$chkSudoUser" = "1" ]; then
	echo "The user $sudoUser is a valid user!"
	sleep 1
	chk_sudo
else
	invalid
	add_sudo
fi
}
# Verify user to give sudo priviledges
chk_sudo () {
echo
echo "Creating Sudo User"
sleep 1
echo "Do you want to give $sudoUser root priviledges [y/n]"
read -p "> " confirm
if [ "$confirm" = "y" ]; then
	echo "Root priviledges will be given to $sudoUser..."
	sleep 1
elif [ "$confirm" = "n" ]; then
	echo "You have chosen not to give $sudoUser root access."
	sleep 1
	add_sudo
else
	invalid
	chk_sudo
fi
echo "Applying sudo group to $sudoUser"
sleep 1
usermod -aG sudo $sudoUser 2>&1
exitStat=$?
errMsg="Adding $sudoUser to the sudo group failed"
successMsg="The user $sudoUser now has root access"
cmdFail
}
clear
banner
echo "Hold on a sec...They are telling me I need to check ID..."
sleep 1
echo "Checking root access..."
sleep 1
if [ "$EUID" != 0 ]; then
	echo
	echo "*****************"
	echo "*** IMPORTANT ***"
	echo "*****************"
	echo
	echo "--------------------------------------------------------"
	echo "| Error: Root access not detected!                     |"
	echo "| Login as root and re-run this script.                |"
	echo "| *Note: Debian does not setup a sudo user by default* |"
	echo "--------------------------------------------------------"
	echo
	echo "*****************"
	echo "*** IMPORTANT ***"
	echo "*****************"
	echo
	echo "This script will now exit"
	echo
	sleep 1
	read -p "Press Enter to exit"
        clear
	exit 1
else
	echo "Root access has been granted!!!"
	sleep 1.5
fi
echo
echo "Installing Updates & Need Packages"
sleep 1
echo
echo "Refreshing the package cache..."
apt update
exitStat=$?
errMsg="Failed to update package cache"
successMsg="The package cache has updated sucessfully"
cmdFail
apt update | tee output.tmp
chkUpdates=$(grep -c "packages can be upgraded" output.tmp 2>&1)
rm output.tmp
if [ $chkUpdates = 1 ]; then
	echo "The package cache has updated sucessfully"
fi
apt update | tee output.tmp
chkUpdates=$(grep -c "packages can be upgraded" output.tmp 2>&1)
rm output.tmp
if [ $chkUpdates = 1 ]; then
	echo "Updates are available."
	sleep 1
	echo "Installing updates"
	apt upgrade -y
	exitStat=$?
	errMsg="Failed to install updates"
	successMsg="Update prcoess has completed sucessfully"
	cmdFail
else
	echo
	echo "Update prcoess has completed sucessfully"
	sleep 1
fi
echo
echo "Running apt to install packages..."
echo
apt install sudo fonts-font-awesome unzip git tmux gpg wget curl build-essential whiptail firmware-linux firmware-linux-nonfree -y 2>&1
exitStat=$?
errMsg="Failed to install packages"
successMsg="Package installation has completed sucessfully"
cmdFail
add_sudo
echo
echo "Setting Up Directories and Files"
echo
echo "Configuring setup files..."
sleep 1
if [ -d $cfgDir ]; then
	echo "Configuration directory already exists..."
	sleep 1
	echo "Skipping folder creation"
	sleep 1
else
	echo "Creating directory"
	mkdir -v $cfgDir 2>&1
	exitStat=$?
	errMsg="Failed to create directory"
	successMsg="The directory was created sucessfully"
	cmdFail
fi
for f in "cfg" "status" "scripts" "tmp" "logs"; do
	if [ -d $cfgDir/$f ]; then
		echo "The directory $f already exists"
		echo "Skipping directory creation"
		sleep 1
	else
		echo "Creating directory $f"
		sleep 1
		mkdir -v $cfgDir/$f
		exitStat=$?
		errMsg="Failed to create directory $f"
		successMsg="The directory $f was sucessfully created"
		cmdFail
	fi
done
echo
echo "Setting setup directory as /home/$sudoUser"
sleep 1
echo "$setupDir" > $setupDirFile
echo "$setupDir" is now set as setup directory
sleep 1
echo
echo "Downloading script to continue setup..."
sleep 1
wget -nv -O "$setupDir/setup.sh" "https://github.com/harbornode-ca/practical-wayland/raw/refs/heads/main/setup.sh" 2>&1
exit=$?
if [ "$exit" != "0" ]; then
	errMsg="Script failed to download"
else
	echo
	echo "Script downloaded sucessfully"
	sleep 1
fi
echo
echo "Setting file permissions..."
sleep 1
chown -v $sudoUser:$sudoUser $setupDir/setup.sh
chmod -v +x $setupDir/setup.sh 2>&1
exit=$?
if [ $exit != 0 ]; then
	errMsg="Failed to set file/folder permissions"
	prt_err
else
	echo
	echo "Sucessfully applied file permisssions"
fi
echo
echo "Saving some information for the next steps of the installation..."
sleep 1
id -u $sudoUser > $cfgDir/id.usr
echo $sudoUser > $cfgDir/name.usr
echo 1 > $cfgDir/status/setup.stage
echo 
for f in "$cfgDir/id.usr" "$cfgDir/name.usr" "$cfgDir/status/setup.stage"; do
	if [ -f  $f ]; then
		echo
		echo "Successfully created $f"
		sleep 1
	else
		errMsg="Failed to create $f"
		prt_err
	fi
done
echo
echo "Finished setting up files and directories"
sleep 1
echo
echo "Setting up user file permissions"
sleep 1
echo
echo "Getting user details"
sleep 1
usrName=$sudoUser
usrID=$(cat /etc/passwd | grep $usrName | cut -d ":" -f 3)
sleep 1
echo
echo "Setting file permissions"
echo
sleep 1
chown -Rv $usrName:$usrName "$cfgDir"
usrOwner=$(ls -ld $cfgDir | cut -d " " -f 3)
usrGroup=$(ls -ld $cfgDir | cut -d " " -f 4)
if [ $usrOwner = $usrName ]; then
	if [ $usrGroup = $usrName ]; then
		echo
		echo "File permission have been properly set"
		sleep 1
	else
		errMsg="Failed to set file permissions"
		prt_err
	fi
fi
echo
echo "Installing Charmbracelet Gum Tool"
echo
echo "Downloading Gum... "
sleep 1
gumUrl="https://github.com/charmbracelet/gum/releases/download/v0.17.0/gum_0.17.0_amd64.deb"
gumDeb="gum_0.17.0_amd64.deb"
wget -nv -O /tmp/$gumDeb $gumUrl 2>&1
exit=$?
if [ ! -f /tmp/$gumDeb ]; then
        errMsg="Download Failed!"
        prt_err
else
	echo
    echo "Download was sucessful!"
    sleep 1
fi
# Installing Gum .deb file using apt
echo
echo "Installing Gum..."
apt install /tmp/$gumDeb -y --allow-downgrades 2>&1
exit=$?
if [ $exit != 0 ]; then
        errMsg="Gum installed failed"
        prt_err
else
        echo
        echo "The Gum package has been sucessfully installed"
fi
echo
echo "Setup Complete!"
echo
read -p "Press Enter to continue"
clear
banner
echo
echo "Setup Completed"
sleep 1
echo
echo "*** IMPORTANT ***"
echo
echo "[Instructions]"
echo "- The setup.sh files has been added to the home directory of $sudoUser"
echo "- A reboot is required to continue setup"
echo "- Log in as $sudoUser when system restarts"
echo "- Run sudo setup.sh from $sudoUser home directory"
echo
echo
sleep 1
read -p "Press Enter to reboot the system"
echo
echo "The system will now reboot..."
echo
sleep 2
#reboot
clear
exit 0
