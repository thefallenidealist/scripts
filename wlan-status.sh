#!/bin/sh
# Created 181227 for use as tint2 executor
INTERFACE="wlan0"

# STATE=$(ifconfig $INTERFACE | grep status | awk '{print $2}')
# AP=$(ifconfig $INTERFACE | grep ssid  | awk '{print $2}')
# IP=$(ifconfig $INTERFACE | grep inet | awk '{print $2}')

# if [ $STATE == "associated" ]; then
# 	ASSOCIATED='+'
# else
# 	ASSOCIATED='-'
# fi
# # echo State: $STATE $ASSOCIATED
# # echo AP: $AP
# # echo IP: $IP

# echo "($ASSOCIATED) $AP"
# echo "$IP"

# 191109 all that in one line:
# printed output, 1st line:
# - (+) if associated, (-) if not (TODO exact word)
# - SSID of the network
# printed output, 2rd line:
# - IP address
ifconfig $INTERFACE | \grep -wE "status|ssid|inet" | awk '{print $2}' | tr '\n' ' ' | sed 's/associated/(+)/;s/not/(-)/' | awk '{print $3 " " $2 "\n" $1}'
