#!/bin/bash
#26094d3b9b.sh - Test Colours

# Terminal 256 Colour Palette
#Green: 40/46
#Red: 1/124
#Orange: 172/202
#Yellow: 3/220
#Grey: 102
#Salmon: 131
#Beigish: 137
#Tan: 180
#Hay: 215
#Maroonish: 131

#for i in 40 46 1 124 172 202 3 220 102 131 137 180 215 131; do
#	gum style --foreground="$i" --border=double --border-foreground="$i" --padding="0 1" "Colour #$i"
#done

#for txt in 102 131 137 180 215 131; do
#    for bdr in 102 131 137 180 215 131; do
#		gum style --foreground="$txt" --border="double" --border-foreground="$bdr" "txt $txt bdr $bdr"
#	sleep 0.25
#    done
#done

for txt in 40 46 1 124 172 202 3 220 102 131 137 180 215 131; do
    for bdr in 40 46 1 124 172 202 3 220 102 131 137 180 215 131; do
		gum style --foreground="$txt" --border="double" --border-foreground="$bdr" "txt $txt bdr $bdr"
	sleep 0.25
    done
done