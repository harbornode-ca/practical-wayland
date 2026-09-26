

4,if [ $rustStatus -eq 0 ]; then scripts/stubs/2609fd1bba.sh; fi
5,if [ $rustStatus -eq 1 ]; then scripts/stubs/2609ebcd21.sh; fi
6,gum style "Checking for existing installation of Just"
7,if [ -f $HOME/.cargo /bin/just ]; then gum sytle "Just already installed for user $whoami"; sleep 1.5; export justStatus=1; else gum style "Rust not installed for user $whoami"; sleep 1.5; export justStatus=0; fi;
8,if [ $justStatus -eq 0 ]; then gum spin --title="Installing Just for user $whoami" $stubDir/2609b4dcf6.sh; fi
9,if [ $justStatus -eq 1 ]; then gum spin --title="Updating Just for user $whoami" $stubDir/2609b4dcf6.sh; fi
10,gum style "Checking for Just installation in /usr/sbin"; sleep 1.5;
11,if [ -f /usr/bin/just ]; then style=msg; gum style "Just is already installed in /usr/sbin"; rootJust=1; else gum style "Just not install in /usr/sbin"; sleep 1.5; rootJust=0; fi
12,if [ $rootJust -eq 0 ]; then gum style "Copying just from $HOME/.cargo/bin/ to /usr/bin"; sleep 1.5; sudo cp -f $HOME/.cargo/bin/just /usr/sbin; fi
13,if [ $rootJust -eq 1 ]; then gum style "Confirming /usr/sbin/just is up to date"; sleep 1.5; sudo cp -f $HOME/.cargo/bin/just /usr/sbin; fi
14,gum style "Installation of Rust and Just is complete"; sleep 1.5;




runChecklist() {
# Creates an array of steps from the checklist file
    declare -i stepNum step status inProgress
    let stepNum=0
    while [[ $stepNum -lt $chkListTotal ]]; do
    step=$(echo "${chkList[$stepNum]}" | cut -d ',' -f 1)
    status=$(echo "${chkList[$stepNum]}" | cut -d ',' -f 2)
    action=$(echo "${chkList[$stepNum]}" | cut -d ',' -f 3)
    inProgress=$(echo "${chkList[$stepNum]}" | cut -d ',' -f 4)
    echo "runChecklist"
    echo "step = $step"
    echo "status = $status"
    echo "action = $action"
    echo "inProgress = $inProgress"
    sleep 1
        if [[ $status -eq 0 ]]; then
            if [[ $inProgress -eq 0 ]]; then
                echo "Running step: $stepNum"
                chklist[$stepNum]=$step,$status,$action,1
                callDisplay
                sleep 1
                chkList[$stepNum]=$step,1,$action,0
            fi
        fi
        ((stepNum++))      
    done
}
#END UPDATE CHECKLIST FUNCTION
runChecklist

0_step() {
    callDisplay
    gum style "Installing/Updating Rust and Cargo"
    sleep 1.5
    callDisplay
    $modDir/2609b283df.sh
}
1_step() {
    callDisplay
    gum style "Installing/Updating Just"
    sleep 1.5
    $modDir/2906d9f593.sh
}
2_step() {
    callDisplay
    gum style "Adding Noctalia Repository"
    sleep 1.5
}
3_step() {
    callDisplay
    gum style "Installing Noctalia Packages"
    sleep 1.5
}  
4_step() {
    callDisplay
    gum style "Installing NIRI Build Dependencies"
    sleep 1.5
}
5_step() {
    callDisplay
    gum style "Downloading NIRI Compositor Source"
    sleep 1.5
}
6_step() {
    callDisplay
    gum style "Compiling NIRI Compositor"
    sleep 1.5
}
7_step() {
    callDisplay
    gum style "Installing NIRI Compositor"
    sleep 1.5
}
8_step() {
    callDisplay
    gum style "Installing NIRI Runtime Packages"
    sleep 1.5
}
9_step() {
    callDisplay
    gum style "Setting Default Configuration"
    sleep 1.5
}

while read -r line; do
    echo "line: $line"
    export chkList+=("$line")
done < "$libDir/noctalia.steps"
echo "Created CHECKLIST"
sleep 2
declare -i chkListTotal
export chkListTotal=${#chkList[@]}
echo "chkListTotal = $chkListTotal"
sleep 2
runChecklist