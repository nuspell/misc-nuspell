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

To start for the first time, run in the top-level directory:

    sudo snap install snapcraft --classic

which will create a directory called `snap` with a file called `snapcraft.yaml`.

## Build

Login to Snapcraft via Ubuntu One with:

    sudo snap login NUSPELL_DEVOPS_EMAIL_ADDRESS

From the top-level directory or from the `snap` directory, run:

    snapcraft

When asked to setup support for multipass, answer yes with `y`.

Note that the `snap` directory has to be in the top-level directory. This is
required for building with snapcraft.io

Additionally, the NuspellDevOps user needs to have admin rights to this
repository in order to use this build service.


snap refresh
snap list nuspell
snap find nuspell
snap info nuspell
snap install nuspell
snap remove nuspell

## Clean up

Clean up can be done with:

    rm -rf Nuspell

## Publish

Publish the AppImage by:
- updating the [apps at AppImageHub](https://github.com/AppImage/appimage.github.io/tree/master/apps)
- updating the [recipes at pkg2appimage](https://github.com/AppImage/pkg2appimage/tree/master/recipes)
