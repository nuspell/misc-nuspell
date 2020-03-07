# 2.1 Fedora

## Prerequisites

    sudo dnf install cmake make gcc-c++ libicu-devel boost-devel rubygem-ronn

## Manual build

Build manually with

    wget https://github.com/nuspell/nuspell/archive/v3.0.0.tar.gz
    tar xf v3.0.0.tar.gz
    cd nuspell-3.0.0
    mkdir build
    cd build
    cmake .. -DBUILD_SHARED_LIBS=ON -DBUILD_TESTING=OFF
    cmake --build . --target all
    sudo cmake --build . --target install
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib64
    export LD_LIBRARY_PATH
    nuspell -h

## Building source and binary packages

Build source and binary packages with

    sudo dnf install rpm-build
    git clone https://github.com/nuspell/misc-nuspell.git
    cd misc-nuspell/package/rpmbuild
    ./build-fedora.sh
    sudo mock --verbose SRPMS/nuspell-3.0.0-0.src.rpm
