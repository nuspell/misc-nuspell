#!/usr/bin/env sh

# description: upload Debian package to Launchpad
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

# version
MAJOR=3
VERSION=$MAJOR.0.0
# tested on: Ubuntu 19.10

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
OS=`grep ^ID= /etc/os-release|awk -F = '{print $2}'`-`grep ^VERSION_CODENAME= /etc/os-release|awk -F = '{print $2}'`-`uname -m`
if [ ! -e $OS ]; then
	echo 'Missing directory '$OS
	exit 1
fi
cd $OS

#check
#gpg --verify nuspell_$VERSION-*.changes
#gpg --verify nuspell_$VERSION-*.dsc

# upload
#TODO option -l (lintian) and -f (force)
dput -l -c ../dput.cf ppa:nuspell/ppa nuspell_$VERSION-*.changes
cd ..
