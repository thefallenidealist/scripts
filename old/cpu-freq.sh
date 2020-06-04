#!/bin/sh
# Created 181110
# Display current CPU frequency

# available frequencies:
# sysctl dev.cpu.0.freq_levels
#  dev.cpu.0.freq_levels: 2901/35000 2900/35000 2400/27295 2000/21703 1600/16527 1200/11795
#                         ^ turbo    ^ 2.9 GHz       ^ 27.8W    ^ 21W

FREQ=$(sysctl -n dev.cpu.0.freq)
# FREQ_G=$(bc -e "scale=2; $FREQ / 1000" -e quit)	# will miss "Turbo mode" (eg 2901 MHz)
echo $FREQ MHz
# printf "%.1f GHz" $FREQ_G
