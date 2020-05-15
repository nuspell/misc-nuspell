# AppImageBuilder

Building an AppImage can best be done in a CI environment such as Travis. See
also files for Flatpak and keep these in sync.

## Requirements

Install:

    sudo apt install -y python3-pip python3-setuptools patchelf desktop-file-utils libgdk-pixbuf2.0-dev
    sudo wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O /usr/local/bin/appimagetool
    sudo chmod +x /usr/local/bin/appimagetool
    sudo pip3 install appimage-builder

## Build

Build on Ubuntu Focal with:

   appimage-builder --recipe AppImageBuilderFocal.yml --skip-test

Build on Ubuntu Bionic with:

   appimage-builder --recipe AppImageBuilderBionic.yml --skip-test

Not sure if need to fix this warning:

    WARNING:appimagetool:WARNING: AppStream upstream metadata is missing, please consider creating it

See also comments in YML file for Bionic.


## Test

Testing can be done with:

    ./Nuspell-latest-x86_64.AppImage -D

which should list the dictionaries installed on the host system, not inside the
AppImage.

## Cleanup

TODO

## Publish

TODO
