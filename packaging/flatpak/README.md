# Flatpak

Building a Flatpak can best be done in a CI environment such as Travis.

## Requirements

Install for Flatpak:

    sudo apt-get install flatpak-builder
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub
    flatpak install -y org.freedesktop.Platform//18.08 org.freedesktop.Sdk//18.08
#    flatpak install -y org.gnome.Platform//3.32 org.gnome.Sdk//3.32

Installf for Boost:

    sudo apt-get install elfutils

## Build

Make sure the version number and checksum of Nuspell in
`org.nuspell.Nuspell.yaml` are up to date and `runtime-version` refers to the
proper release as seen above. Then run:

    ./build.sh

which will create a Flatpak and test it too. The warning `Ronn not found` can be
ignored.

## Clean up

Clean up can be done with:

    flatpak uninstall -y --unused
    rm -rf .flatpak-builder build-dir

## Publish

Publish the Flatpak by:
- including it in a release:
- updating the [apps at Flathub](https://github.com/flathub/flathub/tree/new-pr)
- updating the [recipes at pkg2appimage](https://github.com/AppImage/pkg2appimage/tree/master/recipes)





To fix:

-- The C compiler identification is GNU 8.3.0
-- The CXX compiler identification is GNU 8.3.0
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Check for working CXX compiler: /usr/bin/c++
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Found the following ICU libraries:
--   uc (required)
--   data (required)
-- Found ICU: /usr/include (found version "62.1") 
CMake Error at /usr/share/cmake-3.13/Modules/FindBoost.cmake:2100 (message):
  Unable to find the requested Boost libraries.

  Unable to find the Boost header files.  Please set BOOST_ROOT to the root
  directory containing Boost or BOOST_INCLUDEDIR to the directory containing
  Boost's headers.
Call Stack (most recent call first):
  CMakeLists.txt:9 (find_package)


CMake Warning at docs/CMakeLists.txt:4 (message):
  Ronn not found, generating man-pages will be skipped


-- Configuring incomplete, errors occurred!
See also "/run/build/nuspell/CMakeFiles/CMakeOutput.log".
Error: module nuspell: Child process exited with code 1
