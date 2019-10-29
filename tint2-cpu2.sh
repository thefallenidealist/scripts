#!/bin/sh
# Created 181209
# created to use in tint2

BASEDIR=$(dirname "$0")
TEMPERATURE=$(sysctl -n hw.acpi.thermal.tz0.temperature | cut -d '.' -f 1)
# LOAD_AVG=$(uptime | cut -d ' ' -f 10 | cut -d ',' -f 1)
LOAD_AVG=$($BASEDIR/load_average.sh)

printf "%s°C\nA:%s" $TEMPERATURE $LOAD_AVG
