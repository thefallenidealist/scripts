#!/bin/sh
# Created 181110
# INFO 181209: Show one percetange for all CPUs [0 - 100%]

NCPU=$(sysctl -n hw.ncpu)
# expr needs spaces around "*" signal
PERCENTAGE=$(expr $NCPU \* 100)

# process 11 is "[idle]" kernel thread
# ps u 11 | awk 'NR==2 {print 400 - $3}'
IDLE=$(ps u 11 | awk 'NR==2 {print $3}')
USAGE=$(bc -e "scale=2; ($NCPU * 100 - $IDLE) / $NCPU " -e quit)

printf "%.1f %%\n" $USAGE
