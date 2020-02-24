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
* Ubuntu ([PPA](https://launchpad.net/~nuspell/+archive/ubuntu/ppa/+packages))
    * 19.10 Eoan on x86_64
    * 18.04 Bionic on x86_64
* Debian
    * 10 Buster on x86_64
* Raspbian
    * 10 Buster on armv7l

Note that the build script does not yet support other patch
levels than 1 (`-1`).

## Fedora

TODO
