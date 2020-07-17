# AppImage

## Requirements

Install:

    sudo apt install -y python3-pip python3-setuptools patchelf desktop-file-utils libgdk-pixbuf2.0-dev
    sudo wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O /usr/local/bin/appimagetool
    sudo chmod +x /usr/local/bin/appimagetool
    sudo pip3 install -U appimage-builder
    sudo apt install docker.io
    sudo addgroup YOURUSERNAME docker

The last line enables running the docker tests with a normal user account.

This build methoed uses Nuspell source files from Launchpad. Any version upgrade
should be done there firstly.

## Build and Test

To build AppImage, run:

    ./build.sh
    
To test the portability of the appimage on various Linux distributions in docker
containers run:

    ./test.sh

## Troubleshooting

When this error occurs:

    FileNotFoundError: [Errno 2] No such file or directory: '/home/USERNAME/WORKSPACE/misc-nuspell/packaging/appimage/AppDir/usr/local/lib/x86_64-linux-gnu/libapprun_hooks.so'

a workaround is:

    cd AppDir/usr
    mkdir local
    cd local
    ln -s ../lib

## Cleanup

Clean up can be done with:

    rm -rf AppDir appimage-builder-cache Nuspell*.AppImage

## Publish

Publish the AppImage by:
- adding to the Nuspell release on [GitHub](https://github.com/nuspell/nuspell/releases)
- updating the [apps at AppImageHub](https://github.com/AppImage/appimage.github.io/tree/master/apps)
