# Flatpak

Building a Flatpak can best be done in a CI environment such as Travis. See also
the files for AppImage and keep these in sync.

## Requirements

Install for Flatpak:

    sudo apt-get install flatpak-builder
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub org.freedesktop.appstream-glib
    flatpak install -y org.freedesktop.Platform//19.08 org.freedesktop.Sdk//19.08
    
Install for Boost:

    sudo apt-get install elfutils

## Validate

The desktop file is generated from the JSON file. The specific lines can be
saved to a temporary file and validated with `desktop-file-validate`. Other
validation is done by the build script.

## Build

Make sure the version number, release dates and checksums in
`org.nuspell.Nuspell.json` are up to date and `runtime-version` refers to the
proper release as seen above. Then run:

    ./build.sh

which will create a Flatpak and test it too. The warning `Ronn not found` can be
ignored. The end of the build script will also run a test.

## Clean up

Clean up can be done with:

    flatpak uninstall -y --unused
    rm -rf .flatpak-builder build-dir

## Publish

Publish the Flatpak by:
- updating the [apps at Flathub](https://github.com/flathub/flathub/tree/new-pr) which is pending https://github.com/flathub/flathub/pull/1502
