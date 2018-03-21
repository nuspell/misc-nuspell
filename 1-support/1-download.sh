#!/usr/bin/env bash

if [ -e debs ]; then
	rm -rf debs
fi
mkdir debs

cd debs
# See 3-report.sh regarding omitting packages.
apt-get download `apt-cache search hunspell|grep ^hunspell|grep dict|awk '{print $1}'|grep -v ^hunspell-fr$|grep -v ^hunspell-fr-classical$|grep -v ^hunspell-fr-modern$|grep -v ^hunspell-fr-revised$|grep -v ^hunspell-gl$|tr '\n' ' '`
cd ..
