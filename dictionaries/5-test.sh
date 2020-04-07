#!/usr/bin/env sh

# description: Tests extracted and converted disctionaries
# license: https://github.com/nuspell/nuspell/blob/master/COPYING.LESSER
# author: Sander van Geloven

set -e
cd $(dirname "$0")
if [ ! -d extractions ]; then
	echo 'ERROR: Run the script ./2-extract.sh first.'
    exit 1
fi

# short non-existing word that doesn't trigger compounding
WORD=qqqq

cd extractions
for i in $(ls|sort); do
	echo 'extracted '$i
	cd $i
	for DIC in $(ls *.dic|sort); do
		LANG=$(basename $DIC .dic)
		echo '\t'$LANG
		echo $WORD | hunspell -d ./$LANG
		echo $WORD | nuspell -d ./$LANG
		echo
		echo
	done
	cd ..
done
cd ..

if [ ! -d utf8 ]; then
	echo 'ERROR: Run the script ./4-convert.sh first.'
    exit 1
fi
cd utf8
for i in $(ls|sort); do
	echo 'converted '$i
	cd $i
	for DIC in $(ls *.dic|sort); do
		LANG=$(basename $DIC .dic)
		echo '\t'$LANG
		echo $WORD | hunspell -d ./$LANG
		echo $WORD | nuspell -d ./$LANG
		echo
		echo
	done
	cd ..
done
cd ..

echo 'Consider reporting conversion warnings and errors upstream'
