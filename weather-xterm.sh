#!/bin/sh
# Created 191102
# This script will be executed on left click on weather executor in tint2

# if it already run then close it
PID=$(wmctrl -lxp | \grep -i yterm.YTerm | awk '{print $3}')

if [ -n "$PID" ] ; then
	kill $PID
else
	# - fake X11 name and class so it can be overriden within window manager to exclude standard decoration used for xterm
	# - little less dark background to distinguish it from standard xterms bellow
	# - size hand craftet to be just enough for output of weather.sh -f command
	xterm\
		-class "YTerm" -name yterm\
		-bg gray10 -fg gray -fn "xft:Literation Mono Powerline:pixelsize=16"\
		-geometry 125x39-0+36 \
		-e " ~/scripts/weather.sh -f ; read"
fi
exit

# how to improve it:
# any key to exit: use Esc/a/s/d/f/any key to terminate window
# - xterm -hold: use WM tools (Alt+F4) to terminate it
# - "; read": press enter to exit, little easier than Alt-F4
