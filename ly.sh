#!/bin/sh
# created 100813

MAXLINES=56

# folder je ~/.lyrics/artist/song	sve malim slovima
DIR=~/.lyrics
	#ARTIST=`mocp -i | grep Artist: | cut -d ':' -f 2 | sed "s/ //" | tr '[:upper:]' '[:lower:]'`
	#SONG=`mocp -i | grep SongTitle | cut -d ':' -f 2,3 | sed "s/ //" | tr '[:upper:]' '[:lower:]'`	# 2,3 zbog "40:1"
	#ARTIST2=`mocp -i | grep Artist: | cut -d ':' -f 2 | sed "s/ //"`
	#SONG2=`mocp -i | grep SongTitle | cut -d ':' -f 2,3 | sed "s/ //"`

	# samo mala slova, da nadje na disku
	#ARTIST=`audtool current-song | cut -d "-" -f 1 | sed 's/\ $//g' | tr '[:upper:]' '[:lower:]'`
	# XXX:
	# razjebe se kad je "Ensiferum - 1997-1999 - Eternal Wait"
	#SONG=`audtool current-song | cut -d "-" -f 3 | sed -e 's/^[ \t]*//' | tr '[:upper:]' '[:lower:]'`
	# za ljepsi ispis sa velikim slovima
	#ARTIST2=`audtool current-song | cut -d "-" -f 1 | sed 's/\ $//g'`
	#SONG2=`audtool current-song | cut -d "-" -f 3 | sed -e 's/^[ \t]*//'`
	#PAGER="less -XMr"		# moze koristit $PAGER od shella

ARTIST_UC=`deadbeef --nowplaying "%a" 2> /dev/null`
ARTIST=`deadbeef --nowplaying "%a" 2> /dev/null | tr '[:upper:]' '[:lower:]'`
SONG_UC=`deadbeef --nowplaying "%t" 2> /dev/null`
SONG=`deadbeef --nowplaying "%t" 2> /dev/null | tr '[:upper:]' '[:lower:]'`

#if [ ! -e "$DIR/$ARTIST" ] ; then
	#mkdir -p "$DIR/$ARTIST"
#fi

#echo cd to $DIR/$ARTIST
cd "$DIR/$ARTIST"

#echo DEBUG: DIR:     $DIR
#echo DEBUG: ARTIST:  $ARTIST
#echo DEBUG: SONG:    $SONG

 clear;

if [ -e "$SONG" ]; then
	if [ `wc -l "$SONG" | awk '{print $1}'` -le $MAXLINES ]; then
		#ako je ispod MAXLINES redova (koliko moze prikazat na jednom ekranu) koristi cat
		PAGER=cat
		printf "\t\t\t$ARTIST_UC - $SONG_UC\n\n"
		$PAGER "$SONG"
	else
		# ako je vise od MAXLINES koristi less (defaultni shell $PAGER)
		#$PAGER "$SONG"*		# ne radi (Azra - Andjeli.txt)
		# less ne ispise naslov pa zato preusmjeravanje u fajl
		printf "\t\t\t$ARTIST_UC - $SONG_UC\n\n" > /tmp/lyrics
		$PAGER "$SONG" >> /tmp/lyrics
		$PAGER /tmp/lyrics
		rm /tmp/lyrics
	fi
else
	# echo "Ne postoji $DIR/$ARTIST/$SONG"
	#echo "Ne postoji, skidam s neta"
	mkdir -p "$DIR/$ARTIST"
	lyrics > "$DIR/$ARTIST/$SONG"
	$PAGER "$SONG"
fi

# TODO 2010: rijesit problem kad ima / u nazivu pjesme:	Slayer - Metal Storm/Face The Slayer
# doradit da "ly little dreamer" (bez \) prikaze odgovarajuce lyricse iako ne svira ta pjesma
# doradit da "ly guglo" prikaze lyricse od trenutacno svirane pjesme s gugla
# ako postoji "ime pjesme (album)", preferiraj ga, npr: "sadness and hate (immemorial)"
