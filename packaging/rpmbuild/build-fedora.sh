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
#rm -rf build
#mkdir build
#cd build
cd rpmbuild

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

#cd SRPMS
#rpmbuild -rb ../SRPMS/nuspell-$VERSION-*.src.rpm
#cd ..

cd ..
