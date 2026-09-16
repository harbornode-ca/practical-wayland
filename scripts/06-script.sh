#!/bin/bash
#This is a temporary menu for selecting the environment to be installed.
#Future development will not assume the installation packages with the desktop environment and the user will have choices of defaults.
#Grouped pakages with software will be able to be review and installed. Example: "Development" "Media" "Productivity" "Utilities
# This is a temporary selection  menu for what desktop environment to install a permanent
# selection menu will be implimented in a future release
selDE="/opt/kevrevrun/status/selDE.status"
selDEValue=$(cat $selDE)
selMenu() {
    clear
    echo
    echo "Please select what desktop environment you would like to install"
    sleep 0.5
    echo "1. Noctalia"
    echo "2. Niri /w Flatbar"
    echo "3. lxqt w/ niri wm"
    sleep 0.5
    read -p "Enter your choice [1-3]> " choice
    run_choice
}
chk_sel () {
    echo "confirming selection files exists"
    if [ -f $selDE ]; then
        echo "Selection file confirmed"
        sleep 1
        if [ $selDEValue -gt 0 ]; then
            case $selDEValue in
            1)
                chosenDE="Noctalia"
                ;;       
            2)
                chosenDE="Niri /w Flatbar"
                ;;
            3)
                chosenDE="lxqt w/ niri wm"
                ;;
        esac
        echo
        echo "It appears you have already selected an environment."
        echo "Your selected installation is $chosenDE"
        sleep 0.5
        echo "Would you like to keep this selection?"
        read -p "[y/n]" keep
        if [ $keep = "y" ]; then
            echo "Keeping selection"
            sleep 1
            choice=$selDEValue
            run_choice
        else
            echo "Changing selection"
            sleep 1
            selMenu
        fi
    else
        echo "Opening selection menu"
        sleep 1
        selMenu
    fi
else
    echo "Selection file not found"
    sleep 0.25
    echo "Creating selection file"
    sleep 0.5
    echo "0" > $selDE
    echo "Selection file created"
    sleep 0.5
fi
}
run_choice () {
case $choice in
    1)
        echo "You selected Noctalia"
        sleep 0.5
        echo
        echo "Updating the stage file"
        sleep 0.5
        echo "1" > $statusDir/selDE.status
        sleep 0.5
        echo "Environment selection updated"
        sleep 0.5
        echo 
        echo "Installing Noctalia"
        sleep 1
        echo
        echo "7" > $stageFile
        $scriptDir/07-script.sh
        exit 0
        ;;       
    2)
        echo "You selected Niri /w Flatbar"
        echo
        echo "setting environment selection"
        sleep 0.5
        echo "2" > $statusDir/selDE.status
        echo "Environment selection updated"
        sleep 0.5
        echo 
        echo "Installing Niri /w Flatbar"
        echo 
        sleep 1
        echo
        echo "8" > $stageFile
        $scriptDir/08-script.sh 
        exit 0    
        ;;
    3)
        echo "You selected lxqt w/ niri wm"
        echo
        #echo "Updating the stage file"
        #echo "6" > $stageFile
        #echo "Stage file updated"
        #sleep 0.5
        #echo "setting environment selection"
        #sleep 0.5
        #echo "3" > $statusDir/selDE.status
        #echo "Environment selection updated"
        #sleep 0.5
        #echo 
        #echo "Installing lxqt w/ niri wm"
        #echo 
        #sleep 1
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
}
chk_sel