#!/usr/bin/env sh


# Initialization

platform=`../0-tools/platform.sh`
hostname=`hostname`
machine=$platform\_$hostname
run=`date +%s`

if [ ! -d gathered ]; then
	echo 'ERROR: Run the script ./1-gather.sh first.'
    exit 1
fi

if [ -e regression/$machine ]; then
	rm -rf regression/$machine/*
else
	mkdir -p regression/$machine
fi

if [ ! -e blacklist ]; then
	touch blacklist
fi
if [ ! -e whitelist ]; then
	touch whitelist
fi
if [ -e log ]; then
	truncate -s 0 log
fi


# Downloading git repo
if [ ! -d nuspell ]; then
	git clone https://github.com/nuspell/nuspell.git >> log 2>> log
fi


# Updating repo
cd nuspell
git reset --hard HEAD >> ../log 2>> ../log
git pull -r >> ../log 2>> ../log
cd ..


# Fill worklist with example list
if [ ! -s worklist ]; then
	echo 'WARNING: No worklist with SHAs found, filling worklist with example SHAs'
	cp -f worklist.example worklist
fi


# Iterating commit SHAs
for sha in `cat worklist`; do
	echo 'INFO: Testing commit '$sha
	if [ `grep -c $sha blacklist` -ne 0 ]; then
		echo 'WARNING: Omitting blacklisted commit '$sha
		continue
	fi
	cd nuspell

	# Reset to the desired commit SHA
	git reset --hard $sha >> ../log 2>> ../log
	if [ $? -ne 0 ]; then
		echo 'ERROR: Resetting to commit '$sha' results in an error'
		cd ..
		# Add commit SHA to blacklist
		echo $sha >> blacklist
		cat blacklist|sort|uniq > blacklist.tmp
		mv -f blacklist.tmp blacklist
		continue
	fi

	# Build application
	autoreconf -vfi >> ../log 2>> ../log
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to automatically reconfigure nuspell'
		cd ..
		# Add commit SHA to blacklist
		echo $sha >> blacklist
		cat blacklist|sort|uniq > blacklist.tmp
		mv -f blacklist.tmp blacklist
		continue
	fi
	./configure CXXFLAGS='-O2 -fno-omit-frame-pointer' >> ../log 2>> ../log
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to configure nuspell'
		cd ..
		# Add commit SHA to blacklist
		echo $sha >> blacklist
		cat blacklist|sort|uniq > blacklist.tmp
		mv -f blacklist.tmp blacklist
		continue
	fi
	if [ `grep -c $sha ../whitelist` -eq 0 ]; then
		make -j CXXFLAGS='-O2 -fno-omit-frame-pointer' >> ../log 2>> ../log
		if [ $? -ne 0 ]; then
			echo 'ERROR: Failed to build nuspell'
			cd ..
			# Add commit SHA to blacklist
			echo $sha >> blacklist
			cat blacklist|sort|uniq > blacklist.tmp
			mv -f blacklist.tmp blacklist
			continue
		fi
		make check >> ../log 2>> ../log
		if [ $? -ne 0 ]; then
			echo 'ERROR: Failed to check nuspell'
			cd ..
			# Add commit SHA to blacklist
			echo $sha >> blacklist
			cat blacklist|sort|uniq > blacklist.tmp
			mv -f blacklist.tmp blacklist
			continue
		fi
	else
		# Faster building for whitelisted commit
		cd src/hunspell
		make -j CXXFLAGS='-O2 -fno-omit-frame-pointer' libhunspell.a >> ../../../log 2>> ../../../log
		cd ../nuspell
		make -j CXXFLAGS='-O2 -fno-omit-frame-pointer' regress >> ../../../log 2>> ../../../log
		cd ../..
	fi

	timestamp=`git log $sha --date=raw|head -n 3|tail -n 1|awk '{print $2}'`
	cd ..
	handle=`echo $sha|sed -e 's/^\(.......\).*/\1/'`


	# Run the text executable for all affix files with gathered word lists
	for path in `find ../1-support/files -type f -name '*.aff'|sort`; do
		dictionary=`echo $path|sed -e 's/\.aff//'`
		affix=`echo $path|awk -F '/' '{print $9}'`
		language=`basename $affix .aff`
		if [ -e gathered/$language/words ]; then
			wordsin=`cat gathered/$language/words.total`
			echo 'Testing '$language' on '$wordsin' words'
			mkdir -p regression/$machine/$language
			# Add commit SHA, commit timestamp and run timestamp to result
			echo -n $sha' '$timestamp' '$run' ' >> regression/$machine/$language/result
			nuspell/src/nuspell/regress -i UTF-8 -d $dictionary gathered/$language/words 2> regression/$machine/$language/stderr |tail -n 1 >> regression/$machine/$language/result
			# Double check if number of words in word list and number of words tested are identical
			wordsout=`tail -n 1 regression/$machine/$language/result | awk '{print $4}'`
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
