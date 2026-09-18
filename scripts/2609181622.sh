#!/bin/bash
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
echo "Adding bitmap font support for Glyph support in TUI and GUIs"
sleep 1
echo "Checking for fontconfig file $file"
sleep 0.5
while IFS= read -r file; do
    if [ -f "$file" ]; then
        echo "Fontconfig File $file found"
        sleep 0.5
        echo "Removing fontconfig file $file"
        sleep 0.5
        rm -vf "$file"
        exitStat=$?
        errMsg="Failed to remove fontconfig file $file"
        successMsg="Fontconfig File $file removed"
        cmdFail
    fi
done < cfg/installerInfo/fontconfig-rm.list
echo
echo "Adding bitmap fontconfig file to the font configuration directory"
while IFS="," read -r src dest; do
    echo "Creating hardlink from $src to $dest"
    sudo ln -vf "$src" "$dest"
    exitStat=$?
    errMsg="Failed to create hardlink from $src to $dest"
    successMsg="Hardlink from $src to $dest created"
    cmdFail
done < cfg/installerInfo/fontconfig-add.csv
echo 
echo "Updating font cache"
sudo fc-cache -fv
exitStat=$?
errMsg="Failed to update font cache"
successMsg="Font cache updated"
cmdFail
