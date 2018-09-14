start=`date +%s`
echo aspell en_US
cat ../2-word-lists/utf8/american-english.txt|aspell -d en_US list > aspell-en_US.txt
echo aspell nl
cat ../2-word-lists/utf8/dutch.txt|aspell -d nl list > aspell-nl.txt
echo aspell pl
cat ../2-word-lists/utf8/polish.txt|aspell -d pl list > aspell-pl_PL.txt
echo aspell uk_UA
cat ../2-word-lists/utf8/ukrainian.txt|aspell -d uk list > aspell-uk_UA.txt
end=`date +%s`
echo $end-$start|bc > aspell.speed

start=`date +%s`
echo hunspell en_US
cat ../2-word-lists/utf8/american-english.txt|hunspell -l -d en_US > hunspell-en_US.txt
echo hunspell nl
cat ../2-word-lists/utf8/dutch.txt|hunspell -l -d nl > hunspell-nl.txt
echo hunspell pl_PL
cat ../2-word-lists/utf8/polish.txt|hunspell -l -d pl_PL > hunspell-pl_PL.txt
echo hunspell uk_UA
cat ../2-word-lists/utf8/ukrainian.txt|hunspell -l -d uk_UA > hunspell-uk_UA.txt
end=`date +%s`
echo $end-$start|bc > hunspell.speed

start=`date +%s`
echo nuspell en_US
../../nuspell/src/nuspell/nuspell -l -d en_US ../2-word-lists/utf8/american-english.txt > nuspell-en_US.txt
echo nuspell nl
../../nuspell/src/nuspell/nuspell -l -d nl ../2-word-lists/utf8/dutch.txt > nuspell-nl.txt
echo nuspell pl_PL
../../nuspell/src/nuspell/nuspell -l -d pl_PL ../2-word-lists/utf8/polish.txt > nuspell-pl_PL.txt
echo nuspell uk_UA
../../nuspell/src/nuspell/nuspell -l -d uk_UA ../2-word-lists/utf8/ukrainian.txt > nuspell-uk_UA.txt
end=`date +%s`
echo $end-$start|bc > nuspell.speed
