#!/bin/bash
#261012d5ad.sh - Install Lemurs

cd $tmpDir/lemurs
#Copy compiled binary to /usr/bin/
sudo cp -f "target/release/lemurs" "/usr/bin/lemurs"
sleep 0.25
#Create directories for Lemurs config files
sudo mkdir -p "/etc/lemurs/wms"
sleep 0.25
sudo mkdir -p "/etc/lemurs/wayland"
sleep 0.25
#Copy Lemurs config files to /etc/lemurs/
sudo cp -f "extra/config.toml" "/etc/lemurs/config.toml"
sleep 0.25
sudo cp -f "extra/xsetup.sh" "/etc/lemurs/xsetup.sh"
sleep 0.25
#Add Lemurs to PAM for authentication
sudo cp -f "extra/lemurs.pam" "/etc/pam.d/lemurs"
sleep 0.25
#Disable current display manager
sudo systemctl disable display-manager.service
sleep 0.25
#Copy Lemurs service file to /usr/lib/systemd/system/
sudo cp -f "extra/lemurs.service" "/usr/lib/systemd/system/lemurs.service"
sleep 0.25
#Enable Lemurs to start on boot
sudo systemctl enable lemurs.service
sleep 0.5