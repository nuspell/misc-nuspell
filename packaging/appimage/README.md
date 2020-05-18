# AppImageBuilder

Building an AppImage can best be done in a CI environment such as Travis. See
also files for Flatpak and keep these in sync.

## Requirements

Install:

    sudo apt install -y python3-pip python3-setuptools patchelf desktop-file-utils libgdk-pixbuf2.0-dev
    sudo wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O /usr/local/bin/appimagetool
    sudo chmod +x /usr/local/bin/appimagetool
    sudo pip3 install appimage-builder
    sudo apt-get install docker.io

## Build and Test

To build and test, run:

    ./build.sh
    
This will build for several Ubuntu LTS releases, for test purposes. Probably,
the build of the oldest LTS version should be published for download.

The warning:

    WARNING:appimagetool:WARNING: AppStream upstream metadata is missing, please consider creating it

has been temporarily suppressed by commenting out the metadata copy in YML. This
results in another warning:

    WARNING:root:Unable to locate the application desktop entry: org.nuspell.Nuspell.desktop

which can be ignored.

## Cleanup

Clean up can be done with:

    rm -rf AppDir appimage-builder-cache Nuspell*.AppImage

## Publish

Publish the AppImage by:
- adding to the Nuspell release on GitHub
- updating the [apps at AppImageHub](https://github.com/AppImage/appimage.github.io/tree/master/apps)
