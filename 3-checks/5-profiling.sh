#!/usr/bin/env bash

function run_profilers {
    mkdir $dst
    cd $dst
    head -n $num ../../words/linux/$dst/gathered > gathered
    start=`date +%s`
    # Note that here the development version of Nuspell is used!
    sudo perf record ../../../nuspell/src/nuspell/nuspell -i UTF-8 -d $dic gathered 2> perf_stderr > /dev/null
    sudo chown `whoami`.`whoami` perf.data
    valgrind --tool=callgrind ../../nuspell/src/nuspell/nuspell -i UTF-8 -d $dic gathered 2> callgrind_stderr > /dev/null
    end=`date +%s`
    echo $end-$start|bc > time-$hostname
    cd ..
}

platform=`../0-tools/platform.sh`
hostname=`hostname`
if [ ! -e profiling ]; then
    mkdir profiling
else
    rm -rf profiling/*
fi
cd profiling
pre=../../../1-support/packages
num=16384
total_start=`date +%s`
 
dst=af_ZA
dic=$pre/af/1%3a6.0.3-3/usr/share/hunspell/$dst
run_profilers

dst=de_DE_frami
dic=$pre/de-de-frami/1%3a6.0.3-3/usr/share/hunspell/$dst
run_profilers

dst=en_US
dic=$pre/en-us/1%3a2017.08.24/usr/share/hunspell/$dst
run_profilers

total_end=`date +%s`
echo $total_end-$total_start|bc > time-$hostname
cd ..
