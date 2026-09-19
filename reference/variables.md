# Variables & Status Files

## Directories

1. /opt/kevrevrun
	- mainDir
3. /opt/kevrevrun/status
	- statusDir
4. /opt/kevrevrun/setup
	- cfgDir
5. /opt/kevrevrun/scripts
	- scriptDir
6. /opt/kevrevrun/pkg_lists
	- aptDir
7. /opt/kevrevrun/tmp
	- tmpDir
8. /opt/kevrevrun/logs
	- logDir

# Status Files

1. id.usr
	- in mainDir
	- Created in initial.sh
	- Var: usrId
2. name.usr
	- in mainDir
	- Created in initial.sh
	- Var: usrName
3. loop.status
	- in statusDir
	- Created in initial.sh
	- Var: loopStat
4. install.dir
	- in statusDir
	- Created in initial.sh
	- Var: setupDir
5. setup.stage
	- in statusDir
	- Created in initial.sh
	- Var: nowStep

# Temporary Files

*No temporary files used in this script*

# Variables

1. mainDir=/opt/kevrevrun
2. statusDir=/opt/kevrevrun/status
3. scriptDir=/opt/kevrevrun/scripts
4. cfgDir=/opt/kevrevrun/cfg
5. usrId=$(cat $CFG_DIR/id.usr)
6. usrName=$(cat $CFG_DIR/name.usr)
7. setupDir=$(cat $CFG_DIR/install.dir)
8. loopStat=$(cat $CFG_DIR/loop.status)
9. nowStep=$(cat $CFG_DIR/setup.stage)
