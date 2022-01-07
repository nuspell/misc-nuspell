# version
MAJOR=5
VERSION=$MAJOR.0.1

set -e
cd "$(dirname "$0")"

# prerequisits
for PKG in \
	build-essential \
	cmake \
	dpkg-dev \
	debhelper \
	devscripts \
	fakeroot \
	g++ \
	libgpgmepp6 \
	wget ;
do
	if [ `dpkg -l $PKG | grep -c ^ii` -eq 0 ]; then
		echo 'Missing package '$PKG
		exit 1
	fi
done

# output directories
rm -rf build
mkdir build
cd build

# upstream tar
TAR=nuspell-$VERSION.tar.gz
wget -q https://github.com/nuspell/nuspell/archive/v$VERSION.tar.gz -O $TAR
tar -xf $TAR

# debianize
cp -a ../debian/ nuspell-$VERSION

# create orig tar with excluded files deleted
cd nuspell-$VERSION
ORIG=nuspell_$VERSION.orig.tar.xz
mk-origtargz ../$TAR
cd ..
if [ -e nuspell_$VERSION.orig.tar.gz ]; then # for at least Ubuntu Bionic 1804
	gunzip < nuspell_$VERSION.orig.tar.gz | xz > $ORIG
	rm -f nuspell_$VERSION.orig.tar.gz
fi
rm -rf ./nuspell-$VERSION
rm -f $TAR

tar -xf $ORIG
# debianize new ORIG
cp -a ../debian/ nuspell-$VERSION
cd nuspell-$VERSION
dpkg-buildpackage --no-sign
# debuild -S # use debuild for sending to debian, launchpad etc.
cd ..
