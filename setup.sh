#!/bin/bash
stageFile="/opt/kevrevrun/status/setup.stage"
setupStg=$(cat "$stageFile")
stage1 () {
    echo "Inintializing the install process"
    echo
    echo "Retrieving stage 1 script..."
    echo
    wget -nv -O /opt/kevrevrun/scripts/01-script.sh https://raw.githubusercontent.com/harbornode-ca/practical-wayland/refs/heads/main/scripts/01-script.sh
    if [ -f /opt/kevrevrun/scripts/01-script.sh ]; then
        echo "Script retrieved successfully."
        sleep 0.5
        chmod -v +x /opt/kevrevrun/scripts/01-script.sh
        echo "Running script..."
        sleep 0.5
        /opt/kevrevrun/scripts/01-script.sh
    else
        echo "Script retrieval failed."
        read -p "Press [Enter] key to exit..."
        exit 1
    fi
    if [ $? -eq 0 ]; then
        stage2
    fi
}
stage2 () {
    echo "Updating the System"
    sleep 1
    /opt/kevrevrun/scripts/02-script.sh
}
stage3 () {
    echo "Installing Rust"
    sleep 1
    /opt/kevrevrun/scripts/03-script.sh
    if [ $? -eq 0 ]; then
        stage4
    fi
}
stage4 () {
    echo "Adding i386 architecture to the system"
    sleep 1
    /opt/kevrevrun/scripts/04-script.sh
    if [ $? -eq 0 ]; then
        stage5
    fi
}
stage5 () {
    echo "Installing GPU Drivers"
    sleep 1
    /opt/kevrevrun/scripts/05-script.sh
}
stage6 () {
    echo "Selecting the Desktop Environment"
    sleep 1
    /opt/kevrevrun/scripts/06-script.sh
    if [ $? -eq 0 ]; then
        case $setDEValue in
        1)  
            echo "7" > $stageFile
            echo "Starting Noctalia installer..."
            sleep 1
            stage7
            ;;
        2)  
            echo "8" > $stageFile
            echo "Starting Lemurs Login Manager installer..."
            sleep 1
            stage8
            ;;
        3)  
            echo "not yet implimented"
            read -p "Press [Enter] key to try again"
            stage6
            ;;
        *)  
            echo "Invalid choice"
            read -p "Press [Enter] key to try again"
            stage6
            ;;
        esac
    fi
}
stage7 () {
    echo "Installing Noctalia Desktop Environment"
    sleep 1
    /opt/kevrevrun/scripts/07-script.sh
}
stage8 () {
    echo "Installing Lemurs Login Manager"
    sleep 1
    /opt/kevrevrun/scripts/08-script.sh
}
stage9 () {
    echo "Installing Niri"
    sleep 1
    /opt/kevrevrun/scripts/09-script.sh
}
stage10 () {
    echo "Installing Flatbar & BlueTUI"
    sleep 1
    /opt/kevrevrun/scripts/10-script.sh
}
stage11 () {
    echo "Installing Rat Commander - File Manger"
    sleep 1
    /opt/kevrevrun/scripts/11-script.sh
}
case $setupStg in
    1) 
        stage1
        ;;
    2) 
        stage2
        ;;
    3) 
        stage3
        ;;
    4) 
        stage4
        ;;
    5) 
        stage5
        ;;
    6) 
        stage6
        ;;
    7) 
        stage7
        ;;
    8) 
        stage8
        ;;
    9) 
        stage9
        ;;
    10) 
        stage10
        ;;
    11) 
        stage11
        ;;
    12) 
        stage12
        ;;
    13) 
        stage13
        ;;
    14) 
        stage14
        ;;
    15) 
        stage15
        ;;
    16) 
        stage16
        ;;
    17) 
        stage17
        ;;
    18) 
        stage18
        ;;
    19) 
        stage19
        ;;
    20) 
        stage20
        ;;
    21) 
        stage21
        ;;
    22) 
        stage22
        ;;
    23) 
        stage23
        ;;
    24) 
        stage24
        ;;
    25) 
        stage25
        ;;
    26) 
        stage26
        ;;
    27) 
        stage27
        ;;
    28) 
        stage28
        ;;
    29) 
        stage29
        ;;
    30) 
        stage30
        ;;
    *) 
        echo "Invalid stage"
        read -p "Press [Enter] key to exit..."
        exit 1
        ;;
esac
