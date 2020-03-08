#!/bin/sh

# description: creates rpm packages
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

# version
MAJOR=3
VERSION=$MAJOR.0.0

cd "$(dirname "$0")"

# prerequisits
for PKG in \
	rpm-build \
	rpmlint \
	mock ;
do
	if [ `rpm -q $PKG | grep -c ^$PKG-` -eq 0 ]; then
		echo 'Missing package '$PKG
		exit 1
	fi
done

# output directories
if [ ! -e BUILD ]; then
	mkdir BUILD
fi
if [ ! -e BUILDROOT ]; then
	mkdir BUILDROOT
fi
if [ ! -e RPMS ]; then
	mkdir RPMS
fi
if [ ! -e SOURCES ]; then
	mkdir SOURCES
fi
if [ ! -e SRPMS ]; then
	mkdir SRPMS
fi

# upstream tar
cd SOURCES
wget -q https://github.com/nuspell/nuspell/archive/v$VERSION.tar.gz
cd ..

# build
cd SPECS
rpmbuild -bs nuspell.spec
rpmlint nuspell.spec ../SRPMS/nuspell-$VERSION-*.src.rpm
rpmbuild -bb nuspell
rpmlint nuspell.spec ../RPMS/*/nuspell*
cd ..
