#!/bin/sh

# description: creates Debian packages
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

# version
MAJOR=3
VERSION=$MAJOR.0.0

# tested on:
# - ubuntu-eoan-x86_64
# - ubuntu-bionic-x86_64
# - debian-buster-x86_64
# - raspbian-buster-armv7l
CODENAME=`grep ^VERSION_CODENAME= /etc/os-release|awk -F = '{print $2}'`
REL=`grep ^ID= /etc/os-release|awk -F = '{print $2}'`-$CODENAME
OS=$REL-`uname -m`

cd "$(dirname "$0")"

# prerequisits
for PKG in \
	build-essential \
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

# platform
rm -rf ./$OS
mkdir $OS
cd $OS

# upstream tar
TAR=nuspell-$VERSION.tar.gz
wget -q https://github.com/nuspell/nuspell/archive/v$VERSION.tar.gz -O $TAR
tar -xf $TAR

# debianize
cp -a ../debian/ nuspell-$VERSION
sed -i 's/ unstable;/ '$CODENAME';/g' nuspell-$VERSION/debian/changelog
if [ $REL = 'ubuntu-bionic' ]; then
	sed -i 's/debhelper-compat (= 12)/debhelper-compat (= 11)/' nuspell-$VERSION/debian/control
	sed -i 's/, ronn/, ruby-ronn/' nuspell-$VERSION/debian/control
fi
if [ $REL = 'ubuntu-bionic' -o $REL = 'ubuntu-cosmic' -o $REL = 'ubuntu-disco' -o $REL = 'ubuntu-eoan' ]; then
	sed -i 's/Standards-Version: 4.5.0/Standards-Version: 4.4.0/' nuspell-$VERSION/debian/control
fi

# create orig tar with excluded files deleted
cd nuspell-$VERSION
mk-origtargz ../$TAR
cd ..
rm -rf ./nuspell-$VERSION
rm -f $TAR

# extract new tar and debianize again
ORIG=nuspell_$VERSION.orig.tar.xz
if [ -e nuspell_$VERSION.orig.tar.gz ]; then # for at least ubuntu-bionic
	gunzip < nuspell_$VERSION.orig.tar.gz | xz > $ORIG
	rm -f nuspell_$VERSION.orig.tar.gz
fi
tar -xf $ORIG
cp -a ../debian/ nuspell-$VERSION
sed -i 's/ unstable;/ '$CODENAME';/g' nuspell-$VERSION/debian/changelog
if [ $REL = 'ubuntu-bionic' ]; then
	sed -i 's/debhelper-compat (= 12)/debhelper-compat (= 11)/' nuspell-$VERSION/debian/control
	sed -i 's/, ronn/, ruby-ronn/' nuspell-$VERSION/debian/control
fi
if [ $REL = 'ubuntu-bionic' -o $REL = 'ubuntu-cosmic' -o $REL = 'ubuntu-disco' -o $REL = 'ubuntu-eoan' ]; then
	sed -i 's/Standards-Version: 4.5.0/Standards-Version: 4.4.0/' nuspell-$VERSION/debian/control
fi

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
dpkg-gensymbols -q -v$VERSION -plibnuspell$MAJOR -Ptmp_symbols_tmp -Olibnuspell$MAJOR.symbols
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
