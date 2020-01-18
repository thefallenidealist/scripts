#!/bin/sh
# Created 160201
# Updated 191119

YEAR=$(/bin/date +%y)
MONTH=$(/bin/date +"%m")

DIR="$HOME/docs-privat"
FILE="$DIR/pare$YEAR$MONTH"
FILE_KEYWORDS="$DIR/pare-keywords"

if [ "$#" -gt 0 ]; then
	FILE=$1
fi

echo File: $FILE
echo "----------------------------------------"
while read LINE		# iterate through every file of file
do
	# grep for word, -E (extended regex for item1a|item1b|item1c, remove comments, remove empry line, print only 1st field, paste numbers and '+' and run it through calculator
	TMP=$(grep -Ew $LINE $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc)

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
			echo $(echo $LINE | cut -d '|' -f 1): $TMP
			;;
		*)
			echo $LINE: $TMP
			;;
	esac

	if [ "$LINE" = "stednja" ] ; then
		STEDNJA=$TMP
	fi

	# rezije|stan|stanarina
	case "$LINE" in
		*rezije*)
			REZIJE=$TMP
			;;
	esac

done < $FILE_KEYWORDS

UKUPNO=`cat $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
NESVRSTANO=$(($UKUPNO-$POTROSENO))
UKUPNO_BEZ_STEDNJE_I_REZIJA=$(($UKUPNO-$STEDNJA-$REZIJE))

echo "----------------------------------------"
echo "Ukupno:      $UKUPNO"
# echo "Potroseno:   $POTROSENO"
echo "Rezije:      $REZIJE"
echo "Stednja:     $STEDNJA"
echo "Nesvrstano:  $NESVRSTANO"
echo "----------------------------------------"
echo "Potroseno:   $UKUPNO_BEZ_STEDNJE_I_REZIJA   (bez stednje i rezija)"
