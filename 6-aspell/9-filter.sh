cat random.txt|aspell -d en_US list > 1.txt
cat 1.txt|aspell -d nl list > 2.txt

cat 2.txt|hunspell -l -d en_US > 3.txt
cat 3.txt|hunspell -l -d nl > 4.txt

../../nuspell/src/nuspell/nuspell -l -d en_US 5.txt > 6.txt
../../nuspell/src/nuspell/nuspell -l -d nl 6.txt > filtered.txt

head -n 100000 filtered.txt > part.txt

rm -f 1.txt 2.txt 3.txt 4.txt 5.txt 6.txt
