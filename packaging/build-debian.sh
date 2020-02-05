#!/usr/bin/env sh

# description: creates Debian packages
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

# prerequisits
check_installed () {
	if [ ! `dpkg -l $PACKAGE 2>&1 |grep -c 'no packages found matching'` -eq 0 ]; then
		echo 'Missing package '$PACKAGE
		exit 1
	fi
}
for PACKAGE in `echo \
		dpkg-dev \
		debhelper \
		fakeroot \
		git \
		g++ \
		cmake \
		libboost-locale-dev \
		libicu-dev \
		ronn`; do
	check_installed
done

# distribution
OS=`grep ^ID= /etc/os-release|awk -F = '{print $2}'`_`grep ^VERSION_CODENAME= /etc/os-release|awk -F = '{print $2}'`
rm -rf ./$OS
mkdir $OS
cd $OS

# files
MAJOR=3
VERSION=$MAJOR.0.0
wget -q https://github.com/nuspell/nuspell/archive/debian.zip
unzip -q debian.zip
rm -f debian.zip
mv nuspell-debian nuspell-$VERSION
tar cfz nuspell_$VERSION.orig.tar.gz nuspell-$VERSION

# package
cd nuspell-$VERSION
dpkg-buildpackage
cd ..

# symbols
dpkg-deb -x libnuspell$MAJOR\_$VERSION-*.deb tmp_libnuspell_tmp
dpkg-gensymbols -q -v$VERSION -plibfoo -Ptmp_libnuspell_tmp -Olibnuspell$MAJOR.symbols
rm -rf tmp_libnuspell_tmp
if [ ! -e nuspell-$VERSION/debian/libnuspell$MAJOR.symbols ]; then
	echo 'Missing file nuspell-'$VERSION'/debian/libnuspell'$MAJOR'.symbols'
	exit 1
fi
if [ `diff nuspell-3.0.0/debian/libnuspell$MAJOR.symbols libnuspell$MAJOR.symbols|wc -l` -ne 0 ]; then
	echo 'Upgrade nuspell-'$VERSION'/debian/libnuspell'$MAJOR'.symbols with libnuspell'$MAJOR'.symbols'
	exit 1
fi
rm -f libnuspell$MAJOR.symbols

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
