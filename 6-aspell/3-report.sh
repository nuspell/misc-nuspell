#!/usr/bin/env sh

echo `wc -l ../2-word-lists/utf8/american-english.txt|awk '{print $1}'`+`wc -l ../2-word-lists/utf8/dutch.txt|awk '{print $1}'`+`wc -l ../2-word-lists/utf8/polish.txt|awk '{print $1}'`+`wc -l ../2-word-lists/utf8/ukrainian.txt|awk '{print $1}'`|bc > total

echo `wc -l aspell-en_US.txt|awk '{print $1}'`+`wc -l aspell-nl.txt|awk '{print $1}'`+`wc -l aspell-pl_PL.txt|awk '{print $1}'`+`wc -l aspell-uk_UA.txt|awk '{print $1}'`|bc > aspell.correct
echo `cat aspell.correct`/`cat total`|bc -l > aspell.correctness

echo `wc -l hunspell-en_US.txt|awk '{print $1}'`+`wc -l hunspell-nl.txt|awk '{print $1}'`+`wc -l hunspell-pl_PL.txt|awk '{print $1}'`+`wc -l hunspell-uk_UA.txt|awk '{print $1}'`|bc > hunspell.correct
echo `cat hunspell.correct`/`cat total`|bc -l > hunspell.correctness

echo `wc -l nuspell-en_US.txt|awk '{print $1}'`+`wc -l nuspell-nl.txt|awk '{print $1}'`+`wc -l nuspell-pl_PL.txt|awk '{print $1}'`+`wc -l nuspell-uk_UA.txt|awk '{print $1}'`|bc > nuspell.correct
echo `cat nuspell.correct`/`cat total`|bc -l > nuspell.correctness

echo `cat hunspell.correctness`/`cat nuspell.correctness`|bc -l > hunspell-nuspell.correctness
echo `cat hunspell.speed`/`cat nuspell.speed`|bc -l > hunspell-nuspell.speed

echo `cat hunspell.correctness`/`cat aspell.correctness`|bc -l > hunspell-aspell.correctness
echo `cat hunspell.speed`/`cat aspell.speed`|bc -l > hunspell-aspell.speed

echo `cat nuspell.correctness`/`cat aspell.correctness`|bc -l > nuspell-aspell.correctness
echo `cat nuspell.speed`/`cat aspell.speed`|bc -l > nuspell-aspell.speed

echo `cat nuspell.correctness`/`cat hunspell.correctness`|bc -l > nuspell-hunspell.correctness
echo `cat nuspell.speed`/`cat hunspell.speed`|bc -l > nuspell-hunspell.speed

echo `cat aspell.correctness`/`cat hunspell.correctness`|bc -l > aspell-hunspell.correctness
echo `cat aspell.speed`/`cat hunspell.speed`|bc -l > aspell-hunspell.speed

echo `cat aspell.correctness`/`cat nuspell.correctness`|bc -l > aspell-nuspell.correctness
echo `cat aspell.speed`/`cat nuspell.speed`|bc -l > aspell-nuspell.speed

for i in *-*speed *-*correctness; do
    echo -n $i' '
    cat $i
done
