#!/bin/sh
# Created 140808
# Updated 181110
# display current CPU temperature

# tr is used because temperature would be "41.1C -> 42.1C -> 43.1C"
TEMPERATURE=$(sysctl -n hw.acpi.thermal.tz0.temperature | cut -d '.' -f 1)
# echo $TEMPERATURE°C

# Or find the highest of:
# sysctl -n dev.cpu.0.temperature
# sysctl -n dev.cpu.1.temperature
# sysctl -n dev.cpu.2.temperature
# sysctl -n dev.cpu.3.temperature
TEMPERATURE=$(sysctl dev.cpu. | grep temperature | cut -d ":" -f 2 | sed 's/^ //g' | sed 's/.0C$//g' | sort -nr | head -1)
echo $TEMPERATURE°C
