#!/bin/bash
#This menu will get the users choice of the Desktop Enviroment they want to use.
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
echo "Desktop Environment selection process starting"
sleep 1
