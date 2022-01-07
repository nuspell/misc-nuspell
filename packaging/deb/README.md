# Building packages

## Debian

Install the following packages

    build-essential \
    cmake \
    dpkg-dev \
    debhelper \
    devscripts \
    fakeroot \
    g++ \
    libgpgmepp6 \
    libboost-locale-dev \
    libicu-dev \
    pandoc \
    wget

Then run

    ./build.sh

to create source and binary packages.

Building has been successfully tested on
* Ubuntu ([PPA](https://launchpad.net/~nuspell/+archive/ubuntu/ppa/+packages))
    * 20.10 Groovy on amd64 (x86_64), arm64, armhf (3.1.2 / 4.1.0)
    * 20.04 Focal on amd64 (x86_64), arm64, armhf (3.0.0 / 4.1.0)
    * 19.10 Eoan on amd64 (x86_64), arm64, armhf, i386 (3.0.0 / 3.1.2, EOL)
    * 19.04 Disco on amd64 (x86_64), arm64, armhf, i386 (only 3.0.0, EOL)
    * 18.04 Bionic on amd64 (x86_64), arm64, armhf, i386 (3.0.0 / 4.1.0)
* Debian
    * 10 Buster on amd64 (x86_64) (3.0.0 / 4.0.0)
* Raspbian
    * 10 Buster on armhf (armv7l) (3.0.0 / 4.0.0)
