set -e
cd $(dirname "$0")
./1-download.sh
./2-extract.sh
./3-report.sh
./4-convert.sh
./5-test.sh
./6-histogram.sh
