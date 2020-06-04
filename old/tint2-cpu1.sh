#!/bin/sh
# Created 181202
# Display current CPU frequency & temperature
# created to use in tint2

# FREQ=$(sysctl -n dev.cpu.0.freq)
# TEMPERATURE=$(sysctl -n hw.acpi.thermal.tz0.temperature | cut -d '.' -f 1)

BASEDIR=$(dirname "$0")

CPU_LOAD=$($BASEDIR/cpu_usage.sh)
CPU_FREQ=$($BASEDIR/cpu_freq.sh)

# printf "CPU $TEMPERATURE C\n$FREQ MHz"
# printf "CPU $CPU_LOAD\n$CPU_FREQ"
printf "CPU %s\n%s" "$CPU_LOAD" "$CPU_FREQ"
