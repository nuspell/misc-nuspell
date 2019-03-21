#!/usr/bin/env sh

# license: https://github.com/hunspell/nuspell/blob/master/LICENSES

BASE=`pwd`
mkdir -p results/verify-nl
cd results/verify-nl
pwd
#--call-graph dwarf -e cycles:u 
perf record -a --call-graph fp ../../../../nuspell/src/nuspell/verify -i UTF-8 -d $BASE/nl $BASE/verify-nl.txt -C $BASE/verify-nl.tsv 2> perf_stderr > perf_stdout
#valgrind --tool=callgrind ../../../../nuspell/src/nuspell/verify -i UTF-8 -d $BASE/nl $BASE/verify-nl.txt -C $BASE/verify-nl.tsv 2> callgrind_stderr > callgrind_stdout
cd ../..
