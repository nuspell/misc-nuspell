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
VERSION=3.1.1
wget https://github.com/nuspell/nuspell/archive/v${VERSION}.tar.gz -O - | tar -xz
rm -rf build AppDir
mkdir build
cd build
cmake ../nuspell-$VERSION -DBUILD_SHARED_LIBS=1 -DBUILD_TESTING=0 \
      -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_INSTALL_LIBDIR=lib
make -j2
cd ..
export VERSION
LD_PRELOAD=
./linuxdeploy-x86_64.AppImage \
	--appdir=AppDir -e build/src/nuspell/nuspell \
	-d ../../flatpak/org.nuspell.Nuspell.desktop \
	-i org.nuspell.Nuspell.png -o appimage

#test
./Nuspell-$VERSION-x86_64.AppImage -D
