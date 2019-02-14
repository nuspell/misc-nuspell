#!/usr/bin/env sh

# license: https://github.com/hunspell/nuspell/blob/master/LICENSES

run_profilers() {
	mkdir -p results/$dst
	cd results/$dst
	pwd
	head -n $num ../../../3-checks/gathered/$dst/words > words
	perf record -g ../../../../nuspell/src/nuspell/nuspell -i UTF-8 -d $dic words 2> perf_stderr > /dev/null
	valgrind --tool=callgrind ../../../../nuspell/src/nuspell/nuspell -i UTF-8 -d $dic words 2> callgrind_stderr > /dev/null
	cd ../..
}

platform=`../0-tools/platform.sh`
hostname=`hostname`

if [ ! -d ../3-checks/gathered ]; then
	echo 'ERROR: Run the script ./1-prepare.sh first.'
	exit 1
fi

#	autoreconf -vfi
#	./configure CXXFLAGS='-g -O2 -fno-omit-frame-pointer'
#	make -j CXXFLAGS='-g -O2 -fno-omit-frame-pointer'

pre=../../../1-support/files
num=16384
 
dst=nl
dic=$pre/hunspell-nl/2%3a2.10-6/usr/share/hunspell/$dst
run_profilers

dst=af_ZA
dic=$pre/hunspell-af/1%3a6.0.3-3/usr/share/hunspell/$dst
run_profilers

dst=ca
dic=$pre/hunspell-ca/3.0.2+repack1-2/usr/share/hunspell/$dst
run_profilers

dst=da_DK
dic=$pre/hunspell-da/1%3a6.0.3-3/usr/share/hunspell/$dst
run_profilers

dst=de_DE_frami
dic=$pre/hunspell-de-de-frami/1%3a6.0.3-3/usr/share/hunspell/$dst
run_profilers

dst=en_US
dic=$pre/hunspell-en-us/1%3a2017.08.24/usr/share/hunspell/$dst
run_profilers

dst=se
dic=$pre/hunspell-se/1.0~beta6.20081222-1.2/usr/share/hunspell/$dst
run_profilers

dst=uk_UA
dic=$pre/hunspell-uk/1%3a6.0.3-3/usr/share/hunspell/$dst
run_profilers
