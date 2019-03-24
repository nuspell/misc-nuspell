#!/usr/bin/env sh

# description: runs verification tests within regression testing
# license: https://github.com/hunspell/nuspell/blob/master/LICENSES
# author: Sander van Geloven

# Lock file
if [ -e lock ]; then
	echo 'ERROR: Lock file found. Do not run multiple instances of this script.'
	exit 1
fi
touch lock


# Initialization
platform=`../0-tools/platform.sh`
hostname=`hostname`
machine=$platform\_$hostname
run=`date +%s`

if [ ! -d gathered ]; then
	echo 'ERROR: Run the script ./1-gather.sh first.'
    exit 1
fi

#if [ ! -e regression/$machine ]; then
#	mkdir -p regression/$machine
#fi

if [ ! -e blacklist ]; then
	touch blacklist
fi
if [ ! -e whitelist ]; then
	touch whitelist
fi
if [ -e log ]; then
	truncate -s 0 log
fi
if [ -e errors ]; then
	rm -f errors/*
else
	mkdir errors
fi
if [ ! -e builds ]; then
	mkdir builds
fi


# Fill worklist with example list
if [ ! -s worklist ]; then
	echo 'WARNING: No worklist with SHAs found, using worklist with example SHAs'
	cp -f worklist.example worklist
fi


# Downloading git repo
if [ ! -d verification_nuspell ]; then
	git clone https://github.com/nuspell/nuspell.git >> log 2>> log
	if [ $? -ne 0 ]; then
		echo 'ERROR: Could not clone git repo'
		rm -f lock
		exit 1
	fi
	mv nuspell verification_nuspell
fi


# Updating repo
cd verification_nuspell
git reset --hard HEAD >> ../log 2>> ../log
if [ $? -ne 0 ]; then
	echo 'ERROR: Could not reset git repo to HEAD'
	cd ..
	rm -f lock
	exit 1
fi
git pull -r >> ../log 2>> ../log
if [ $? -ne 0 ]; then
	echo 'ERROR: Could not update git repo'
	cd ..
	rm -f lock
	exit 1
fi
cd ..


# Iterating commit SHAs
for sha in `cat worklist`; do
	echo 'INFO: Verfying commit '$sha
	if [ `grep -c $sha $machine.ssv` -ne 0 ]; then
		echo 'WARNING: Omitting already verified commit '$sha
		continue
	fi
	if [ `grep -c $sha blacklist` -ne 0 ]; then
		echo 'WARNING: Omitting blacklisted commit '$sha
		continue
	fi
	cd verification_nuspell
	# only build when previously build executable is not available
	if [ ! -e builds/$sha ]; then

		# Reset to the desired commit SHA
		git reset --hard $sha >> ../log 2>> ../log
		if [ $? -ne 0 ]; then
			echo 'ERROR: Failed to reset git repo to '$sha
			cd ..
			# Add commit SHA to blacklist
			echo $sha >> blacklist
			cat blacklist|sort|uniq > blacklist.tmp
			mv -f blacklist.tmp blacklist
			continue
		fi

		# Build application
		if [ ! -e build ]; then
			mkdir build
		fi
		cd build
		cmake ..
		if [ $? -ne 0 ]; then
			echo 'ERROR: Failed to configure nuspell'
			cd ../..
			# Add commit SHA to blacklist
			echo $sha >> blacklist
			cat blacklist|sort|uniq > blacklist.tmp
			mv -f blacklist.tmp blacklist
			continue
		fi
#		if [ `grep -c $sha ../../whitelist` -eq 0 ]; then
			make -j >> ../../log 2>> ../../log
			if [ $? -ne 0 ]; then
				echo 'ERROR: Failed to build nuspell'
				cd ../..
				# Add commit SHA to blacklist
				echo $sha >> blacklist
				cat blacklist|sort|uniq > blacklist.tmp
				mv -f blacklist.tmp blacklist
				continue
			fi
			make -j test >> ../../log 2>> ../../log
			if [ $? -ne 0 ]; then
				echo 'ERROR: Failed to testcd  nuspell'
				cd ../..
				# Add commit SHA to blacklist
				echo $sha >> blacklist
				cat blacklist|sort|uniq > blacklist.tmp
				mv -f blacklist.tmp blacklist
				continue
			fi

			cp -f tests/verify ../../builds/$sha
			cd ..
#		fi
	fi
	timestamp=`git log $sha --date=raw|head -n 3|tail -n 1|awk '{print $2}'`
	if [ $? -ne 0 ]; then
		echo 'ERROR: Could not retrieve timestamp from git log'
		cd ..
		# Add commit SHA to blacklist
		echo $sha >> blacklist
		cat blacklist|sort|uniq > blacklist.tmp
		mv -f blacklist.tmp blacklist
		continue
	fi
	handle=`echo $sha|sed -e 's/^\(.......\).*/\1/'`
	cd ..


	# Run the text executable for all affix files with gathered word lists
	for path in `find ../1-support/files -type f -name '*.aff'|sort`; do
		dictionary=`echo $path|sed -e 's/\.aff//'`
		affix=`echo $path|awk -F '/' '{print $9}'`
		language=`basename $affix .aff`
		if [ -e gathered/$language/words ]; then
			wordsin=`cat gathered/$language/words.total`
			echo 'Testing '$language' on '$wordsin' words'
#			mkdir -p regression/$machine/$language
			# Add commit SHA, commit timestamp and run timestamp to result
			echo -n $sha' '$timestamp' '$language' '$run' ' >> $machine.ssv
			result=`builds/$sha -i UTF-8 -d $dictionary gathered/$language/words 2> errors/$language |tail -n 1`
			echo $result >> $machine.ssv
			# Double check if number of words in word list and number of words tested are identical
			wordsout=`echo $result | awk '{print $1}'`
			if [ -z $wordsin ]; then
				echo 'ERROR: Number of words in is not defined for '$language
			fi
			if [ -z $wordsout ]; then
				echo 'ERROR: Number of words out is not defined for '$language
			fi
			if [ $wordsin -ne $wordsout ]; then
				echo 'ERROR: Number of words in ('$wordsin') and number of results out ('$wordsout') do not match for '$language
			fi
		fi
	done


	# Add commit SHA to whitelist
	echo $sha >> whitelist
	cat whitelist|sort|uniq > whitelist.tmp
	mv -f whitelist.tmp whitelist
done


# Clear worklist
truncate -s 0 worklist


# Lock file
rm -f lock
