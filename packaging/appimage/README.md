# AppImage

## Requirements

Install:

    sudo apt install -y python3-pip python3-setuptools patchelf desktop-file-utils libgdk-pixbuf2.0-dev
    sudo wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O /usr/local/bin/appimagetool
    sudo chmod +x /usr/local/bin/appimagetool
    sudo pip3 install appimage-builder
    sudo apt install docker.io

## Build and Test

To build AppImage, run:

    ./build.sh
    
To test the portability of the appimage on various Linux distributions in docker
containers run:

    ./test.sh

## Cleanup

Clean up can be done with:

    rm -rf AppDir appimage-builder-cache Nuspell*.AppImage

## Publish

Publish the AppImage by:
- adding to the Nuspell release on GitHub
- updating the [apps at AppImageHub](https://github.com/AppImage/appimage.github.io/tree/master/apps)
