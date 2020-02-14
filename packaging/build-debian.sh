#!/usr/bin/env sh

# description: creates Debian packages
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

# version
MAJOR=3
VERSION=$MAJOR.0.0
# tested on: Debian 10, Ubuntu 19.10,  Raspbian 10

# prerequisits
check_installed () {
	if [ `dpkg -l $PACKAGE | grep -c ^ii` -eq 0 ]; then
		echo 'Missing package '$PACKAGE
		exit 1
	fi
}
for PACKAGE in `echo \
		dpkg-dev \
		debhelper \
		fakeroot \
		wget \
		g++ \
		cmake \
		libboost-locale-dev \
		libicu-dev \
		ronn`; do
	check_installed
done

# platform
OS=`grep ^ID= /etc/os-release|awk -F = '{print $2}'`-`grep ^VERSION_CODENAME= /etc/os-release|awk -F = '{print $2}'`-`uname -m`
rm -rf ./$OS
mkdir $OS
cd $OS

# orig
ORIG='nuspell_'$VERSION'.orig.tar.gz'
wget -q https://github.com/nuspell/nuspell/archive/v$VERSION.tar.gz -O $ORIG
tar xf $ORIG

# debian
wget -q https://github.com/nuspell/nuspell/archive/debian.zip
unzip -q debian.zip
rm -f debian.zip
mv nuspell-debian/debian nuspell-$VERSION
rm -rf nuspell-debian

# package
cd nuspell-$VERSION
dpkg-buildpackage #TODO migrate to sbuild

# symbols
cd ..
dpkg-deb -x libnuspell$MAJOR\_$VERSION-*.deb tmp_symbols_tmp
dpkg-gensymbols -q -v$VERSION -plibnuspell$MAJOR -Ptmp_symbols_tmp -Olibnuspell$MAJOR.symbols
#rm -rf tmp_symbols_tmp
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
ls -lh nuspell_$VERSION.orig.tar.gz
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
