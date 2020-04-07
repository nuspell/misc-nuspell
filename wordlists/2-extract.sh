#!/usr/bin/env sh

# description: Extracts downloaded word list packages
# license: https://github.com/nuspell/nuspell/blob/master/COPYING.LESSER
# author: Sander van Geloven

set -e
cd $(dirname "$0")
if [ ! -d downloads ]; then
	echo 'ERROR: First, run the script ./1-download.sh'
	exit 1
fi
if [ -e extractions ]; then
	rm -rf extractions/*
else
	mkdir extractions
fi
cd extractions

for i in $(ls ../downloads/*.deb|sort); do
	TMP=$(basename $i)
	PACKAGE=$(echo $TMP|awk -F _ '{print $1}')
	echo 'Extracting '$i
	mkdir $TMP
	dpkg -x $i $TMP
	DIRECTORY=$(echo $TMP|awk -F _ '{print $1"_"$2}')
	mkdir $DIRECTORY
	find $TMP/usr/share/dict/ -type f -exec cp {} $DIRECTORY \;
	rm -rf $TMP
done

cd ..
