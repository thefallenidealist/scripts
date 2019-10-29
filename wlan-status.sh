#!/bin/sh
# Created 181227 for use as tint2 executor
INTERFACE="wlan0"

STATE=$(ifconfig $INTERFACE | grep status | awk '{print $2}')
AP=$(ifconfig $INTERFACE | grep ssid  | awk '{print $2}')
IP=$(ifconfig $INTERFACE | grep inet | awk '{print $2}')

if [ $STATE == "associated" ]; then
	ASSOCIATED='+'
else
	ASSOCIATED='-'
fi
# echo State: $STATE $ASSOCIATED
# echo AP: $AP
# echo IP: $IP

echo "($ASSOCIATED) $AP"
echo "$IP"
