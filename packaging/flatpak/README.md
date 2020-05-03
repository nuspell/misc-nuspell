# Flatpak

Building a Flatpak can best be done in a CI environment such as Travis. See also
the files for AppImage and keep these in sync.

## Requirements

Install for Flatpak:

    sudo apt-get install flatpak-builder
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub
    flatpak install -y org.freedesktop.Platform//18.08 org.freedesktop.Sdk//18.08

Installf for Boost:

    sudo apt-get install elfutils

## Build

Make sure the version number and checksum of Nuspell in
`org.nuspell.Nuspell.json` are up to date and `runtime-version` refers to the
proper release as seen above. Then run:

    ./build.sh

which will create a Flatpak and test it too. The warning `Ronn not found` can be
ignored. Note that in the JSON file, the desktop launcher and icon file are to
be copied, not only moved.

## Clean up

Clean up can be done with:

    flatpak uninstall -y --unused
    rm -rf .flatpak-builder build-dir

## Publish

Publish the Flatpak by:
- updating the [apps at Flathub](https://github.com/flathub/flathub/tree/new-pr)
