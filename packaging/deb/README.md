# Building packages

## Debian

Install the following packages

    build-essential \
    dpkg-dev \
    debhelper \
    devscripts \
    fakeroot \
    wget \
    g++ \
    libgpgmepp6 \
    cmake \
    libboost-locale-dev \
    libicu-dev

for newer operating systems, also install

    ronn

or for older systems, install

    ruby-ronn

Then run

    ./build.sh

to create source and binary packages.

Building has been successfully tested on
* Ubuntu ([PPA](https://launchpad.net/~nuspell/+archive/ubuntu/ppa/+packages))
    * 20.04 Focal on amd64 (x86_64), arm64, armhf
    * 19.10 Eoan on amd64 (x86_64), arm64, armhf, i386
    * 19.04 Disco on amd64 (x86_64), arm64, armhf, i386
    * 18.04 Bionic on amd64 (x86_64), arm64, armhf, i386
* Debian
    * 10 Buster on amd64 (x86_64)
* Raspbian
    * 10 Buster on armhf (armv7l)

## PPA

For uploading Ubuntu source packages to the PPA on Launchpad, install `dput` and
then run:

    ./submit-launchpad.sh

In case the dput lintian rejects a too new or too old Standards-Version, build
and submit from a (virtual) system for that specific distribution release.
