#!/usr/bin/env bash

# author: Sander van Geloven
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# description: downloads packages with word lists

platform=`../0-tools/platform.sh`

if [ -e packages ]; then
	rm -rf packages
fi
mkdir packages

# See 3-report.sh regarding omitting packages.
names=''
for package in `ls ../1-support/files/|sort`; do
#	echo -e 'package\t'$package
	for language in `find ../1-support/files/$package/*/usr/share/hunspell/ -type f -name '*\.aff'|sed 's/.*hunspell\/\(.*\)\.aff$/\1/'`; do
#		echo -e '\tlanguage\t'$language
		word_list=`../0-tools/hunspell_language_support_to_word_list_name.sh $language|sed 's/\(.*\) .*/\1/'`
#		echo '  word list: '$word_list
	        if [ `echo $word_list|grep -c ERROR` == 0 ]; then
#			echo -e '\t\tword list\t'$word_list
			names=$names' '`echo $word_list|awk '{print $2}'`
	        fi
	done
done
if [ $platform = linux ]; then
	cd packages
	apt-get update
	apt-get download $names
elif [ $platform = freebsd ]; then
        sudo pkg fetch -o . -y $names
	if [ -d All ]; then
		sudo mv All/* .
		sudo rmdir All
		sudo chown freebsd:freebsd *
	fi
fi
cd ..
