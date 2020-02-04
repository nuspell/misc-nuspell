#!/usr/bin/env sh

# description: creates Debian packages
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

installed () {
	if [ ! `dpkg -l $PACKAGE 2>&1 |grep -c 'no packages found matching'` -eq 0 ]; then
		echo 'Missing package '$PACKAGE
		exit 1
	fi

}

# prerequisits
for PACKAGE in `echo dpkg-dev debhelper fakeroot git g++ cmake libboost-locale-dev libicu-dev ronn`; do
	installed
done

# distrubtion
OS=`grep ^ID= /etc/os-release|awk -F = '{print $2}'`_`grep ^VERSION_CODENAME= /etc/os-release|awk -F = '{print $2}'`
if [ ! -e $OS ]; then
	mkdir $OS
fi
cd $OS

# files
VERSION=3.0.0
ORIG='nuspell_'$VERSION'.orig.tar.gz'
rm -rf debian.zip nuspell-debian nuspell-$VERSION
wget -q https://github.com/nuspell/nuspell/archive/debian.zip
unzip -q debian.zip
mv nuspell-debian nuspell-$VERSION
tar cfz $ORIG nuspell-$VERSION

# package
cd nuspell-$VERSION
dpkg-buildpackage
cd ..

# contents
echo 'Build for '$OS
for i in *$VERSION*.deb; do
	echo
	echo $i
	dpkg --info $i|grep '^ Depends:'
	dpkg --info $i|grep '^ Recommends:'
	dpkg -c $i
done
cd ..
