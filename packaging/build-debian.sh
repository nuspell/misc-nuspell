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
OS=$REL-`uname -m`
BUILD=$VERSION
if [ $REL = 'ubuntu-bionic' ]; then
	BUILD=$VERSION-0~ppa1~ubuntu1804
fi
if [ $REL = 'ubuntu-eoan' ]; then
	BUILD=$VERSION-0~ppa1~ubuntu1910
fi

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
rm -rf ./$OS-source ./$OS-any
mkdir $OS-source $OS-any
cd $OS-source

# upstream tar
TAR=nuspell-$VERSION.tar.gz
wget -q https://github.com/nuspell/nuspell/archive/v$VERSION.tar.gz -O $TAR
tar -xf $TAR

# debianize
cp -a ../debian/ nuspell-$VERSION
if [ $REL = 'ubuntu-eoan' -o $REL = 'ubuntu-bionic' ]; then
	sed -i 's/('$VERSION'-1)/('$BUILD')/' nuspell-$VERSION/debian/changelog
	sed -i 's/('$VERSION'-1)/('$BUILD')/' nuspell-$VERSION/debian/files
fi
sed -i 's/ unstable;/ '$CODENAME';/g' nuspell-$VERSION/debian/changelog
if [ $REL = 'ubuntu-bionic' ]; then
	sed -i 's/debhelper-compat (= 12)/debhelper-compat (= 11)/' nuspell-$VERSION/debian/control
	sed -i 's/, ronn/, ruby-ronn/' nuspell-$VERSION/debian/control
fi
if [ $REL = 'ubuntu-cosmic' -o $REL = 'ubuntu-disco' -o $REL = 'ubuntu-eoan' ]; then
	sed -i 's/Standards-Version: 4.5.0/Standards-Version: 4.4.0/' nuspell-$VERSION/debian/control
fi
if [ $REL = 'ubuntu-bionic' ]; then
	sed -i 's/Standards-Version: 4.5.0/Standards-Version: 4.1.4/' nuspell-$VERSION/debian/control
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
if [ $REL = 'ubuntu-eoan' -o $REL = 'ubuntu-bionic' ]; then
	sed -i 's/('$VERSION'-1)/('$BUILD')/' nuspell-$VERSION/debian/changelog
	sed -i 's/('$VERSION'-1)/('$BUILD')/' nuspell-$VERSION/debian/files
fi
sed -i 's/ unstable;/ '$CODENAME';/g' nuspell-$VERSION/debian/changelog
if [ $REL = 'ubuntu-bionic' ]; then
	sed -i 's/debhelper-compat (= 12)/debhelper-compat (= 11)/' nuspell-$VERSION/debian/control
	sed -i 's/, ronn/, ruby-ronn/' nuspell-$VERSION/debian/control
fi
if [ $REL = 'ubuntu-cosmic' -o $REL = 'ubuntu-disco' -o $REL = 'ubuntu-eoan' ]; then
	sed -i 's/Standards-Version: 4.5.0/Standards-Version: 4.4.0/' nuspell-$VERSION/debian/control
fi
if [ $REL = 'ubuntu-bionic' ]; then
	sed -i 's/Standards-Version: 4.5.0/Standards-Version: 4.1.4/' nuspell-$VERSION/debian/control
fi

# package
cp -a * ../$OS-any
cd nuspell-$VERSION
if [ `grep -c $VERSION debian/files` -lt 1 ]; then
	echo 'Missing version '$VERSION' in debian/files'
	exit 1
fi
if [ `grep -c $VERSION debian/changelog` -lt 1 ]; then
	echo 'Missing version '$VERSION' in debian/changelog'
	exit 1
fi
dpkg-buildpackage -S
cd ../../$OS-any/nuspell-$VERSION
dpkg-buildpackage -B
cd ..

# symbols
dpkg-deb -x libnuspell$MAJOR\_$VERSION-*.deb tmp_symbols_tmp
dpkg-gensymbols -q -v$VERSION -plibnuspell$MAJOR -Ptmp_symbols_tmp -Olibnuspell$MAJOR.symbols
rm -rf tmp_symbols_tmp

# report
cd ..
echo 'Build for '$OS
echo
ls -lh $OS-source/nuspell_$VERSION-*.dsc
grep Depends: $OS-source/nuspell_$VERSION-*.dsc
echo
ls -lh $OS-source/$ORIG
echo
ls -lh $OS-source/nuspell_$VERSION-*.debian.tar.xz
for i in $OS-any/*$VERSION-*.deb; do
	echo
	ls -lh $i
	dpkg --info $i|grep '^ Depends:'
	dpkg --info $i|grep '^ Recommends:'
	dpkg -c $i|grep -v /$
done

cd ..
