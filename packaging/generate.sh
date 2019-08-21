#!/usr/bin/env sh

# Set version information
SHORT=2.3
LONG=$SHORT.0
PATCH=0

# Replace version information in any template file
replace() {
	sed -i -e 's/LONG/'$LONG'/g' $FILE
	sed -i -e 's/SHORT/'$SHORT'/g' $FILE
	sed -i -e 's/PATCH/'$PATCH'/g' $FILE
}

# Replace version information in a dsc template file
dpkg_sums() {
	ORGFILE=$ORIG
	DEBFILE=$ARCH

	ORGSIZE=`ls -l $ORGFILE|awk '{print $5}'`
	DEBSIZE=`ls -l $DEBFILE|awk '{print $5}'`
	ORGSHA1=`sha1sum $ORGFILE|awk '{print $1}'`
	DEBSHA1=`sha1sum $DEBFILE|awk '{print $1}'`
	ORGSHA256=`sha256sum $ORGFILE|awk '{print $1}'`
	DEBSHA256=`sha256sum $DEBFILE|awk '{print $1}'`
	ORGMD5=`md5sum $ORGFILE|awk '{print $1}'`
	DEBMD5=`md5sum $DEBFILE|awk '{print $1}'`

	sed -i -e 's/ORGFILE/'$ORGFILE'/g' $FILE
	sed -i -e 's/DEBFILE/'$DEBFILE'/g' $FILE
	sed -i -e 's/ORGSIZE/'$ORGSIZE'/g' $FILE
	sed -i -e 's/DEBSIZE/'$DEBSIZE'/g' $FILE
	sed -i -e 's/ORGSHA1/'$ORGSHA1'/g' $FILE
	sed -i -e 's/DEBSHA1/'$DEBSHA1'/g' $FILE
	sed -i -e 's/ORGSHA256/'$ORGSHA256'/g' $FILE
	sed -i -e 's/DEBSHA256/'$DEBSHA256'/g' $FILE
	sed -i -e 's/ORGMD5/'$ORGMD5'/g' $FILE
	sed -i -e 's/DEBMD5/'$DEBMD5'/g' $FILE
}

# Get operating system and package manager
OS=`grep ^ID= /etc/os-release|awk -F = '{print $2}'`
if [ $OS = debian ]; then
	LIKE=debian
else
	LIKE=`grep ^ID_LIKE= /etc/os-release|awk -F = '{print $2}'`
fi
if [ $LIKE = debian ]; then
	PKGM=dpkg
else
	echo 'ERROR: Unsupported package manager'
	exit
fi

# Display variables
echo 'OS:\t'$OS
echo 'PKGM:\t'$PKGM
echo 'SHORT:\t'$SHORT
echo 'LONG:\t'$LONG
echo 'PATCH:\t'$PATCH

# Do generic actions
mkdir -p packages/$OS
echo 'INFO: Working directory is pacakges/'$OS
cd packages/$OS
ORIG='nuspell_'$LONG'.orig.tar.gz'
wget -q 'https://github.com/nuspell/nuspell/archive/v'$LONG'.tar.gz' -O $ORIG
echo 'INFO: Downloaded '$ORIG

# Do package manager speicific actions
if [ $PKGM = dpkg ]; then
	# Generate debian directory
	rm -rf debian
	cp -a ../../templates/dpkg/debian .
	cd debian

	FILE=control
	replace

	FILE=rules
	replace

	FILE=libnuspell-SHORT-PATCH.shlibs
	replace
	mv -f libnuspell-SHORT-PATCH.shlibs 'libnuspell-'$SHORT'-'$PATCH'.shlibs'

	mv -f libnuspell-SHORT-PATCH.install 'libnuspell-'$SHORT'-'$PATCH'.install'

	tar xf ../$ORIG 'nuspell-'$LONG'/COPYING'
	mv 'nuspell-'$LONG'/COPYING' copyright

	rmdir 'nuspell-'$LONG
	cd ..

	# Create .debian.tar.xz archive with Debian related files
	ARCH='nuspell_'$LONG'-'$PATCH'.debian.tar.xz'
	rm -f $ARCH
	tar cfJ $ARCH debian

	# Create Debian description file .dsc
	FILE='nuspell_'$LONG'-'$PATCH'.dsc'
	cp -a ../../templates/dpkg/nuspell_LONG-PATCH.dsc $FILE
	replace
	dpkg_sums
	#TODO Sign the .dsc file

	# List generated files
	echo 'INFO: Generated debian, '$FILE' and '$ARCH

	# Create source package file
	dpkg-source --build ../$OS #FIXME Results in error that needs fixing.
fi

# Return to start directory
cd ../..
