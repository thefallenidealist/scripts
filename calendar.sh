#!/bin/sh
# Created 191103
# This script will be executed on left click on calendar executor in tint2

CMD_CALENDAR="LC_ALL=en_GB.UTF-8 zenity --calendar --text \"\""

# if it already run then close it
PID=$(wmctrl -lxp | grep zenity.Zenity | grep -i calendar | awk '{print $3}')

if [ -n "$PID" ] ; then
	kill $PID
else
	eval $CMD_CALENDAR
fi
