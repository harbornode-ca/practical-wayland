#!/bin/bash
stageFile="/opt/kevrevrun/status/setup.stage"
setupStg=$(cat "$stageFile")
stage1 () {
    echo "Beginning stage 1 of the install process"
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
    echo "Beginning stage 2 of the install process"
    sleep 1
    echo "Running stage 2 script..."
    sleep 0.5
    /opt/kevrevrun/scripts/02-script.sh
}
stage3 () {
    echo "Beginning stage 3 of the install process"
    sleep 1
    echo "Running stage 3 script..."
    sleep 0.5
    /opt/kevrevrun/scripts/03-script.sh
    if [ $? -eq 0 ]; then
        stage4
    fi
}
stage4 () {
    echo "Beginning stage 4 of the install process"
    sleep 1
    echo "Running stage 4 script..."
    sleep 0.5
    /opt/kevrevrun/scripts/04-script.sh
    if [ $? -eq 0 ]; then
        stage5
    fi
}
stage5 () {
    echo "Beginning stage 5 of the install process"
    sleep 1
    echo "Running stage 5 script..."
    sleep 0.5
    /opt/kevrevrun/scripts/05-script.sh
}
stage6 () {
    echo "Beginning stage 6 of the install process"
    sleep 1
    echo "Running stage 6 script..."
    sleep 0.5
    /opt/kevrevrun/scripts/06-script.sh
    if [ $? -eq 0 ]; then
        stage7
    fi
}
case $setupStg in
    "1")
    stage1
        ;;
    "2")
    stage2
        ;;
    "3")
    stage3
        ;;
    "4")
    stage4
        ;;
    "5")
    stage5
        ;;
    "6")
    stage6
        ;;
    "7")
    stage7
        ;;
    "8")
    stage8
        ;;
    "9")
    stage9
        ;;
    "10")
    stage10
        ;;
    "11")
    stage11
        ;;
    "100")
    echo "PLACE HOLDER"
    echo "THIS SHOULD NOT BE A SET OPTION!"
    echo "IF YOU ARE SEEING THIS THEN SOMETHING WENT WRONG!"
    echo
    read -p "Press [Enter] key to exit..."
    clear
    exit 1
    ;;
    *)
    echo "The setup.stage file is corrupted."
    echo "Restting the setup.stage file to stage 1"
    echo "1" > $setupFile
    clear
    exit 1
esac
