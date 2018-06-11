#!/usr/bin/env bash

# author: Sander van Geloven
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# description: extract packages with word lists

platform=`../0-tools/platform.sh`

if [ ! -d packages ]; then
	echo 'ERROR: Run the script ./1-download.sh first.'
    exit 1
fi

if [ -e files ]; then
	rm -rf files
fi
mkdir files

cd packages
if [ $platform = linux ]; then
	for i in *.deb; do
		VERSION=`echo $i|sed 's/.*_\(.*\)_.*/\1/'`
		DIRECTORY=`echo $i|sed 's/\([^_]\)_.*/\1/'`
		echo -e $DIRECTORY'\t'$VERSION
		mkdir -p ../files/$DIRECTORY/$VERSION
		dpkg -x $i ../files/$DIRECTORY/$VERSION
	done
elif [ $platform = freebsd ]; then
	echo
fi
cd ..

rm -rf files/*/*/usr/share/doc files/*/*/usr/share/man
