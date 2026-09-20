#!/bin/bash
for i in {0..7}; do
echo "Colour=$i"
gum style --foreground=$i "Regular Text"
gum style --foreground=$i --bold "Bold Text"
echo
echo
sleep 0.5
done
#START GUM VARIABLES

#START GUM CONFIRM VARIABLES
export GUM_CONFIRM_PROMPT_FOREGROUND=7
export GUM_CONFIRM_SELECTED_FOREGROUND=0
export GUM_CONFIRM_SELECTED_BACKGROUND=3
export GUM_CONFIRM_UNSELECTED_FOREGROUND=0
export GUM_CONFIRM_UNSELECTED_BACKGROUND=2
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

#END GUM VARIABLES
prt_info (){
case $style in
    info) export FOREGROUND=7; export BOLD=true;;
    msg) export FOREGROUND=3;;
    lose) export FOREGROUND=1; export BOLD=true;;
    win) export FOREGROUND=2; export BOLD=true;;
    *) export FOREGROUND=7; export BOLD=true;;
esac
}
#How to use above case statement:
#Change the variable "style" to one of the options above.
#Then run the script.

#Info Message Example
style=info
prt_info
gum style "Info Message"
sleep 1 
#General Message Example
style=msg
prt_info    
gum style "General Message"
sleep 1
#Failure Message Example
style=lose
prt_info
gum style "Failure Message"
sleep 1
#Success Message Example
style=win
prt_info
gum style "Success Message"
sleep 1
gum confirm "Confirm Message"

gum choose 1 2 3 4 5 6 7 8 9 10 --limit 5
