#!/bin/bash
#main.sh - Main menu

#START OSTYPE FUNCTION
#Uses fastfetch to get the OS type and prints it to the terminal.
#This function is only meant to be used once at the start of the script to pull in terminal info.
osType () {
	fastfetch | grep OS | cut -d ":" -f 2 | cut -c2-
    clear
}
#END OSTYPE FUNCTION

#START COLMATH FUNCTION
#Calculates widths and margins for gum boxes based on terminal columns
colMath (){
declare -i cols third fifth half qtr qqqtr qtrMargin halfMargin thirdMargin fifthMargin qqqtrMargin
let cols=$COLUMNS-2
let qtr=$cols/4
let qtrMargin=$qtr*2
let half=$qtr*2
let halfMargin=$qtr
let qqqtr=$qtr*3
let qqqtrMargin=$qtr/2
let third=$cols/3
let thirdMargin=$third/1
let fifth=$cols/5
let fifthMargin=$fifth*2
export halfBoxWidth="$half"
export halfBoxMargin="$halfMargin"
export thirdBoxWidth="$third"
export thirdBoxMargin="$thirdMargin"
export qqqtrBoxWidth="$qqqtr"
export qqqtrBoxMargin="$qqqtrMargin"
export fifthBoxWidth="$fifth"
export fifthBoxMargin="$fifthMargin"

#Column math for two boxes side-by-side by percentage
declare -i colsa colsb widtha widthb side
let colsa=side
let colsb=100-side
let widtha=colsa-4
let widthb=colsb-4
export colsa
export colsb
export widtha
export widthb
}
#END COLMATH FUNCTION

showBoxPair () {
sideA=$(gum style --width="$widtha" --border=double --border-foreground=7 --padding="1 2" --margin="0 1" --foreground=7 --align="center" "$boxA")
sideB=$(gum style --width="$widthb" --border=double --border-foreground=7 --padding="1 2" --margin="0 1"--foreground=7 --align="center" "$boxB")
gum join "$sideA" "$sideB" --horizontal
}

#END GUM BOX VARIABLES

#START VARIABLE DEFINITIONS
export libDir=/opt/practical-wayland/lib
export modDir=/opt/practical-wayland/scripts/modules
export stubDir=/opt/practical-wayland/scripts/stubs
export optionsDir=/opt/practical-wayland/scripts/options
export tmpDir=/opt/practical-wayland/tmp
#END VARIABLE DEFINITIONS


#START CMD FAIL FUNCTION
cmdFail () {
if [ $exitStat -ne 0 ]; then
    style=lose
    prt_info    
    gum style "$errMsg"
    sleep 1
    echo
    style=msg
    prt_info
    gum style "This script will now exit"
    sleep 1
    clear
    exit 1
else
    style=win
    prt_info
    gum style "$successMsg"
    sleep 0.5
fi
# These variables need to be set directly after a process ends to capture the $? value 
# and output a message, cmdFail runs function.
# exitStat=$?
# errMsg="ERROR MESSAGE"
# successMsg="SUCCESS MESSAGE"
# cmdFail
}
#END CMD FAIL FUNCTION

#START GUM VARIABLES
#GUM CONFIRM VARIABLES
export GUM_CONFIRM_PROMPT_FOREGROUND=7
export GUM_CONFIRM_SELECTED_FOREGROUND=0
export GUM_CONFIRM_SELECTED_BACKGROUND=2
export GUM_CONFIRM_UNSELECTED_FOREGROUND=0
export GUM_CONFIRM_UNSELECTED_BACKGROUND=3
export GUM_CONFIRM_PADDING="2 0"
export GUM_CONFIRM_SHOW_HELP=false
#END GUM CONFIRM VARIABLES

#START GUM CHOOSE VARIABLES
export GUM_CHOOSE_PADDING="1 0"
export GUM_CHOOSE_HEIGHT=10
export GUM_CHOOSE_CURSOR=" > "
export GUM_CHOOSE_CURSOR_PREFIX="[-] "
export GUM_CHOOSE_SELECTED_PREFIX="[x] "
export GUM_CHOOSE_UNSELECTED_PREFIX="[ ] "
export GUM_CHOOSE_CURSOR_FOREGROUND=11
export GUM_CHOOSE_HEADER_FOREGROUND=3
export GUM_CHOOSE_ITEM_FOREGROUND=3
export GUM_CHOOSE_SELECTED_FOREGROUND=11
#END GUM CHOOSE VARIABLES

