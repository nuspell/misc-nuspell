#!/bin/sh

# description: upload Debian package to Launchpad
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

# version
MAJOR=3
VERSION=$MAJOR.0.0

# tested on:
# - ubuntu-eoan-x86_64

cd "$(dirname "$0")"

# prerequisits
for PKG in \
	dput ;
do
	if [ `dpkg -l $PKG | grep -c ^ii` -eq 0 ]; then
		echo 'Missing package '$PKG
		exit 1
	fi
done

cd build/bionic-ppa-src
dput -l ppa:nuspell/ppa nuspell_$VERSION-*.changes
cd ../eoan-ppa-src
dput -l ppa:nuspell/ppa nuspell_$VERSION-*.changes
