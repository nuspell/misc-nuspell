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

    ./build-debian.sh

Building has been successfully tested on
* ubuntu-eoan-x86_64
* ubuntu-bionic-x86_64
* debian-buster-x86_64
* raspbian-buster-armv7l

Note that the build script does not yet support other patch
levels than 1 (`-1`).

## Fedora

TODO
