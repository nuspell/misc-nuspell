# Snap

Building an AppImage can best be done in a CI environment such as Travis. See
also files for Flatpak and keep these in sync.

## Requirements

Install Snap (skip on Ubuntu):

    sudo apt-get install snapd

Install snapcraft (snap build tool):

    sudo snap install snapcraft --classic

## Build

Run from the top-level directory:

    snapcraft

When asked to setup support for multipass, answer yes with `y`. This to build it
locally. Test the package with:

    sudo snap install nuspell_*_amd64.snap --dangerous
    sudo snap connect nuspell:hunspell-dictionaries \
                      hunspell-dictionaries-1-6-1804:hunspell-dictionaries

The dangerous option omits signature searching. Do not use the devmode option
as the application will not run in strict confinement.

Note that the `snap` directory has to be in the top-level directory. This is
required for automated building with snapcraft.io.

## Clean up

Clean up can be done with:

    snapcraft clean nuspell

## Publish

Publish the Snap via the webinterface in https://snapcraft.io/nuspell/