#START GUM SPIN VARIABLES
export GUM_SPIN_TITLE="Processing..."
export GUM_SPIN_SPINNER_FOREGROUND=3
export GUM_SPIN_TITLE_FOREGROUND=7
export GUM_SPIN_SPINNER="dot"
export GUM_SPIN_PADDING="1 0"
#END GUM SPIN VARIABLES

#START GUM STYLE FUNCTION
prtInfo (){
case $style in
    info) export FOREGROUND=7;;
    msg) export FOREGROUND=11;;
    lose) export FOREGROUND=1;;
    win) export FOREGROUND=2;;
    *) export FOREGROUND=7;;
esac
}
#END GUM STYLE FUNCTION

#START BANNER FUNCTION
# $MenuTitle & $MenuSubTitle are set in the scripts called by this menu
banner () {
gum style --foreground=11 --border-foreground=3 --border="double" --align=center --width="$halfBoxWidth" --margin="1 $halfBoxMargin" --padding="0 0" "$MenuTitle" "$MenuSubTitle"
}
#END BANNER FUNCTION

#START MAIN MENU FUNCTION
mainMenu () {
clear
MenuTitle="Practical Wayland Tools"
MenuSubTitle="Main Menu"
banner
style=msg
prtInfo
gum style "Welcome To Practical Wayland Tools"
echo
mainMenuOutput="$(gum choose --limit=1 --header="Please Make A Selection:" "Install Desktop Environment" "Update System" "Install Applications" "Exit")"
case $mainMenuOutput in
    "Install Desktop Environment")
        deMenu
    ;;
    "Update System")
        clear
        MenuTitle="Practical Wayland Tools"
        MenuSubTitle="Update System Menu"
        banner
        style=msg
        prtInfo
        gum style "Not Yet Implemented"
        gum style "Returning to Main Menu"
        sleep 1
        clear
        mainMenu
    ;;
    "Install Applications")
        clear
        MenuTitle="Practical Wayland Tools"
        MenuSubTitle="Install Applications Menu"
        banner
        style=msg
        prtInfo
        gum style "Not Yet Implemented"
        gum style "Returning to Main Menu"
        sleep 1
        clear
        mainMenu
    ;;
    "Exit")
        clear
        exit 0
    ;;
    *)      
        clear
        style=warn
        prtInfo
        gum style "Invalid Selection - Please try again"
        sleep 1
        clear
        MenuTitle="Practical Wayland Tools"
        MenuSubTitle="Main Menu"
        banner
        gum style "Press [ENTER] to continue..."
        read
        mainMenu
    ;;
esac
}
#END MAIN MENU FUNCTION

#START DEMENUOPTION FUNCTION
deMenu () {
clear
MenuTitle="Practical Wayland Tools"
MenuSubTitle="Desktop Environment Menu"
banner
echo
deMenuOutput=$(gum choose --limit=1 --header="Please Select A Desktop Environment to Install:" "Noctalia" "Niri w/ Ashell" "LXQt w/ Niri" "Back")
case $deMenuOutput in
    "Noctalia")
        $optionsDir/2609d8b228.sh
    ;;
    "Niri w/ Ashell")
        clear
        MenuTitle="Practical Wayland Tools"
        MenuSubTitle="Desktop Environment Menu"
        banner
        style=msg
        prtInfo
        gum style "Not Yet Implemented"
        gum style "Returning to Main Menu"
        sleep 2
        deMenu
    ;;
    "LXQt w/ Niri")
        clear
        MenuTitle="Practical Wayland Tools"
        MenuSubTitle="Desktop Environment Menu"
        banner
        style=msg
        prtInfo
        gum style "Not Yet Implemented"
        gum style "Returning to Main Menu"
        sleep 2
        deMenu
    ;;
    "Back")
        clear
        mainMenu
    ;;
    *)
        clear
        style=warn
        prtInfo
        gum style "Invalid Selection - Please try again"
        sleep 1
        clear
        deMenu
    ;;
esac
}
#END DEMENUOPTION FUNCTION

#START MAIN MENU EXECUTION
osType
sleep 0.75
colMath
mainMenu
#END MAIN MENU EXECUTION
