#!/bin/sh

# description: creates Debian packages
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

# version
MAJOR=3
VERSION=$MAJOR.0.0

cd "$(dirname "$0")"

# platform
CODENAME=`grep ^VERSION_CODENAME= /etc/os-release|awk -F = '{print $2}'`
REL=`grep ^ID= /etc/os-release|awk -F = '{print $2}'`-$CODENAME
# OS=$REL-`uname -m`

# prerequisits
for PKG in \
	build-essential \
	dpkg-dev \
	debhelper \
	devscripts \
	fakeroot \
	wget \
	libgpgmepp6 \
	g++ \
	cmake \
	libboost-locale-dev \
	libicu-dev \
	ronn ;
do
	if [ `dpkg -l $PKG | grep -c ^ii` -eq 0 ]; then
		if [ $PKG = ronn -a $REL = 'ubuntu-bionic' ]; then
			if [ `dpkg -l ruby-ronn | grep -c ^ii` -eq 0 ]; then
				echo 'Missing package ruby-ronn'
				exit 1
			fi
		else
			echo 'Missing package '$PKG
			exit 1
		fi
	fi
done

# output directories
rm -rf debian-build bionic-ppa-build eoan-ppa-build
mkdir debian-build bionic-ppa-build eoan-ppa-build
cd debian-build

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

# extract new tar and debianize again
tar -xf $ORIG
cp -a ../debian/ nuspell-$VERSION

# package
cd nuspell-$VERSION
if ! grep -c $VERSION debian/changelog ; then
	echo 'Missing version '$VERSION' in debian/changelog'
	exit 1
fi
dpkg-buildpackage
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

cd ../bionic-ppa-build
cp ../debian-build/$ORIG .
tar -xf $ORIG
cd nuspell-$VERSION
cp -a ../../debian .
cp -a ../../bionic-ppa/* debian
debuild -S
cd ..

cd ../eoan-ppa-build
cp ../debian-build/$ORIG .
tar -xf $ORIG
cd nuspell-$VERSION
cp -a ../../debian debian
cp -a ../../eoan-ppa/* debian
debuild -S
