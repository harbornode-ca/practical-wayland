#!/bin/bash
#2609053bd8 - Test Array Logic for step-by-step execution
baseDir="/home/kevin/practical-wayland"
libDir="$baseDir/lib"
declare -a chkList
declare -a chkStatus

readList () {
while read -r line; do
    chkList+=("$line")
done < "$libDir/noctalia.steps"
}

readList
chkTotal="${#chkList[@]}"
count=0
while [ $count -lt $chkTotal ]; do
    IFS=',' read -r complete action inProgress <<< "${chkList[$count]}"
    if [ "$complete" -eq 0 ]; then
        if [ "$inProgress" -eq 1 ]; then
            chkStatus["$count"]="[>] $action"
        else
            chkStatus["$count"]="[ ] $action"
        fi
    else
        chkStatus["$count"]="[x] $action"
    fi
    echo "List: ${chkList[$count]}"
    echo "Status: ${chkStatus[$count]}"
    echo "count: $count"
    echo "complete: $complete"
    echo "action: $action"
    echo "inProgress: $inProgress"
    sleep 1
    ((count++))
done 