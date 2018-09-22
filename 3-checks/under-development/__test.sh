#!/usr/bin/env sh

echo book > words.txt
echo books >> words.txt
echo xfjejejfjfsjdfsd >> words.txt

rm -f result.tsv
for word in `cat words.txt`; do
	echo -n $word'\t' >> result.tsv
	echo $word | hunspell | tail -n +2 | head -n 1 | awk '{print $1}' >> result.tsv
done
cat result.tsv
