#!/usr/bin/env bash

if [ -e debs ]; then
	rm -rf debs
fi
mkdir debs

# Omitting for now packages wgerman-medical scowl wamerican-huge wamerican-insane wamerican-large wamerican-small wbritish-huge wbritish-insane wbritish-large wbritish-small wcanadian-huge wcanadian-insane wcanadian-large wcanadian-small

packages=''
for package in `ls ../1-support/packages/|sort`; do
#	echo -e 'package\t'$package
	for language in `find ../1-support/packages/$package/*/usr/share/hunspell/ -type f -name '*\.aff'|sed 's/.*hunspell\/\(.*\)\.aff$/\1/'`; do
#		echo -e '\tlanguage\t'$language
		wordlist=`../0-tools/hunspell_language_support_to_wordlist_name.sh $package $language|sed 's/\(.*\) .*/\1/'`
#		echo '  wordlist: '$wordlist
	        if [ `echo $wordlist|grep -c ERROR` == 0 ]; then
#			echo -e '\t\twordlist\t'$wordlist
			packages=$packages' '$wordlist
	        fi
	done
done

cd debs
apt-get download $packages
cd ..
