#!/usr/bin/env bash

# author: Sander van Geloven
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# description: extracts downloaded packages with Hunspell language support

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
	for i in `ls *.deb|sort`; do
		#TODO awk -> sed for next two lines
		DIRECTORY=`echo $i|awk -F _ '{print $1}'|sed 's/hunspell-//'|sed 's/myspell-//'`
		VERSION=`echo $i|awk -F _ '{print $2}'|sed 's/hunspell-//'|sed 's/myspell-//'`
		echo -e $DIRECTORY'\t'$VERSION
		mkdir -p ../files/$DIRECTORY/$VERSION
		dpkg -x $i ../files/$DIRECTORY/$VERSION
	done
	cd ..
	rm -rf files/*/*/usr/share/doc files/*/*/usr/share/myspell files/*/*/usr/share/hyphen
elif [ $platform = freebsd ]; then
	for i in `ls *.txz|sort`; do
		DIRECTORY=`basename $i .txz | awk -F '-hunspell-' '{print $1}'`
		VERSION=`basename $i .txz | awk -F '-hunspell-' '{print $2}'`
		echo -e $DIRECTORY'\t'$VERSION
		mkdir -p ../files/$DIRECTORY/$VERSION
		tar xf $i -C ../files/$DIRECTORY/$VERSION 2> /dev/null
		mv ../files/$DIRECTORY/$VERSION/usr/local/* ../files/$DIRECTORY/$VERSION/usr
		rmdir ../files/$DIRECTORY/$VERSION/usr/local
	done
	cd ..
	rm -rf files/*/*/+MANIFEST files/*/*/+COMPACT_MANIFEST files/*/*/usr/share/licenses
fi
