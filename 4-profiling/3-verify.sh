#!/usr/bin/env sh

# license: https://github.com/hunspell/nuspell/blob/master/LICENSES

mkdir -p results/verify-nl
cd results/verify-nl
pwd
perf record -e cycles -g --call-graph fp ../../../../nuspell/src/nuspell/verify -i UTF-8 -d ../../nl ../../verify-nl.txt -C ../../verify-nl.tsv 2> perf_stderr > perf_stdout
#valgrind --tool=callgrind ../../../../nuspell/src/nuspell/verify -i UTF-8 -d ../../nl ../../verify-nl.txt -C ../../verify-nl.tsv 2> callgrind_stderr > callgrind_stdout
cd ../..
