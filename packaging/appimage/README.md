# AppImage

Building an AppImage can best be done in a CI environment such as Travis. See
also files for Flatpak and keep these in sync.

## Requirements

The build step will take care of requirements.

## Build

Make sure that `Nuspell.yml` refers to the latest Ubuntu LTS release and run:

    ./build.sh.

which will create an AppImage in the `out` directory and test it too. Note that
in the YAML file, the desktop launcher and icon file are to be copied, not only
moved.

To build not from the PPA, use the script `./build-from-source.sh`.

## Clean up

Clean up can be done with:

    rm -rf Nuspell

## Publish

Publish the AppImage by:
- updating the [apps at AppImageHub](https://github.com/AppImage/appimage.github.io/tree/master/apps)
- updating the [recipes at pkg2appimage](https://github.com/AppImage/pkg2appimage/tree/master/recipes) which is pending https://github.com/AppImage/pkg2appimage/pull/421
