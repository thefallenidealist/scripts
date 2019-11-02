#!/bin/sh
# Created 191102
# for use with tint2 panel
# use -f to show full report
LOCATION=Osijek

if [ $# -gt 0 ] ; then
	if [ $1 == "-f" ] ; then
		# show full weather report
		# F - do not show the "Follow" line
		curl "wttr.in/$LOCATION?F"
	fi
else
	# show onelinear to use in tint2 executor
	# curl -s "wttr.in/$LOCATION?format=3" | cut -d ':' -f 2 -
	# condition, condition text, space (+), temperature,
	curl wttr.in/$LOCATION\?format="%c%C+%t"
	# wind, humidity
	curl wttr.in/$LOCATION\?format="%w++%h"
fi
