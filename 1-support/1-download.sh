#!/usr/bin/env bash

# author: Sander van Geloven
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# description: downloads packages with Hunspell language support

platform=`../0-tools/platform.sh`

if [ -e packages ]; then
	rm -rf packages
fi
mkdir packages

# See 3-report.sh regarding omitting packages.
cd packages
if [ $platform = linux ]; then
	apt-get update
	apt-get download myspell-eo myspell-et myspell-fa myspell-fo myspell-ga myspell-gv myspell-lv myspell-tl `apt-cache search hunspell|grep ^hunspell|grep dict|awk '{print $1}'|grep -v ^hunspell-fr$|grep -v ^hunspell-fr-classical$|grep -v ^hunspell-fr-modern$|grep -v ^hunspell-fr-revised$|grep -v ^hunspell-gl$|tr '\n' ' '`
elif [ $platform = freebsd ]; then
	sudo pkg fetch -o . -y `pkg search hunspell | grep ^[a-z][a-z]-hunspell | awk -F '-' '{print $1"-"$2}' | tr '\n' ' '`
        if [ -d All ]; then
		sudo mv All/* .
		sudo rmdir All
		sudo chown freebsd:freebsd *
	fi
fi
cd ..
