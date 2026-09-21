#!/bin/bash
#Removes packages & configurations installed by installation script
sudo DEBIAN_FRONTEND=noninteractive apt purge noctalia noctalia-greeter umbriel xdg-desktop-portal-umbriel -y
sudo DEBIAN_FRONTEND=noninteractive apt autopurge -y