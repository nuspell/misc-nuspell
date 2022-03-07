# Nuspell packaging scripts

Here we keep some scripts that create packages with Nuspell for various
platforms. Most of the packaging scripts are located in the repositories for
packages of the platform, but for some popular platforms we keep the scripts
here.

## Debian and Ubuntu

For our script look inside the directory [deb/](deb).

For the official debian pacakge see:

- [Info page](https://packages.debian.org/source/bullseye/nuspell),
- [Script source](https://salsa.debian.org/alteholz/nuspell).

## Homebrew (for macOS)

The Formula for Nuspell is in `nuspell.rb`. This currently resides in
the following tap: https://github.com/nuspell/homebrew-nuspell. Nuspell is still
not available in the official Homebrew repositories.


This tap in installed by

    brew tap nuspell/nuspell
    brew install nuspell

## Appimage (universal Linux package)

See the directory [appimage/](appimage).

## Flatpak (universal Linux package)

The package script has been put into the [upstream repository](https://github.com/flathub/org.nuspell.Nuspell).
See the official [docs for flatpak-builder](https://docs.flatpak.org/en/latest/building-introduction.html)
to see how to build it.

## Snappy (universal Linux package)

See the directory [../snap/](../snap).

### Requirements

Install Snap (skip on Ubuntu):

    sudo apt-get install snapd

Install snapcraft (snap build tool):

    sudo snap install snapcraft --classic

### Build

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

### Clean up

Clean up can be done with:

    snapcraft clean nuspell

### Publish

Publish the Snap via the webinterface in https://snapcraft.io/nuspell/


## RPM (Fedora, openSUSE, etc.)

For the official Fedora pacakge see:

- [Script source](https://src.fedoraproject.org/rpms/nuspell)
- [Build info](https://koji.fedoraproject.org/koji/packageinfo?packageID=31132)

See tutorial [how to make a RPM package](https://www.golinuxcloud.com/how-to-create-rpm-package-in-linux/).
See official docs [how to make a RPM package](https://docs.fedoraproject.org/en-US/quick-docs/creating-rpm-packages/).
