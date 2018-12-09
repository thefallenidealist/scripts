#!/bin/sh
# https://gitlab.com/o9000/tint2/wikis/FAQ
# XXX 181110: doesn't work with CWM
if wmctrl -m | grep "mode: ON"; then
	exec wmctrl -k off
else
	exec wmctrl -k on
fi
