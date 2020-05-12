#!/bin/sh

# description: upload Debian package to Launchpad
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

# version
MAJOR=3
VERSION=$MAJOR.1.1

set -e
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

cd build/1804-ppa-src
dput -l ppa:nuspell/ppa nuspell_$VERSION-*.changes
cd ../../build/1910-ppa-src
dput -l ppa:nuspell/ppa nuspell_$VERSION-*.changes
cd ../../build/2004-ppa-src
dput -l ppa:nuspell/ppa nuspell_$VERSION-*.changes
cd ../..
