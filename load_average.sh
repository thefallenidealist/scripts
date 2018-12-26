#!/bin/sh
# Created 181209
# Shows load average for last minute
# Tested on FreeBSD 12.0-RC3

echo $(uptime | cut -d ' ' -f 10)
