#!/bin/sh

# description: creates Debian packages
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

# version
MAJOR=3
VERSION=$MAJOR.0.0
# tested on: Debian 10, Ubuntu 19.10,  Raspbian 10

cd "$(dirname "$0")"

# prerequisits
for PKG in \
	dpkg-dev \
	debhelper \
	devscripts \
	fakeroot \
	wget \
	g++ \
	cmake \
	libboost-locale-dev \
	libicu-dev \
	ronn ;
do
	if [ `dpkg -l $PKG | grep -c ^ii` -eq 0 ]; then
		echo 'Missing package '$PKG
		exit 1
	fi
done

# platform
OS=`grep ^ID= /etc/os-release|awk -F = '{print $2}'`-`grep ^VERSION_CODENAME= /etc/os-release|awk -F = '{print $2}'`-`uname -m`
rm -rf ./$OS
mkdir $OS
cd $OS

# upstream tar
TAR=nuspell-$VERSION.tar.gz
wget -q https://github.com/nuspell/nuspell/archive/v$VERSION.tar.gz -O $TAR
tar -xf $TAR

# debianize
cp -a ../debian/ nuspell-$VERSION

# create orig tar with excluded files deleted
cd nuspell-$VERSION
mk-origtargz ../$TAR
cd ..
rm -rf ./nuspell-$VERSION
rm -f $TAR

# extract new tar and debianize again
ORIG=nuspell_$VERSION.orig.tar.xz
tar -xf $ORIG
cp -a ../debian/ nuspell-$VERSION


# package
cd nuspell-$VERSION
if [ `grep -c $VERSION debian/files` -lt 1 ]; then
	echo 'Missing version '$VERSION' in debian/files'
	exit 1
fi
if [ `grep -c $VERSION debian/changelog` -lt 1 ]; then
	echo 'Missing version '$VERSION' in debian/changelog'
	exit 1
fi
dpkg-buildpackage
cd ..

# symbols
dpkg-deb -x libnuspell$MAJOR\_$VERSION-*.deb tmp_symbols_tmp
dpkg-gensymbols -q -v$VERSION -plibnuspell$MAJOR -Ptmp_symbols_tmp -O../$OS\_libnuspell$MAJOR.symbols
rm -rf tmp_symbols_tmp
#if [ ! -e nuspell-$VERSION/debian/libnuspell$MAJOR.symbols ]; then
#	echo 'Missing file nuspell-'$VERSION'/debian/libnuspell'$MAJOR'.symbols'
#	echo 'Top-level directory has newly generated libnuspell'$MAJOR'.symbols which need to be added to debian directory in proper repo and build packages again'
#	rm -f *nuspell*$VERSION*deb
#	exit 1
#fi
#awk '{print $1}' nuspell-$VERSION/debian/libnuspell$MAJOR.symbols > symbols-debian
#awk '{print $1}' libnuspell$MAJOR.symbols > symbols-current
#if [ `diff symbols-debian symbols-current|wc -l` -ne 0 ]; then
#	diff symbols-debian symbols-current
#	rm -f symbols-debian symbols-current
#	echo 'Outdated file nuspell-'$VERSION'/debian/libnuspell'$MAJOR'.symbols'
#	echo 'Top-level directory has newly generated libnuspell'$MAJOR'.symbols which need to be added to debian directory in proper repo and build packages again'
#	rm -f *nuspell*$VERSION*deb
#	exit 1
#fi
#rm -f libnuspell$MAJOR.symbols symbols-debian symbols-current

# report
echo 'Build for '$OS
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

cd ..
