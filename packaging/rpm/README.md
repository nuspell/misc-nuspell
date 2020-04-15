# 2.1 Fedora

## Prerequisites

    sudo dnf install cmake make gcc-c++ libicu-devel boost-devel rubygem-ronn

## Manual build

Build manually with

    wget https://github.com/nuspell/nuspell/archive/v3.1.0.tar.gz
    tar xf v3.1.0.tar.gz
    cd nuspell-3.1.0
    mkdir build
    cd build
    cmake .. -DBUILD_SHARED_LIBS=ON -DBUILD_TESTING=OFF
    cmake --build . --target all
    sudo cmake --build . --target install
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib64
    export LD_LIBRARY_PATH
    nuspell -h
    nuspell -D

## Building source and binary packages

Build source and binary packages with

    sudo dnf install rpm-build
    git clone https://github.com/nuspell/misc-nuspell.git
    cd misc-nuspell/package/rpmbuild
    ./build.sh

Note that this will do work in `~/rpmbuild`

Additional checks can be done with

    cd ~
    sudo mock --verbose SRPMS/nuspell-3.1.0-0.src.rpm
    rpmbuild -rb SRPMS/nuspell-$VERSION-*.src.rpm
    sudo rpm -U RPMS/*/nuspell-$VERSION-*.*.rpm
    nuspell -h
    nuspell -D

Notes on spec file:
* all cmake commands should have ` .` at the end to avoid errors
* for profiling, use https://github.com/nuspell/homebrew-nuspell/blob/master/Formula/nuspell.rb#L54 and https://src.fedoraproject.org/rpms/hunspell/blob/master/f/hunspell.spec
* for make check, remove `-DBUILD_TESTING=OFF` and use https://docs.fedoraproject.org/en-US/packaging-guidelines/CMake/

## Inclusion Fedora

Temporarily, a `.src.rpm` will be here to get this package included into Fedora.
See https://fedoraproject.org/wiki/Package_Review_Process
