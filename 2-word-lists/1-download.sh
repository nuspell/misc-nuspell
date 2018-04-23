#!/usr/bin/env bash

if [ -e debs ]; then
	rm -rf debs
fi
mkdir debs

# See 3-report.sh regarding omitting packages.
packages=''
for package in `ls ../1-support/packages/|sort`; do
#	echo -e 'package\t'$package
	for language in `find ../1-support/packages/$package/*/usr/share/hunspell/ -type f -name '*\.aff'|sed 's/.*hunspell\/\(.*\)\.aff$/\1/'`; do
#		echo -e '\tlanguage\t'$language
		word_list=`../0-tools/hunspell_language_support_to_word_list_name.sh $language|sed 's/\(.*\) .*/\1/'`
#		echo '  word list: '$word_list
	        if [ `echo $word_list|grep -c ERROR` == 0 ]; then
#			echo -e '\t\tword list\t'$word_list
			packages=$packages' '`echo $word_list|awk '{print $2}'`
	        fi
	done
done

cd debs
apt-get download $packages
cd ..
