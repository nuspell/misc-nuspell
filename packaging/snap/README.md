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
    sudo snap install hunspell-dictionaries-1-6-1804

which will create a directory called `snap` with a file called `snapcraft.yaml`.

## Build

Login to Snapcraft via Ubuntu One with:

    sudo snap login NUSPELL_DEVOPS_EMAIL_ADDRESS

From the top-level directory or from the `snap` directory, run:

    snapcraft

When asked to setup support for multipass, answer yes with `y`. This to build it
locally. Test with:

    sudo snap install nuspell_4.0.0_amd64.snap --dangerous

The dangerous option omits signature searching. Do not use the devmode option
as the application will not run in strict confinement.

Note that the `snap` directory has to be in the top-level directory. This is
required for building with snapcraft.io

Additionally, the NuspellDevOps user needs to have admin rights to this
repository in order to use this build service. That is the way to build and
distribute this Snap, see below.

Practical commands are:

    snap list nuspell
    snap find nuspell
    snap info nuspell
    snap install nuspell
    snap remove --purge nuspell

## Clean up

Clean up can be done with:

    snapcraft clean nuspell

## Publish

Publish the Snap via the webinterface in https://snapcraft.io/nuspell/
