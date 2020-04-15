#!/bin/sh

# description: creates deb packages
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

# version
MAJOR=3
VERSION=$MAJOR.1.0

set -e
cd "$(dirname "$0")"

# prerequisits
for PKG in \
	build-essential \
	dpkg-dev \
	devscripts \
	fakeroot \
	wget \
	libgpgmepp6 \
	g++ ;
do
	if [ `dpkg -l $PKG | grep -c ^ii` -eq 0 ]; then
		echo 'Missing package '$PKG
		exit 1
	fi
done

# output directories
rm -rf build
mkdir build
cd build

# upstream tar
TAR=nuspell-$VERSION.tar.gz
wget -q https://github.com/nuspell/nuspell/archive/v$VERSION.tar.gz -O $TAR
tar -xf $TAR

# debianize
cp -a ../debian/ nuspell-$VERSION

# create orig tar with excluded files deleted
cd nuspell-$VERSION
ORIG=nuspell_$VERSION.orig.tar.xz
mk-origtargz ../$TAR
cd ..
if [ -e nuspell_$VERSION.orig.tar.gz ]; then # for at least ubuntu-bionic
	gunzip < nuspell_$VERSION.orig.tar.gz | xz > $ORIG
	rm -f nuspell_$VERSION.orig.tar.gz
fi
rm -rf ./nuspell-$VERSION
rm -f $TAR

# create source build for sending to Debian Mentors
mkdir debian-src
cd debian-src
cp ../$ORIG .
tar -xf $ORIG
cp -a ../../debian/ nuspell-$VERSION
cd nuspell-$VERSION
debuild -S
cd ../..

# create source build for sending to Launchpad
mkdir bionic-ppa-src
cd bionic-ppa-src
cp ../$ORIG .
tar -xf $ORIG
cp -a ../../debian/      nuspell-$VERSION
cp -a ../../bionic-ppa/* nuspell-$VERSION/debian
cd nuspell-$VERSION
debuild -S
cd ../..

# create source build for sending to Launchpad
mkdir eoan-ppa-src
cd eoan-ppa-src
cp ../$ORIG .
tar -xf $ORIG
cp -a ../../debian/    nuspell-$VERSION
cp -a ../../eoan-ppa/* nuspell-$VERSION/debian
cd nuspell-$VERSION
debuild -S
cd ../..

# create source build for sending to Launchpad
mkdir focal-ppa-src
cd focal-ppa-src
cp ../$ORIG .
tar -xf $ORIG
cp -a ../../debian/    nuspell-$VERSION
cp -a ../../focal-ppa/* nuspell-$VERSION/debian
cd nuspell-$VERSION
debuild -S
cd ../..

# Bellow follow full binary builds, meant for local testing

# platform
# CODENAME=`grep ^VERSION_CODENAME= /etc/os-release|awk -F = '{print $2}'`
# REL=`grep ^ID= /etc/os-release|awk -F = '{print $2}'`-$CODENAME
# OS=$REL-`uname -m`

mkdir debian-bin
cd debian-bin
cp ../$ORIG .
tar -xf $ORIG
cp -a ../../debian/ nuspell-$VERSION
cd nuspell-$VERSION
debuild
cd ..

# symbols
# dpkg-deb -x libnuspell$MAJOR\_$VERSION-*.deb tmp_symbols_tmp
# dpkg-gensymbols -q -v$VERSION -plibnuspell$MAJOR -Ptmp_symbols_tmp -Olibnuspell$MAJOR.symbols
# rm -rf tmp_symbols_tmp

# report
echo 'Build for Debian'
echo
ls -lh nuspell_$VERSION-*.dsc
grep Depends: nuspell_$VERSION-*.dsc
echo
ls -lh $ORIG
echo
ls -lh nuspell_$VERSION-*.debian.tar.xz
for i in *$VERSION-*.deb; do
	echo
	ls -lh $i
	dpkg --info $i|grep '^ Depends:'
	dpkg --info $i|grep '^ Recommends:'
	dpkg -c $i|grep -v /$
done
