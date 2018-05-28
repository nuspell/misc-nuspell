#!/usr/bin/env bash

if [ ! -d debs ]; then
	echo 'ERROR: Run the script ./1-download.sh first.'
    exit 1
fi

if [ -e packages ]; then
	rm -rf packages
fi
mkdir packages

cd debs
for i in *.deb; do
	VERSION=`echo $i|sed 's/.*_\(.*\)_.*/\1/'`
	DIRECTORY=`echo $i|sed 's/\([^_]\)_.*/\1/'`
	echo -e $DIRECTORY'\t'$VERSION
	mkdir -p ../packages/$DIRECTORY/$VERSION
	dpkg -x $i ../packages/$DIRECTORY/$VERSION
done
cd ..

rm -rf packages/*/*/usr/share/doc packages/*/*/usr/share/man
