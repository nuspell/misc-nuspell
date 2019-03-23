#!/usr/bin/env sh

cd 1-support
./1-download.sh
./2-extract.sh
./3-report-and-convert.sh
cd ..
cd 2-word-lists
./1-download.sh
./2-extract.sh
./3-report-and-convert.sh
cd ..
cd 3-checks
./1-gather.sh
#./2-regression.sh
#./4-render.sh
cd ..
