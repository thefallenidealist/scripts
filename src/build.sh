#!/bin/sh
# Created 200604
set_dir()
{
	# BASEDIR is used instead of PWD so script can be run from other dirs
	BASEDIR=$(dirname "$0")
	if [ "$BASEDIR" = "." ] ; then
		BASEDIR=$PWD	# case when script is run from cwd with ./
	fi
}

set_dir

echo BASEDIR: $BASEDIR

for i in $BASEDIR/*.c
do
	BASENAME=$(basename $i | cut -d '.' -f 1)
	echo "Compiling $i -> $BASEDIR/../$BASENAME"
	cc -Wall -o2 $i -o $BASEDIR/../$BASENAME
done
