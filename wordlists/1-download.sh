#!/usr/bin/env sh

# description: Downloads word list packages
# license: https://github.com/nuspell/nuspell/blob/master/COPYING.LESSER
# author: Sander van Geloven

set -e
cd $(dirname "$0")
if [ -e downloads ]; then
	rm -f downloads/*
else
    mkdir downloads
fi
cd downloads

PACKAGES=''
for LANG in $(find ../../dictionaries/extractions/*/ -name '*\.aff'|sed 's/\.aff//'|sed 's/.*\///'|sort|uniq); do
	if [ $LANG = tlh_Latn -o $LANG = tlh -o $LANG = fy_NL ]; then
		continue
	fi
	WORDLIST=$(../../tools/language-code-to-wordlist.sh $LANG|sed 's/\(.*\) .*/\1/')
        if [ $(echo $WORDLIST|grep -c ERROR) = 0 ]; then
		PACKAGE=$(echo $WORDLIST|awk '{print $2}')
	        if [ $(echo $PACKAGES|grep -c $PACKAGE) = 0 ]; then
			PACKAGES=$PACKAGES' '$PACKAGE
		fi
        fi
done

apt-get download $(echo $PACKAGES|sort)

# Frisian
wget https://raw.githubusercontent.com/PanderMusubi/frisian/master/packages/wfrisian_latest_all.deb
wget $(echo https://raw.githubusercontent.com/PanderMusubi/frisian/master/packages/|awk -F 'wfrisian_latest_all.deb' '{print $1}')$(cat wfrisian_latest_all.deb)
rm -f wfrisian_latest_all.deb

# Klingon
wget https://raw.githubusercontent.com/PanderMusubi/klingon/master/packages/wklingon_latest_all.deb
wget $(echo https://raw.githubusercontent.com/PanderMusubi/klingon/master/packages/|awk -F 'wklingon_latest_all.deb' '{print $1}')$(cat wklingon_latest_all.deb)
rm -f wklingon_latest_all.deb

echo 'Downloaded in total '$(ls|wc -l)' packages'

cd ..
