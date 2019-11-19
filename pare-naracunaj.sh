#!/bin/sh
# Created 160201
# Updated 191119

YEAR=$(/bin/date +%y)
MONTH=$(/bin/date +"%m")

DIR="$HOME/docs-privat"
FILE="$DIR/pare$YEAR$MONTH"
FILE_KEYWORDS="$DIR/pare-keywords"

if [ "$#" -gt 1 ]; then
	FILE=$1
fi

echo File: $FILE
echo "----------------------------------------"
while read LINE
do
	TMP=$(grep -E -i $LINE $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc)
	case $TMP in
		(*[!0-9]*|'')	# if not a number
			;;
		(*)
			POTROSENO=$(($POTROSENO+$TMP))
			;;
	esac

	case "$LINE" in
		*\|*)
			# If line contains '|' show only first member:
			echo $(echo $LINE | cut -d '|' -f 1) $TMP
			;;
		*)
			echo $LINE: $TMP
			;;
	esac
done < $FILE_KEYWORDS

UKUPNO=`cat $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
NESVRSTANO=$(($UKUPNO-$POTROSENO))

echo "----------------------------------------"
echo "Potroseno:  $POTROSENO"
echo "Nesvrstano: $NESVRSTANO"
echo "Ukupno:     $UKUPNO"
