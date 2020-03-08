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

Additional checks can be donw with

    sudo mock --verbose SRPMS/nuspell-3.0.0-0.src.rpm
    rpmbuild -rb SRPMS/nuspell-$VERSION-*.src.rpm

Notes on spec file:
* all cmake commands should have ` .` at the end to avoid errors
* for profiling, use https://github.com/nuspell/homebrew-nuspell/blob/master/Formula/nuspell.rb#L54 and https://src.fedoraproject.org/rpms/hunspell/blob/master/f/hunspell.spec
* for make check, remove `-DBUILD_TESTING=OFF` and use https://docs.fedoraproject.org/en-US/packaging-guidelines/CMake/

