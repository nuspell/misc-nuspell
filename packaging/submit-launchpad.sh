#!/usr/bin/env sh

# description: upload Debian package to Launchpad
# license: https://github.com/nuspell/nuspell/blob/master/COPYING
# author: Sander van Geloven

# version
MAJOR=3
VERSION=$MAJOR.0.0

# prerequisits
check_installed () {
        if [ `dpkg -l $PACKAGE | grep -c ^ii` -eq 0 ]; then
		echo 'Missing package '$PACKAGE
		exit 1
	fi
}
for PACKAGE in `echo \
		openssh-client \
		dput`; do
	check_installed
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
