#!/bin/bash
#
cfgDir=/opt/kevrevrun
statusFile=/opt/kevrevrun/loop.status
loopStatus=$(cat $statusFile)
runCmd=$(cat $cfgDir/run.cmd)

while [ $loopStatus = 0 ]
do
	$runCmd
	sleep 1
	loopStatus=$(cat $statusFile)
done
exit 0
