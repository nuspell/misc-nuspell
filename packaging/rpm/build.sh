#!/bin/sh

# description: creates rpm packages
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

# version
MAJOR=3
VERSION=$MAJOR.1.0

set -e
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
if [ ! -e ~/rpmbuild/SOURCES ]; then
	mkdir -p ~/rpmbuild/SOURCES
fi
if [ ! -e ~/rpmbuild/SPECS ]; then
	mkdir -p ~/rpmbuild/SPECS
fi
cp -a nuspell.spec ~/rpmbuild/SPECS

# upstream tar
cd ~/rpmbuild/SOURCES
wget -q https://github.com/nuspell/nuspell/archive/v$VERSION.tar.gz

# build
cd ../SPECS
rpmlint nuspell.spec
rpmbuild -bs nuspell.spec
rpmlint ../SRPMS/nuspell-$VERSION-*.src.rpm
rpmbuild -bb nuspell.spec
rpmlint ../RPMS/*/nuspell*-$VERSION-*.*.rpm
