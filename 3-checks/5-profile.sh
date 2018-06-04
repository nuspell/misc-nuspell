#!/usr/bin/env bash

function run_profilers {
    mkdir $dst
    cd $dst
    head -n $num ../../../words/linux/$dst/gathered > gathered
    start=`date +%s`
    perf record -g ../../../nuspell_profiling/src/nuspell/nuspell -i UTF-8 -d $dic gathered 2> perf_stderr > /dev/null
    valgrind --tool=callgrind ../../../nuspell_profiling/src/nuspell/nuspell -i UTF-8 -d $dic gathered 2> callgrind_stderr > /dev/null
    end=`date +%s`
    echo $end-$start|bc > time-$hostname
    cd ..
}

platform=`../0-tools/platform.sh`
hostname=`hostname`

if [ ! -d words/$platform ]; then
	echo 'ERROR: Run the script ./1-prepare.sh first.'
    exit 1
fi

if [ -e profiling/$platform ]; then
	rm -rf profiling/$platform/*
else
	mkdir -p profiling/$platform
fi

updated=0
if [ -e nuspell_profiling ]; then
	cd nuspell_profiling
	updated=`git pull -r|grep -c 'Already up to date.'`
else
	rm -rf nuspell
	git clone https://github.com/hunspell/nuspell.git
	mv nuspell nuspell_profiling
	cd nuspell_profiling
fi

commit=`git log|head -n 1|awk '{print $2}'`

if [ $updated -eq 0 ]; then
	autoreconf -vfi
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to automatically reconfigure nuspell/hunspell'
		exit 1
	fi
	./configure CXXFLAGS='-g -O2 -fno-omit-frame-pointer'
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to configure nuspell/hunspell'
		exit 1
	fi
	make -j CXXFLAGS='-g -O2 -fno-omit-frame-pointer'
	if [ $? -ne 0 ]; then
		echo 'ERROR: Failed to build nuspell/hunspell'
		exit 1
	fi
fi
cd ..

cd profiling/$platform
pre=../../../../1-support/packages
num=16384
total_start=`date +%s`
 
dst=af_ZA
dic=$pre/af/1%3a6.0.3-3/usr/share/hunspell/$dst
run_profilers

dst=ca
dic=$pre/ca/3.0.2+repack1-2/usr/share/hunspell/$dst
run_profilers

dst=da_DK
dic=$pre/da/1%3a6.0.3-3/usr/share/hunspell/$dst
run_profilers

dst=de_DE_frami
dic=$pre/de-de-frami/1%3a6.0.3-3/usr/share/hunspell/$dst
run_profilers

dst=en_US
dic=$pre/en-us/1%3a2017.08.24/usr/share/hunspell/$dst
run_profilers

dst=se
dic=$pre/se/1.0~beta6.20081222-1.2/usr/share/hunspell/$dst
run_profilers

dst=uk_UA
dic=$pre/uk/1%3a6.0.3-3/usr/share/hunspell/$dst
run_profilers

total_end=`date +%s`
echo $total_end-$total_start|bc > time-$hostname
cd ../..
