rm -f *.txt *.diff

for file in *aff; do
	base=`basename $file .aff`
	if [ $file != none.aff ]; then

		hunspell -i UTF-8 -d none -a $base.words 2> /dev/null | grep -v 'International Ispell Version' | grep -v '^$' > $base-without-support.txt

		hunspell -i UTF-8 -d $base -a $base.words 2> /dev/null | grep -v 'International Ispell Version' | grep -v '^$' > $base-with-support.txt

		diff $base-without-support.txt $base-with-support.txt > $base.diff

	fi
done
