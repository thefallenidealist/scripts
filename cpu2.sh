#!/bin/sh
# Created 181202
# Display current CPU frequency & temperature
# created to use in tint2

FREQ=$(sysctl -n dev.cpu.0.freq)
TEMPERATURE=$(sysctl -n hw.acpi.thermal.tz0.temperature | cut -d '.' -f 1)
printf "CPU $TEMPERATURE C\n$FREQ MHz"
