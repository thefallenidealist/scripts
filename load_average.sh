#!/bin/sh
# Created 181209
# Shows load average for last minute
# Tested on FreeBSD 12.0-RC3

# echo $(uptime | cut -d ' ' -f 12)
# echo $(uptime | cut -d ' ' -f 12 | cut -d ',' -f 1)
# LOAD=$(uptime | cut -d ' ' -f 12)
# printf "%.1f" $LOAD

echo $(sysctl -n vm.loadavg | awk '{print $2}')
