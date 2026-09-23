#!/bin/bash
#main.sh - Main menu

#START OSTYPE FUNCTION
#Uses fastfetch to get the OS type and prints it to the terminal.
#This function is only meant to be used once at the start of the script to pull in terminal info.
osType () {
	fastfetch | grep OS | cut -d ":" -f 2 | cut -c2-
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
export half
export halfMargin
export third
export thirdMargin
export qqqtr
export qqqtrMargin
export fifth
export fifthMargin
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
export GUM_CHOOSE_CURSOR_FOREGROUND=7
export GUM_CHOOSE_HEADER_FOREGROUND=3
export GUM_CHOOSE_ITEM_FOREGROUND=3
export GUM_CHOOSE_SELECTED_FOREGROUND=10
#END GUM CHOOSE VARIABLES

#START GUM SPIN VARIABLES
export GUM_SPIN_TITLE="Processing..."
export GUM_SPIN_SPINNER_FOREGROUND=3
export GUM_SPIN_TITLE_FOREGROUND=11
export GUM_SPIN_SPINNER="dot"
export GUM_SPIN_PADDING="1 0"
#END GUM SPIN VARIABLES

#START GUM STYLE FUNCTION
prt_info (){
case $style in
    info) export FOREGROUND=7; export BOLD=true;;
    msg) export FOREGROUND=3;;
    lose) export FOREGROUND=1; export BOLD=true;;
    win) export FOREGROUND=2; export BOLD=true;;
    *) export FOREGROUND=7; export BOLD=true;;
esac
}
#END GUM STYLE FUNCTION

#START BANNER FUNCTION
# $MenuTitle & $MenuSubTitle are set in the scripts called by this menu
gum style --foreground=172 --border-foreground=172 --border=double --align=center --width="$half" --margin="1 $halfMargin" --padding="1 2" '$MenuTitle' '$MenuSubTitle'
#START MAIN MENU

osType
sleep 0.75
colMath


