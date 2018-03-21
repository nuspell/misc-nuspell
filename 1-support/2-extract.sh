#!/usr/bin/env bash

if [ -e packages ]; then
	rm -rf packages
fi
mkdir packages

cd debs
for i in *.deb; do
	DIRECTORY=`echo $i|awk -F _ '{print $1}'|sed 's/hunspell-//'`  #FIXME awk -> sed
	VERSION=`echo $i|awk -F _ '{print $2}'|sed 's/hunspell-//'`  #FIXME awk -> sed
	echo -e $DIRECTORY'\t'$VERSION
	mkdir -p ../packages/$DIRECTORY/$VERSION
	dpkg -x $i ../packages/$DIRECTORY/$VERSION
done
cd ..

rm -rf packages/*/*/usr/share/doc packages/*/*/usr/share/myspell
