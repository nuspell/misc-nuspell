# Flatpak

Building a Flatpak can best be done in a CI environment such as Travis.

## Requirements

Install:

    sudo apt-get install flatpak-builder
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub
    flatpak install -y org.freedesktop.Platform//18.08 org.freedesktop.Sdk//18.08
#    flatpak install -y org.gnome.Platform//3.32 org.gnome.Sdk//3.32

## Build

Make sure the version number and checksum of Nuspell in
`org.nuspell.Nuspell.yaml` are up to date and `runtime-version` refers to the
proper release as seen above. Then run:

    ./build.sh

which will create a Flatpak and test it too.

TODO currently stuck at:

    error: org.freedesktop.Sdk/x86_64/18.08 not installed
    Failed to init: Unable to find sdk org.freedesktop.Sdk version 18.08

## Clean up

Clean up can be done with:

    flatpak uninstall -y --unused

## Publish

Publish the Flatpak by:
- including it in a release:
- updating the [apps at Flathub](https://github.com/flathub/flathub/tree/new-pr)
- updating the [recipes at pkg2appimage](https://github.com/AppImage/pkg2appimage/tree/master/recipes)
