#!/usr/bin/env bash

# author: Sander van Geloven
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# description: extracts downloaded Debian packages with Hunspell language support

if [ ! -d debs ]; then
	echo 'ERROR: Run the script ./1-download.sh first.'
    exit 1
fi

if [ -e packages ]; then
	rm -rf packages
fi
mkdir packages

cd debs
for i in `ls *.deb|sort`; do
    #TODO awk -> sed for next two lines
	DIRECTORY=`echo $i|awk -F _ '{print $1}'|sed 's/hunspell-//'|sed 's/myspell-//'`
	VERSION=`echo $i|awk -F _ '{print $2}'|sed 's/hunspell-//'|sed 's/myspell-//'`
	echo -e $DIRECTORY'\t'$VERSION
	mkdir -p ../packages/$DIRECTORY/$VERSION
	dpkg -x $i ../packages/$DIRECTORY/$VERSION
done
cd ..

rm -rf packages/*/*/usr/share/doc packages/*/*/usr/share/myspell packages/*/*/usr/share/hyphen
