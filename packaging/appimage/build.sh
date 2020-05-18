#!/bin/sh

# description: creates AppImage with appimage-builder
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

set -e
cd "$(dirname "$0")"

# prerequisits
# see README.md

# build and test
for i in $(ls ??04.yml|sort); do
	VERSION=$(basename $i .yml)
	sudo appimage-builder --recipe $i # refactor to remove sudo
	sudo mv -f Nuspell-latest-x86_64.AppImage Nuspell-$VERSION-x86_64.AppImage
	./Nuspell-$VERSION-x86_64.AppImage -D
done
