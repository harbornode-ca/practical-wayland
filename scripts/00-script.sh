#!/bin/bash
#
CFG_DIR=/opt/kevrevrun
STATUS=/opt/kevrevrun/loop.status
LOOP=$(cat $STATUS)
RUN=$(cat $CFG_DIR/run.cmd &)
$RUN
while [ $LOOP = 0 ]
do
	sleep 1
	LOOP=$(cat $STATUS)
done
exit 0
