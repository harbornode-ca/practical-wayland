#!/bin/bash
#This is a temporary menu for selecting the environment to be installed.
#Future development will not assume the installation packages with the desktop environment and the user will have choices of defaults.
#Grouped pakages with software will be able to be review and installed. Example: "Development" "Media" "Productivity" "Utilities"
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
# This is a temporary selection  menu for what desktop environment to install a permanent
# selection menu will be implimented in a future release
selMenu()
{
    clear
    echo
    echo "Please select what desktop environment you would like to install"
    sleep 0.5
    echo "1. Noctalia"
    echo "2. Niri /w Flatbar"
    echo "3. lxqt w/ niri wm"
    sleep 0.5
    read -p "Enter your choice [1-3]> " choice
}
case $choice in
    1)
        echo "You selected Noctalia"
        echo
        echo "Updating the stage file"
        echo "6" > $stageFile
        sleep 0.5
        echo 
        echo "Stage file updated"
        sleep 0.5
        echo 
        echo "Noctalia will now install"
        sleep 1
        echo
        $scriptDir/07-script.sh
        ;;       
    2)
        echo "You selected Niri /w Flatbar"
        echo
        echo "Updating the stage file"
        echo "6" > $stageFile
        sleep 0.5
        echo 
        echo "Stage file updated"
        sleep 0.5
        echo 
        echo "Niri /w Flatbar will now install"
        echo 
        sleep 1
        echo
        $scriptDir/08-script.sh       
        ;;
    3)
        echo "You selected lxqt w/ niri wm"
        echo
        echo "Updating the stage file"
        echo "6" > $stageFile
        sleep 0.5
        echo 
        echo "Stage file updated"
        sleep 0.5
        echo 
        echo "lxqt w/ niri wm will now install"
        echo 
        sleep 1
        #Script not yet Implimented
        echo
        echo "Installation script not yet implimented"
        echo "Please select another option"
        sleep 0.5
        echo
        selMenu
        ;;
    *)
        echo "Invalid choice"
        echo "Please try again"
        echo
        read -p "Press [Enter] key to try again"
        selMenu
        ;;
esac
