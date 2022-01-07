# AppImage

There are 4 different way to crete an AppImage.

1. With Linuxdeploy + docker. Docker is used to get the oldest supported Ubuntu
   LTS which is 18.04.
2. With pkg2appimage which converts deb-packages. This can be less portable if
   there are no debs for the oldest supprted Ubuntu version, and generally is
   has more steps because it requires those deb packages.
3. With AppImage-Builder from deb packages. This one is portable even when done
   on newer distributions because it properly packages the standard libraries of
   C and C++. It makes the AppImage bigger.
4. With AppImage-Builder from source. It is similar to number 4.

Of all these, number 1 is currently supported and the most updated. A possible
future portability problem with that way is if the app requres newer libstdc++
than the one provided in the oldest supported Ubuntu. ATM the
minimal version of GCC to build is v8, but to run, only v5 of `libstdc++.so`, so
it is OK.

## Linuxdeploy + docker

Just run `build-with-docker.sh`.

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


- To build from source run `appimage-builder`

## Publish

Publish the AppImage by:
- adding to the Nuspell release on [GitHub](https://github.com/nuspell/nuspell/releases)
- updating the [apps at AppImageHub](https://github.com/AppImage/appimage.github.io/tree/master/apps)
