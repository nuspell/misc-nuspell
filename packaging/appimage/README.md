# AppImage

Building an AppImage can best be done in a CI environment such as Travis.

## Requirements

Get the latest version of `pkg2appimage` with:

    wget https://github.com/AppImage/pkg2appimage/archive/master.zip
    unzip master.zip && rm -f master.zip

## Build

Make sure that `Nuspell.yml` refers to the latest Ubuntu LTS release.

Then, an AppImage will be created in the `out` directory by running:

    pkg2appimage-master/pkg2appimage Nuspell.yml

Rename the output to more conventional filename:

    cd out
    mv -f Nuspell-3.0.0.glibc2.14-x86_64.AppImage Nuspell-3.0.0-x86_64.AppImage

## Test

It can be tested with e.g.:

    ./Nuspell-3.0.0-x86_64.AppImage -D

and

    echo hello | ./Nuspell-3.0.0-x86_64.AppImage -d /usr/share/hunspell/en_US

Note that the AppImage is using dictionaries installed on the system it runs.

## Clean up

Clean up can be done with:

    sudo dpkg -P nuspell libnuspell3
    cd ..
    rm -rf Nuspell

## Publish

Publish the AppImage by:
- including it in a release:
- updating the [apps at AppImageHub](https://github.com/AppImage/appimage.github.io/tree/master/apps)
- updating the [recipes at pkg2appimage](https://github.com/AppImage/pkg2appimage/tree/master/recipes)
