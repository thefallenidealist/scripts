#!/bin/sh
# created 181227
# stripped down version of https://raw.githubusercontent.com/ocochard/myscripts/master/FreeBSD/freebsd-memory.sh

pagesize=`sysctl -n hw.pagesize`
mem_inactive=$(echo "$(sysctl -n vm.stats.vm.v_inactive_count) * $pagesize" | bc)
mem_cache=$(   echo "$(sysctl -n vm.stats.vm.v_cache_count)    * $pagesize" | bc)
mem_free=$(    echo "$(sysctl -n vm.stats.vm.v_free_count)     * $pagesize" | bc)
mem_total=$(sysctl -n hw.realmem)
mem_avail=$(echo "$mem_inactive + $mem_cache + $mem_free" | bc )

free_logically=$(echo "$mem_avail * 100 / $mem_total" | bc)
free_fully=$(    echo "$mem_free  * 100 / $mem_total" | bc)
free_logically_mb=$(echo "$mem_avail / 1024 / 1024" | bc)
free_fully_mb=$(    echo "$mem_free  / 1024 / 1024" | bc )

# printf "RAM: %2d%% %4d%%\n" $free_fully $free_logically
# printf "%7dM %4dM\n" $free_fully_mb $free_logically_mb
# for tint2:
printf "RAM: %2d%% %6d%%\n" $free_fully $free_logically
printf "%7dM %5dM\n" $free_fully_mb $free_logically_mb
