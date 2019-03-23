#!/usr/bin/env sh

# description: downloads packages with word lists
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# author: Sander van Geloven

platform=`../0-tools/platform.sh`

if [ -e packages ]; then
	rm -f packages/*
else
    mkdir packages
fi
cd packages

# See 3-report.sh regarding omitting packages.
names=''
#for package in `ls ../../1-support/files/|sort`; do
	for language in `find ../../1-support/files/*/*/usr/share/hunspell/ -type f -name '*\.aff'|sed 's/.*hunspell\/\(.*\)\.aff$/\1/'|sort`; do
		if [ $language = tlh_Latn -o $language = tlh ]; then # temporary workaround
			continue
		fi
		word_list=`../../0-tools/language_support_to_word_list_name.sh $language|sed 's/\(.*\) .*/\1/'`
	        if [ `echo $word_list|grep -c ERROR` = 0 ]; then
    			names=$names' '`echo $word_list|awk '{print $2}'`
	        fi
	done
#done

if [ $platform = linux ]; then

#	sudo apt-get update
	apt-get download $names
	#TODO temporary workaround until package request has been completed
	if [ -e ../../../klingon/packages ]; then
		cp -f `ls ../../../klingon/packages/wklingon_*_all.deb|sort -n|tail -1` .
	fi

elif [ $platform = freebsd ]; then

    sudo pkg fetch -o . -y $names
    if [ -d All ]; then
		sudo mv All/* .
		sudo rmdir All
		sudo chown freebsd:freebsd *
	fi

fi

cd ..
