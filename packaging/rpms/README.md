# 2.1 Fedora

# Prerequisites

    sudo dnf install cmake make gcc-c++ libicu-devel boost-devel rubygem-ronn

Build with the following commands:

    wget https://github.com/nuspell/nuspell/archive/v2.3.0.tar.gz
    tar xf v2.3.0.tar.gz
    cd nuspell-2.3.0
    mkdir build
    cd build
    cmake .. -DBUILD_SHARED_LIBS=ON -DBUILD_TESTING=OFF
    cmake --build . --target all
    sudo cmake --build . --target install
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib64
    export LD_LIBRARY_PATH
    nuspell -h
