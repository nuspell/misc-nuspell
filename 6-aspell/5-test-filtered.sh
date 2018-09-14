#start=`date +%s`
echo aspell en_US
#cat part.txt|aspell -a -d en_US check > aspell-filtered-en_US.txt
echo aspell nl
cat part.txt|aspell -a -d nl check > aspell-filtered-nl.txt
#end=`date +%s`
#echo $end-$start|bc > aspell-filtered.speed

exit

start=`date +%s`
echo aspell en_US
cat filtered.txt|aspell -d en_US list > /dev/null
echo aspell nl
cat filtered.txt|aspell -d nl list > /dev/null
end=`date +%s`
echo $end-$start|bc > aspell-filtered.speed

start=`date +%s`
echo hunspell en_US
cat filtered.txt|hunspell -l -d en_US > /dev/null
echo hunspell nl
cat filtered.txt|hunspell -l -d nl > /dev/null
end=`date +%s`
echo $end-$start|bc > hunspell-filtered.speed

start=`date +%s`
echo nuspell en_US
../../nuspell/src/nuspell/nuspell -l -d en_US filtered.txt > /dev/null
echo nuspell nl
../../nuspell/src/nuspell/nuspell -l -d nl filtered.txt > /dev/null
end=`date +%s`
echo $end-$start|bc > nuspell-filtered.speed
