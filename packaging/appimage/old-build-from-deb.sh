#!/bin/sh

# description: creates AppImage
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

set -e
cd "$(dirname "$0")"

# prerequisits
if [ ! -e pkg2appimage-master ]; then
	wget https://github.com/AppImage/pkg2appimage/archive/master.zip
	unzip master.zip
	rm -f master.zip
fi

# build
pkg2appimage-master/pkg2appimage Old-Nuspell.yml
cd out
for i in *glibc*.AppImage; do
	mv $i $(echo $i|sed -e 's/\.glibc[0-9\.]*//')
done

# test
for i in *.AppImage; do
	./$i -D
done
cd ..
