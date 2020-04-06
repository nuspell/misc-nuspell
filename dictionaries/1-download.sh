#!/usr/bin/env sh

# description: Downloads dictionary packages
# license: https://github.com/nuspell/nuspell/blob/master/COPYING.LESSER
# author: Sander van Geloven

if [ -e packages ]; then
	rm -f packages/*
else
    mkdir packages
fi
cd packages

# Only package names which start with myspell-, hunspell- or nuspell-,
# except any dummy transitional packages or packages with tools.
PACKAGES=$(apt-cache search 'myspell|hunspell|nuspell'|grep -E '^myspell-|^hunspell-|^nuspell-'|grep -iv transitional|grep -iv dummy|awk '{print $1}'|grep -v tools|tr '\n' ' ')

apt-get download $(echo $PACKAGES|sort)

# Frisian
wget --quiet https://raw.githubusercontent.com/PanderMusubi/frisian/master/packages/hunspell-fy_latest_all.deb
wget $(echo https://raw.githubusercontent.com/PanderMusubi/frisian/master/packages/|awk -F 'hunspell-fy_latest_all.deb' '{print $1}')$(cat hunspell-fy_latest_all.deb)
rm -f hunspell-fy_latest_all.deb

# Klingon
wget --quiet https://raw.githubusercontent.com/PanderMusubi/klingon/master/packages/hunspell-tlh_latest_all.deb
wget $(echo https://raw.githubusercontent.com/PanderMusubi/klingon/master/packages/|awk -F 'hunspell-tlh_latest_all.deb' '{print $1}')$(cat hunspell-tlh_latest_all.deb)
rm -f hunspell-tlh_latest_all.deb

echo 'Downloaded in total '$(ls|wc -l)' packages'

cd ..
