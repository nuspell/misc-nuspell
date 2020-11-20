WORK IN PROGRESS

Package for Conan.

Prepare:

    sudo pip3 install conan
    conan install icu/67.1@ --build missing
    conan search icu
    conan install boost/1.71.0@ --build missing
    conan search boost

After changing `conanfile.py`:

    conan export .
    conan search nuspell
    cd test
    rm -rf build
    mkdir build
    cd build
    conan install .. --build=missing
    conan info ..
    cmake ..
    cmake --build . --config Release

Cleaning can be done with:

    conan remove "*" -f
