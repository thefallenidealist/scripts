#!/bin/sh
#!/usr/bin/env bash	# ne znam zasto sam ovo stavio, radi i u Bourn shellu
# created 160201

FILE=$1

echo FILE: $FILE

#REGEX=" cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc"
CMD_UKUPNO=`cat $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_HRANA=`grep -i hrana $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_HRANAP=`grep -i hranaP $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_HRANA2=`grep -i hrana2 $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_HRANA3=`grep -i hrana3 $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_VOCE=`grep -i voce $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_CAJ=`grep -i caj $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_PIVO=`grep -i pivo $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_STAN=`grep -i 'stan' $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
# CMD_REZIJE=`grep -i rezije $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
# CMD_BON=`grep -i bon $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_BON=`grep -i "bon\|internet" $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_HIGIJENA=`grep -i higijena $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_PRIJEVOZ=`grep -i "karta\|prijevoz" $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_CIGARE=`grep -i cigare $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_KRS=`grep -i krs $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_ZABAVA=`grep -i zabava $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_TRGOVINA=`grep -i trgovina $FILE | grep -v trgovina2 | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_TRGOVINA2=`grep -i trgovina2 $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_POKLON=`grep -i poklon $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_ODJECA=`grep -i odjeca $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_STEDNJA=`grep -i stednja $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`
CMD_PUT=`grep -i put $FILE | cut -f 1 | sed -e 's/#.*$//' -e '/^$/d' | cut -d " " -f 1 | paste -sd+ - | bc`

if [ -z $CMD_ODJECA ] ; then
	# echo zero
else
	# echo not zero
fi

# CMD_OSTALO=`echo $CMD_UKUPNO - $CMD_HRANA - $CMD_PIVO - $CMD_STAN - $CMD_REZIJE - $CMD_BON - $CMD_PIVO - $CMD_PRIJEVOZ - $CMD_CIGARE - $CMD_KRS - $CMD_ZABAVA - $CMD_TRGOVINA - $CMD_TRGOVINA2 - $CMD_ODJECA`

echo Ukupno: $CMD_UKUPNO
echo Hrana: $CMD_HRANA \(Ukupno\)
echo HranaP: $CMD_HRANAP
echo Hrana2: $CMD_HRANA2
echo Hrana3: $CMD_HRANA3
echo Voce: $CMD_VOCE
echo Pivo: $CMD_PIVO
echo Caj: $CMD_CAJ
echo Prijevoz: $CMD_PRIJEVOZ
echo Trgovina: $CMD_TRGOVINA
echo Trgovina2: $CMD_TRGOVINA2
echo Odjeca: $CMD_ODJECA
echo Stan: $CMD_STAN
echo Rezije: $CMD_REZIJE
echo Bon: $CMD_BON
echo Higijena: $CMD_HIGIJENA
echo Cigare: $CMD_CIGARE
echo Zabava: $CMD_ZABAVA
echo Poklon: $CMD_POKLON
echo Krs: $CMD_KRS
echo Stednja: $CMD_STEDNJA
echo Ostalo: $CMD_OSTALO
