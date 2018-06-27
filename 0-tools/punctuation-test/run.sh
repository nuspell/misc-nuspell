#!/usr/bin/env sh

echo '# Spell checking the following words:'
echo
cat words-with-symbols.txt

echo
echo
echo '# Results with symbol support'
echo
wc -l words-with-symbols.txt | awk '{print $1}' > without-symbols.dic
cat words-with-symbols.txt >> without-symbols.dic
../../../nuspell/src/tools/hunspell -d without-symbols -a words-with-symbols.txt

echo
echo
echo '# Results without symbol support'
echo
wc -l words-with-symbols.txt | awk '{print $1}' > with-symbols.dic
cat words-with-symbols.txt >> with-symbols.dic
../../../nuspell/src/tools/hunspell -d with-symbols -a words-with-symbols.txt
