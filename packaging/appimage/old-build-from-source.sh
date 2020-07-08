# Alternative way of creating Appimage, without the need for deb files

set -e
cd "$(dirname "$0")"
rm -rf out
mkdir out
cd out
if [ ! -e linuxdeploy-x86_64.AppImage ]; then
	wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
	chmod +x linuxdeploy-x86_64.AppImage
fi
if [ ! -e org.nuspell.Nuspell.png ]; then
	wget https://raw.githubusercontent.com/nuspell/nuspell.github.io/master/assets/images/logo-white-512x512.png -O org.nuspell.Nuspell.png
fi
VERSION=3.1.2
wget https://github.com/nuspell/nuspell/archive/v${VERSION}.tar.gz -O - | tar -xz
rm -rf build AppDir
mkdir build
cd build
cmake ../nuspell-$VERSION -DBUILD_SHARED_LIBS=1 -DBUILD_TESTING=0 \
      -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_INSTALL_LIBDIR=lib
make -j2
cd ..
#mkdir -p ./AppDir/usr/share/metainfo
#cp ../../appstream/org.nuspell.Nuspell.metainfo.xml ./AppDir/usr/share/metainfo/org.nuspell.Nuspell.appdata.xml
export VERSION
LD_PRELOAD=
./linuxdeploy-x86_64.AppImage \
	--appdir=AppDir -e build/src/nuspell/nuspell \
	-d ../org.nuspell.Nuspell.desktop \
	-i org.nuspell.Nuspell.png -o appimage

#test
./Nuspell-$VERSION-x86_64.AppImage -D
