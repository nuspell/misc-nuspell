#!/usr/bin/env sh

# description: extract packages with word lists
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# author: Sander van Geloven

platform=`../0-tools/platform.sh`

if [ ! -d packages ]; then
	echo 'ERROR: Run the script ./1-download.sh first.'
    exit 1
fi

if [ -e files ]; then
	rm -rf files/*
else
    mkdir files
fi
cd files

if [ $platform = linux ]; then

	for i in `ls ../packages/*.deb|sort`; do
        filename=`basename $i`
		DIRECTORY=`echo $filename|sed 's/\([^_]\)_.*/\1/'`
		VERSION=`echo $i|sed 's/.*_\(.*\)_.*/\1/'`
		echo $DIRECTORY'\t'$VERSION
		mkdir -p $DIRECTORY/$VERSION
		dpkg -x $i $DIRECTORY/$VERSION
        rm -rf $DIRECTORY/$VERSION/usr/share/doc \
        $DIRECTORY/$VERSION/usr/share/man
	done

elif [ $platform = freebsd ]; then

	echo TODO

fi

cd ..
