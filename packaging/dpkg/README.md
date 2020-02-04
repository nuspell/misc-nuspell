# Packaging for Debian, Ubuntu, etc.

This directory contains a script that will generate soure package for the
operating system you are currently using. First, install `dpkg-dev`, `debhelper`
and `fakeroot`, but also `git g++ cmake libboost-locale-dev libicu-dev`.
Then simply run `./build.sh` in order to build packages for your system.
