set -e # -e for automatic error handling
cd "$(dirname "$0")"
rm -rf out
mkdir out
cd out
wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
chmod +x linuxdeploy-x86_64.AppImage
wget https://raw.githubusercontent.com/nuspell/nuspell.github.io/master/assets/images/logo-white-512x512.png -O org.nuspell.Nuspell.png
VERSION=5.0.1
wget https://github.com/nuspell/nuspell/archive/v${VERSION}.tar.gz -O - | tar -xz

mkdir build
cd build
cmake ../nuspell-$VERSION -DBUILD_TESTING=0 -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=0 -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_INSTALL_LIBDIR=lib
make -j `nproc`
cd ..
./linuxdeploy-x86_64.AppImage --appimage-extract
LINUXDEPLOY=squashfs-root/AppRun
LD_PRELOAD=
export VERSION
"$LINUXDEPLOY" --appdir=AppDir -e build/src/tools/nuspell \
	-d ../org.nuspell.Nuspell.desktop \
	-i org.nuspell.Nuspell.png -o appimage
