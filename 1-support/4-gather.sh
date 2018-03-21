#!/usr/bin/env bash

if [ -e all ]; then
	rm -rf all
fi
mkdir all

cd packages
find . -type f -name '*.aff' -exec cp {} ../all \;
find . -type f -name '*.dic' -exec cp {} ../all \;
rm -f ../all/de_med.dic  ../all/en_MED.dic
cd ..
