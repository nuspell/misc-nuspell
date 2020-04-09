# Flatpak

This file is under development!

## Requirements

Install:

    sudo apt-get install flatpak-builder

## Build

Make sure the version number in `org.nuspell.Nuspell.yaml` is up to date.

    #mkdir nuspell_flatpak src
    #cd nuspell_flatpak
    #wget https://github.com/nuspell/nuspell/archive/v3.1.0.tar.gz
    #cd ..
    flatpak-builder build-dir org.nuspell.Nuspell.yaml

TODO currently stuck at:

    error: org.freedesktop.Sdk/x86_64/18.08 not installed
    Failed to init: Unable to find sdk org.freedesktop.Sdk version 18.08

## Test

Test with:

    flatpak-builder --run build-dir org.nuspell.Nuspell.yaml nuspell -D

## Publish

Publish the flatpak by:
- including it in a release:
- updating the [apps at Flathub](https://github.com/flathub/flathub/tree/new-pr)
- updating the [recipes at pkg2appimage](https://github.com/AppImage/pkg2appimage/tree/master/recipes)
