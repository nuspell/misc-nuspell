# AppImage

Building an AppImage can best be done in a CI environment such as Travis.

# Build

Make sure that `Nuspell.yml` refers to the latest Ubuntu LTS release and run:

    ./build.sh.

which will create an AppImage in the `out` directory and test it too.

## Clean up

Clean up can be done with:

    rm -rf Nuspell

## Publish

Publish the AppImage by:
- including it in a release:
- updating the [apps at AppImageHub](https://github.com/AppImage/appimage.github.io/tree/master/apps)
- updating the [recipes at pkg2appimage](https://github.com/AppImage/pkg2appimage/tree/master/recipes)
