#!/usr/bin/env sh

# license: https://github.com/hunspell/nuspell/blob/master/LICENSES

run_profilers() {
	mkdir -p results/specific-$dst
	cd results/specific-$dst
	pwd
	perf record -g ../../../../nuspell/src/nuspell/nuspell -i UTF-8 -d $dic ../../specific-$dst.txt 2> perf_stderr > perf_stdout
	valgrind --tool=callgrind ../../../../nuspell/src/nuspell/nuspell -i UTF-8 -d $dic ../../specific-$dst.txt 2> callgrind_stderr > callgrind_stdout
	cd ../..
}

platform=`../0-tools/platform.sh`
hostname=`hostname`

if [ ! -d ../3-checks/gathered ]; then
	echo 'ERROR: Run the script ./1-prepare.sh first.'
	exit 1
fi

pre=../../../1-support/files

dst=nl
dic=$pre/hunspell-nl/2%3a2.10-6/usr/share/hunspell/$dst
run_profilers
