# AppImage

There are 4 different way to crete an AppImage in this directory.

1. With Linuxdeploy + docker. Docker is used to get the oldest supported Ubuntu
   LTS which is 16.04.
2. With pkg2appimage which converts deb-packages. This is less portable as we
   provide deb-packages for Ubuntu 18.04 and upwards, and generally is has more
   steps because it requires those deb packages.
3. With AppImage-Builder from deb packages. This one is portable even when done
   on newer distributions because it properly packages the standard libraries of
   C and C++. It makes the AppImage bigger.
4. With AppImage-Builder from source. It is similar to number 4.

Of all these, number 1 is currently supported and the most updated. ATM the
minimal version of GCC to build is v7, but to run, only v5 of `libstdc++.so` is
needed, which is already the one on Ubuntu 16.04. That is because most C++14 and
C++17 features are header-only. When newer standard library will be needed at
running time, do one of the following:

- Package C++ standard library with [linuxdeploy-plugin-checkrt](https://github.com/linuxdeploy/linuxdeploy-plugin-checkrt).
- Switch to method 4 for building.
- Wait for Ubuntu 16.04 to become obsolete, change docker in method one to
  use 18.04 and do nothing more.

## Linuxdeploy + docker

Just run `build-with-docker.sh`.

## pkg2appimage

Just run `old-build-from-deb.sh`.

## AppImage-Builder

Install:

```sh
sudo apt install -y python3-pip python3-setuptools patchelf desktop-file-utils libgdk-pixbuf2.0-dev
sudo wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O /usr/local/bin/appimagetool
sudo chmod +x /usr/local/bin/appimagetool
sudo pip3 install -U appimage-builder
sudo apt install docker.io
sudo addgroup YOURUSERNAME docker
```

The last line enables running the docker tests with a normal user account.


- To build from deb run `appimage-builder`.
- To build from source run `appimage-builder --recipe AppImageBuilder-src.yml`

## Publish

Publish the AppImage by:
- adding to the Nuspell release on [GitHub](https://github.com/nuspell/nuspell/releases)
- updating the [apps at AppImageHub](https://github.com/AppImage/appimage.github.io/tree/master/apps)
