#!/bin/sh
# Created 200419
# quick script for changing internal/external monitor (no hardware event for monitor connect/disconnect on my laptop - SeaBIOS fault?)
# can be executed with xbindkeys

INTERNAL_MONITOR="LVDS-1"
EXTERNAL_MONITOR="HDMI-1"

INTERNAL_MONITOR="LVDS1"
EXTERNAL_MONITOR="DP1"
EXTERNAL_MONITOR="HDMI1"
# 200529 dual external monitors on dock:
EXTERNAL_MONITORs="DP2"
EXTERNAL_MONITORm="DP3"

case $1 in
	i)
		# echo internal only
		# xrandr --output $INTERNAL_MONITOR --auto --output $EXTERNAL_MONITOR --off
		xrandr --output $EXTERNAL_MONITORm --off --output $EXTERNAL_MONITORs --off --output $INTERNAL_MONITOR --auto
		killall tint2; tint2&
		;;
	e)
		# echo external only
		xrandr
		# xrandr --output $INTERNAL_MONITOR --off --output $EXTERNAL_MONITOR --auto --same-as $INTERNAL_MONITOR
		xrandr --output $EXTERNAL_MONITORm --auto --primary --right-of $EXTERNAL_MONITORs --output $EXTERNAL_MONITORs --auto --output $INTERNAL_MONITOR --off
		killall tint2 ; tint2 -c ~/.config/tint2/tint2-master.rc& ; tint2 -c ~/.config/tint2/tint2-slave.rc&
		;;
	# s)
	# 	# echo same
	# 	xrandr --output $INTERNAL_MONITOR --auto --output $EXTERNAL_MONITOR --auto --same-as $INTERNAL_MONITOR
	# 	;;
	*)
		echo error, \$1 = $1
		;;
esac
