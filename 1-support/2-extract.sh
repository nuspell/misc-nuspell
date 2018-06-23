# author: Sander van Geloven
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# description: extracts downloaded packages with Hunspell language support

platform=`../0-tools/platform.sh`

if [ ! -d packages ]; then
	echo 'ERROR: First, run the script ./1-download.sh'
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
		DIRECTORY=`basename $i|awk -F _ '{print $1}'`
		VERSION=`basename $i|awk -F _ '{print $2}'`
		echo -e $DIRECTORY'\t'$VERSION
		mkdir -p $DIRECTORY/$VERSION
		dpkg -x $i $DIRECTORY/$VERSION
	    rm -rf $DIRECTORY/$VERSION/usr/share/doc \
        $DIRECTORY/$VERSION/usr/share/myspell #\
#        $DIRECTORY/$VERSION/usr/share/hyphen
	done

elif [ $platform = freebsd ]; then

    #TODO undo hunspell/myspell removal director name
	for i in `ls ../packages/*.txz|sort`; do
		DIRECTORY=`basename $i .txz|awk -F '-hunspell-' '{print $1}'|awk -F '-myspell-' '{print $1}'`
		VERSION=`basename $i .txz|awk -F '-hunspell-' '{print $2}'|awk -F '-myspell-' '{print $2}'`
		echo -e $DIRECTORY'\t'$VERSION
		mkdir -p $DIRECTORY/$VERSION
		tar xf $i -C $DIRECTORY/$VERSION 2> /dev/null
		mv $DIRECTORY/$VERSION/usr/local/* $DIRECTORY/$VERSION/usr
		rmdir $DIRECTORY/$VERSION/usr/local
    	rm -rf $DIRECTORY/$VERSION/+MANIFEST \
        $DIRECTORY/$VERSION/+COMPACT_MANIFEST \
        $DIRECTORY/$VERSION/usr/share/licenses
	done

fi

cd ..
