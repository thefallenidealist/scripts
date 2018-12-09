#!/bin/sh
# Created 181110

# Print Usage of CPU0 and CPU1
# convert float to integer (at that the reason of redirecting stderr)
printf "CPU0: %3d%% CPU1: %3d%%\n" $(sysctl -n dev.cpu.0.cx_usage | cut -d '%' -f 1) $(sysctl -n dev.cpu.1.cx_usage | cut -d '%' -f 1) 2>/dev/null
printf "CPU2: %3d%% CPU3: %3d%%\n" $(sysctl -n dev.cpu.2.cx_usage | cut -d '%' -f 1) $(sysctl -n dev.cpu.3.cx_usage | cut -d '%' -f 1) 2>/dev/null
# TODO 181110: one sysctl instead of 2/4
