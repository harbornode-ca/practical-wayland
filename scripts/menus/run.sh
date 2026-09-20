#!/bin/bash
cmdString=$(cat /opt/kevrevrun/status/cmd.string)
eval $cmdString
exitStat=$?
if [ "$exitStat" = "0" ]; then
    echo "Command completed successfully"
    exit 0
else
    echo $exitStat
    echo "Command failed"
    exit 1
fi