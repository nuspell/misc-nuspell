#!/usr/bin/env sh

# distrubtion and version
OS=`grep ^ID= /etc/os-release|awk -F = '{print $2}'`_`grep ^VERSION_CODENAME= /etc/os-release|awk -F = '{print $2}'`
if [ ! -e $OS ]; then
	mkdir $OS
fi
cd $OS

# release and debian files
VERSION=3.0.0
ORIG='nuspell_'$VERSION'.orig.tar.gz'
if [ ! -e $ORIG ]; then
	wget -q 'https://github.com/nuspell/nuspell/archive/v'$VERSION'.tar.gz' -O $ORIG
fi
rm -rf nuspell-$VERSION
tar xf $ORIG
cp -a ../debian-$VERSION nuspell-$VERSION/debian

# package generation
cd nuspell-$VERSION
dpkg-buildpackage
cd ..

# list package contents
for i in *$VERSION*.deb; do
	echo
	echo $i
	dpkg --info $i|grep '^ Depends:'
	dpkg --info $i|grep '^ Recommends:'
	dpkg -c $i
done
