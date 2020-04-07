#!/usr/bin/env sh

# description: Create histograms for converted dictionaries
# license: https://github.com/nuspell/nuspell/blob/master/COPYING.LESSER
# author: Sander van Geloven

set -e
cd $(dirname "$0")
if [ ! -d utf8 ]; then
	echo 'ERROR: Run the script ./4-convert.sh first.'
    exit 1
fi
if [ -e histograms ]; then
	rm -rf histograms/*
else
	mkdir histograms
fi
cd utf8

for i in $(ls|sort); do
	echo $i
	cd $i
	for DIC in $(ls *.dic|sort); do
		LANG=$(basename $DIC .dic)
		AFF=$LANG.aff
		echo '\t'$LANG
		../../../tools/histogram.py $DIC > ../../histograms/$i~$DIC.md
		../../../tools/histogram.py $AFF > ../../histograms/$i~$AFF.md
	done
	cd ..
done

cd ..
