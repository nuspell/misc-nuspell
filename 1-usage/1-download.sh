#!/usr/bin/env bash

if [ -e debs ]
then
    rm -rf debs
fi
mkdir debs

cd debs
apt-get download `apt-cache search hunspell|grep ^hunspell|grep dict|awk '{print $1}'|grep -v ^hunspell-fr$|tr '\n' ' '`  # hunspell-fr is a dependency package
cd ..
