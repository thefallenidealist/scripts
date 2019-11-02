#!/bin/sh
# Created 191030

INTERNAL_MONITOR="LVDS-1"
EXTERNAL_MONITOR="DP-3"
# switch sound to external DisplayPort interface?
SWITCH_SOUND=y

CMD_EXTERNAL_MONITOR_CONNECTED="xrandr --output $EXTERNAL_MONITOR --right-of $INTERNAL_MONITOR --auto --primary"
CMD_EXTERNAL_MONITOR_DISCONNECTED="xrandr --output $EXTERNAL_MONITOR --off --auto"
CMD_EXTERNAL_MONITOR_DISCONNECTED="xrandr --output $EXTERNAL_MONITOR --off --output $INTERNAL_MONITOR --primary"
CMD_SOUND="doas sysctl hw.snd.default_unit="
CMD_EXTERNAL_MONITOR_PIVOT="xrandr --output $EXTERNAL_MONITOR --rotate left"	# TODO 191030


NCONNECTED=$(xrandr -q | \grep -w connected | wc -l)
# NCONNECTED=1
# echo "DBG: Number of connected monitors: $NCONNECTED"

if [ "$NCONNECTED" -eq "1" ]; then
	echo "Only one monitor connected"
	eval $CMD_EXTERNAL_MONITOR_DISCONNECTED
elif [ "$NCONNECTED" -gt "1" ]; then
	echo "More than one monitor connected, executing: $CMD_EXTERNAL_MONITOR_CONNECTED"
	eval $CMD_EXTERNAL_MONITOR_CONNECTED
else
	echo "Probably error"
fi

# if [ "$SWITCH_SOUND" == "y" ] ; then
# 	SOUND_INTERFACE="0"

# 	echo "DBG: switching sound to: $SOUND_INTERFACE"
# 	$CMD_SOUND $SOUND_INTERFACE
# 	# TODO 191030: 
# fi

