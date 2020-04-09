# Flatpak

This file is under development!

## Requirements

Install:

    sudo apt-get install flatpak-builder

## Build

Make sure the version number and checksum in `org.nuspell.Nuspell.yaml` are up
to date. Then run:

    ./build.sh

which will create a Flatpak and test it too.

TODO currently stuck at:

    error: org.freedesktop.Sdk/x86_64/18.08 not installed
    Failed to init: Unable to find sdk org.freedesktop.Sdk version 18.08

## Publish

Publish the Flatpak by:
- including it in a release:
- updating the [apps at Flathub](https://github.com/flathub/flathub/tree/new-pr)
- updating the [recipes at pkg2appimage](https://github.com/AppImage/pkg2appimage/tree/master/recipes)
