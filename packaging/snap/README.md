# Snap

Building an AppImage can best be done in a CI environment such as Travis. See
also files for Flatpak and keep these in sync.

## Requirements

Install Snap:

    sudo apt-get install snapd

Test with:

    snap version
    snap find 'spell checker'
    snap info languagetool
    snap list

## Initialization

To start for the first time, run:

    sudo snap install snapcraft --classic

which will create a directory called `snap` with a file called `snapcraft.yaml`.

## Build

Login to Snapcraft via Ubuntu One with:

    sudo snap login NUSPELL_DEVOPS_EMAIL_ADDRESS

From the top-level directory or from the `snap` directory, run:

    snapcraft

When asked to setup support for multipass, answer yes with `y`.




snap refresh
snap list nuspell
snap find nuspell
snap info nuspell
snap install nuspell
snap remove nuspell



Make sure that `Nuspell.yml` refers to the latest Ubuntu LTS release and run:

    ./build.sh.

which will create an AppImage in the `out` directory and test it too. Note that
in the YAML file, the desktop launcher and icon file are to be copied, not only
moved.

## Clean up

Clean up can be done with:

    rm -rf Nuspell

## Publish

Publish the AppImage by:
- updating the [apps at AppImageHub](https://github.com/AppImage/appimage.github.io/tree/master/apps)
- updating the [recipes at pkg2appimage](https://github.com/AppImage/pkg2appimage/tree/master/recipes)
