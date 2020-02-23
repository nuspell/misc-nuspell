#!/usr/bin/env sh

# description: upload Debian package to Launchpad
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

# version
MAJOR=3
VERSION=$MAJOR.0.0

# tested on:
# - ubuntu-eoan-x86_64
CODENAME=`grep ^VERSION_CODENAME= /etc/os-release|awk -F = '{print $2}'`
REL=`grep ^ID= /etc/os-release|awk -F = '{print $2}'`-$CODENAME
OS=$REL-`uname -m`

cd "$(dirname "$0")"

# prerequisits
for PKG in \
	openssh-client \
	dput ;
do
	if [ `dpkg -l $PKG | grep -c ^ii` -eq 0 ]; then
		echo 'Missing package '$PKG
		exit 1
	fi
done

# platform
if [ ! -e $OS ]; then
	echo 'Missing directory '$OS
	exit 1
fi
cd $OS

#check
gpg --verify nuspell_$VERSION-*.changes
gpg --verify nuspell_$VERSION-*.dsc

# upload
dput -l -c ../dput.cf ppa:nuspell/ppa nuspell_$VERSION-*.changes
cd ..
