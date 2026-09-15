#!/bin/bash
cfgDir=/opt/kevrevrun
installDir=$PWD
echo $installDir > $cfgDir/install.dir
banner () {
echo
echo "---------------------------------------------------------------------------"
echo "|                           *** KEVREVRUN ***                             |"
echo "|                                 * & *                                   |"
echo "|                  *** The Crappy Bash Scripts Group ***                  |"
echo "|                              * Presents *                               |"
echo "|                  Practical Debian Wayland Environments                  |"
echo "---------------------------------------------------------------------------"
echo
echo
sleep 1
}
# Print error message to screen when command fails.
prt_err () {
clear
banner
echo "ERROR!"
echo
echo "$errMsg"
echo
echo "This script will now exit"
exit 1
}
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
echo
echo "Checking if $sudoUser is a valid user"
sleep 1
chkSudoUser=$(cat /etc/passwd | grep -c $sudoUser)
sleep 1
if [ "$chkSudoUser" = "1" ]; then
	echo
	echo "The user $sudoUser is a valid user!"
	sleep 1
	chk_sudo
else
	clear
	banner
	echo
	echo "Please verify that the user entered is correct."
	add_sudo
fi
}
# Verify user to give sudo priviledges
chk_sudo () {
echo
echo "Creating Sudo User"
sleep 1
echo
echo "Do you want to give $sudoUser root priviledges [y/n]"
read -p "> " confirm
if [ "$confirm" = "y" ]; then
	echo
	echo "Root priviledges will be given to $sudoUser..."
	sleep 1
elif [ "$confirm" = "n" ]; then
	clear
	banner
	sleep 1
	echo
	echo "Please enter the username that you want to give root access to on the next screen"
	read -p "Press Enter to re-enter username"
	add_sudo
else
	invalid
	chk_sudo
fi
echo
echo "Applying sudo group to $sudoUser"
sleep 1
usermod -aG sudo $sudoUser 2>&1
exit=$?
if [ $exit != 0 ]; then
	errMsg="Error adding $sudoUser to the sudo group"
	prt_err
else
	echo
	echo "The user $sudoUser now has root access"
	sleep 1
fi
}
clear
banner
echo "Hold on a sec...They are telling me I need to check ID..."
sleep 1
echo
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
	echo
	echo "Root access has been granted!!!"
	echo
	read -p "Press Enter to continue"
fi
echo
echo "Installing Updates & Need Packages"
sleep 1
echo
echo "Refreshing the package cache..."
apt update
exit=$?
if [ $exit != 0 ]; then
	errMsg="Failed to update package cache"
	prt_err
else
	echo
	echo "The package cache has updated sucessfully"
fi
apt update | tee output.tmp
chkUpdates=$(grep -c "packages can be upgraded" output.tmp 2>&1)
rm output.tmp
if [ $chkUpdates = 1 ]; then
	echo
	echo "Updates are available."
	echo
	echo "Installing updates"
	echo
	apt upgrade -y
	echo
	exit=$?
	if [ $exit != 0 ]; then
		errMsg="Failed to install updates"
		prt_msg
	else
		echo
		echo "Update prcoess has completed sucessfully"
		sleep 1
	fi
else
	echo
	echo "System is already up to date"
	sleep 1
	echo
	echo "No updates to install"
	sleep 1
fi
echo
echo "Running apt to install packages..."
echo
apt install sudo fonts-font-awesome unzip git tmux gpg wget curl build-essential whiptail firmware-linux firmware-linux-nonfree -y 2>&1
echo
exit=$?
if [ $exit != 0 ]; then
	errMsg="Failed to install packages"
	prt_err
else
	echo
	echo "Package installation has completed sucessfully"
	sleep 1

fi
add_sudo
echo
echo "Setting Up Directories and Files"
echo
echo "Configuring setup files..."
sleep 1
if [ -d $cfgDir ]; then
	echo
	echo "Configuration directory already exists..."
	sleep 1
	echo
	echo "Skipping folder creation"
	sleep 1
else
	echo
	mkdir -v $cfgDir 2>&1
	if [ -d $cfgDir ]; then
		echo
		echo "The config directory has been created"
		sleep 1
	else
		errMsg="Failed to create directory."
		prt_err
	fi
fi
for f in "cfg" "status" "scripts" "tmp" "logs"; do
	if [ -d $cfgDir/$f ]; then
		echo
		echo "The directory $f already exists"
		echo
		echo "Skipping directory creation"
		sleep 1
	else
		echo
		echo "Creating directory $f"
		sleep 1
		echo
		mkdir -v $cfgDir/$f
		if [ -d $cfgDir/$f ]; then
			echo
			echo "The directory $f was sucessfully created"
			sleep 1
		else
			errMsg= "Failed to create directory $f"
			prt_err
		fi
	fi
done
echo
echo "Downloading script to continue setup..."
sleep 1
wget -nv -O "/home/$sudoUser/setup.sh" "https://github.com/harbornode-ca/practical-wayland/raw/refs/heads/main/setup.sh" 2>&1
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
chown -v $sudoUser:$sudoUser /home/$sudoUser/setup.sh && chmod -v +x /home/$sudoUser/setup.sh 2>&1
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
for f in "$cfgDir/id.usr" "$cfgDir/name.usr" "$cfgDir/status/setup.stage" "$cfgDir/status/loop.status"; do
	if [ -f  $f ]; then
		echo
		echo "Successfully created $f"
		sleep 1
	else
		errMsg="Failed to create files"
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
