#!/usr/bin/env sh

# description: downloads packages with Hunspell language support
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# author: Sander van Geloven

platform=`../0-tools/platform.sh`

if [ -e packages ]; then
	rm -f packages/*
else
    mkdir packages
fi
cd packages

if [ $platform = linux ]; then

    # Myspell available packages
    MA=`apt-cache search myspell|grep ^myspell-|grep -iv transitional|grep -iv dummy|awk '{print $1}'|grep -v tools|tr '\n' ' '`
    # Hunspell available packages
    HA=`apt-cache search hunspell|grep ^hunspell|grep -iv transitional|grep -iv dummy|awk '{print $1}'|grep -v tools|tr '\n' ' '`

    # Myspell packages to download
    # Omitting packages which have Hunspell equivalent
    MD='myspell-eo
        myspell-et
        myspell-fa
        myspell-fo
        myspell-ga
        myspell-gv
        myspell-hy
        myspell-lv
        myspell-nr
        myspell-ns
        myspell-sq
        myspell-ss
        myspell-st
        myspell-tl
        myspell-tn
        myspell-ts
        myspell-ve
        myspell-xh
        myspell-zu'
    # Hunspell packages to download
    HD=''

    # Myspell packages to skip
    MS=''
    # Hunspell packages to skip
    # Omitting meta packages and omitting conflicting packages
    HS='hunspell-fr
        hunspell-fr-classical
        hunspell-fr-modern
        hunspell-fr-revised
        hunspell-gl'

    # Check is Myspell packages for download are available
    for i in $MD; do
        if [ `echo $MA|grep -c $i` -eq 0 ]; then
            echo 'ERROR: Package '$i' to download is not available'
            exit
        fi
    done

    # Construct Myspell packages to skip
    for i in $MA; do
        if [ `echo $MD|grep -c $i` -eq 0 ]; then
            echo 'Skipping package '$i'...'
            MS=$MS' '$i
        fi
    done

    # Check if skip package is still offered for download
    for i in $HS; do
        if [ `echo $HA|grep -c $i` -eq 0 ]; then
            echo 'ERROR: Package '$i' to skip is not available'
            exit
        else
            echo 'Skipping package '$i'...'
        fi
    done

    # Construct Hunspell packages to download
    for i in $HA; do
        if [ `echo $HS|grep -c $i` -eq 0 ]; then
            HD=$HD' '$i
        fi
    done

	# Double check for overlapping packages
	for i in $MD; do
		I=`echo $i|sed 's/myspell-//'`
		for j in $HD; do
			J=`echo $j|sed 's/hunspell-//'`
			if [ $I = $J ]; then
				echo 'ERROR: Overlapping packages '$i' and '$j
				exit
			fi
		done
	done

	# Download packages
	apt-get download $MD $HD
	cp -f `ls ../../../klingon/packages/hunspell-tlh_*_all.deb|sort -n|tail -1` .

elif [ $platform = freebsd ]; then

	sudo pkg fetch -o . -y `pkg search hunspell | grep ^[a-z][a-z]-hunspell | awk -F '-' '{print $1"-"$2}' | tr '\n' ' '`
        if [ -d All ]; then
		sudo mv All/* .
		sudo rmdir All
		sudo chown freebsd:freebsd *
	fi

fi

cd ..
