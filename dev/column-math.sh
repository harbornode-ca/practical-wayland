#!/bin/bash
#2609ac1dd9.sh - Math for boxes based on terminal columns. As well as displays listed colours

#Number of columns is provided by $COLUMNS
#Rows(height) is not required as the screen scrolls up as needed.

#Calculate widths and centering. Take into consideration leading and trailing column for borders using gum.
#Sizes: 3/4, 1/2, 1/3, 1/5 with centering margins

fastfetch | grep OS | cut -d ":" -f 2 | cut -c2-
declare -i cols third fifth half qtr qqqtr twoBx
if (( $COLUMNS % 2 == 0 )); then
    let cols=$COLUMNS
else
    let cols=$COLUMNS-1
fi
let cols=$COLUMNS-3
let qtr=cols/4
let qtrMargin=qtr*2 
let half=qtr*2
let halfMargin=qtr
let qqqtr=qtr*3
let qqqtrMargin=qtr/2
let third=cols/3
let thirdMargin=third/1
echo "Columns: $cols"
echo "Fifth:   ${fifth} Margin: ${fifthMargin}"
echo "Third:   ${third} Margin: ${thirdMargin}"
echo "Half:    ${half} Margin: ${halfMargin}"
echo "qqqtr:   ${qqqtr} Margin: ${qqqtrMargin}"

gum style --width="$half" --border=double --border-foreground=7 --padding="1 2" --margin="0 $halfMargin" --foreground=7 --align="center" "Box Text"

#Wide Boxes (Full Width)
#Wide Boxes (3/4 Width)
#Wide Boxes (2/3 Width)
#Wide Boxes (1/2 Width)
#Wide Boxes (1/3 Width)

let cols=$COLUMNS-2
let twoBx=(cols-8)/2

gum style --foreground=172 --border-foreground=172 --border=double --align=center --width="$fifth" --margin="2 $fifthMargin" --padding="1 0" 'Practical Wayland'
gum style --foreground=172 --border-foreground=172 --border=double --align=center --width="$third" --margin="2 $thirdMargin" --padding="1 0" 'Practical Wayland'
gum style --foreground=172 --border-foreground=172 --border=double --align=center --width="$half" --margin="2 $halfMargin" --padding="1 0" 'Practical Wayland'
gum style --foreground=172 --border-foreground=172 --border=double --align=center --width="$qqqtr" --margin="2 $qqqtrMargin" --padding="1 0" 'Practical Wayland'
gum style --foreground=172 --border-foreground=172 --border=double --align=center --width="$cols" --margin="2 0" --padding="1 0" 'Practical Wayland'

for i in 28 34 46 88 124 160 172 208 166 202 184 220 30 66 29 65 137 180 179; do
gum style --width="$half" --border=double --border-foreground=$i --padding="1 2" --foreground=$i "Box Text $i"
done

LEFT=$(gum style --width="$twoBx" --border=double --border-foreground=7 --padding="1 2" --margin="0 2" --foreground=7 --align="center" "Box Text")
RIGHT=$(gum style --width="$twoBx" --border=double --border-foreground=7 --padding="1 2" --margin="0 2"--foreground=7 --align="center" "Box Text")
gum join "$LEFT" "$RIGHT" --horizontal

#2 Columns through % calculations
declare -i colsa colsb widtha widthb side
let colsa=side
let colsb=100-side
let widtha=colsa-4
let widthb=colsb-4

showMenu () {
sideA=$(gum style --width="$widtha" --border=double --border-foreground=7 --padding="1 2" --margin="0 1" --foreground=7 --align="center" "$boxA")
sideB=$(gum style --width="$widthb" --border=double --border-foreground=7 --padding="1 2" --margin="0 1"--foreground=7 --align="center" "$boxB")
gum join "$sideA" "$sideB" --horizontal
}

#28 dull green
#34 green-green
#46 bright green
#88 dull red
#124 red
#160 bright red
#172 orange
#208 bright orange
#166 deep orange
#202 bright deep orange
#184 yellow
#220 bright-yellow
#66 medium green
#102 medium-ish green
