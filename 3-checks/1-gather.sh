#!/usr/bin/env sh

if [ ! -d ../1-support/files -o ! -d ../1-support/utf8 ]; then
	echo 'ERROR: Run the scripts in ../1-support/ first.'
    exit 1
fi
if [ ! -d ../2-word-lists/files -o ! -d ../2-word-lists/utf8 ]; then
	echo 'ERROR: Run the scripts in ../2-word-lists/ first.'
    exit 1
fi

platform=`../0-tools/platform.sh`
hostname=`hostname`

if [ -e gathered ]; then
	rm -rf gathered/*
else
	mkdir -p gathered
fi

echo 'For testing purposes, words are gathered from word lists and from dictinary root words. Below is a table showing how many words have been gathered for each language.' >> Gathered-Words.md
echo > Gathered-Words.md
echo '| Language | Number Of Words |' >> Gathered-Words.md
echo '|----------|-----------------|' >> Gathered-Words.md

# Crude filtering by skipping:
# 1. first line of dic file with list size
# 2. everything after a slash, but not a slash which is escaped by backslash, that one is unescaped
# 3. comments including and after #

# Crude splitting for:
# 4. whitespace
# 5. comma ,
# 6. hyphen - (only for certain languages)

# Crude filtering by skipping:
# 7. emtpy line

for path in `find ../1-support/files -type f -name '*.aff'|sort`; do
	package=`echo $path|awk -F '/' '{print $4}'`
	version=`echo $path|awk -F '/' '{print $5}'`
	affix=`echo $path|awk -F '/' '{print $9}'`
	language=`basename $affix .aff`

if [ $language != ko -a $language != te_IN -a $language != th_TH ]; then # too slow with sort
# # #if [ $language != an_ES -a $language != bg_BG -a $language != cs_CZ -a $language != el_GR -a $language != en_MED -a $language != es_ES -a $language != sl_SI -a $language != hr_HR -a $language != kk_KZ -a $language != pt_BR -a $language != th_TH -a $language != pl_PL -a $language != ko -a $language != lt_LT -a $language != te_IN ]; then # errors that need fixing
# # #-a $language != nn_NO 
	echo -n 'Gathering words for '$language
	echo -n '| `'$language'` | ' >> Gathered-Words.md
	mkdir -p gathered/$language

	# Words from dictionary file

#	if [ $language = br_FR -o $language = en_CA -o $language = en_GB -o $language = en_US -o $language = en_ZA -o $language = eo -o $language = et_EE -o $language = gv_GB -o $language = nn_NO -o $language = nb_NO -o $language = oc_FR -o $language = ro_RO -o $language = tl -o $language = lv_LV -o $language = sv_SE -o $language = sv_FI -o $language = sk_SK -o $language = sw_TZ -o $language = fo -o $language = ga_IE -o $language = se -o $language = af_ZA ];then # split on hyphen
#		tail -n +2 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'| sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/-/\n/g'|grep -v '^$'|sort|uniq > words/$language/dict_$version
#	elif [ $language = gd_GB ];then # split on NON-BREAKING HYPHEN' (U+2011)
#		tail -n +2 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'| sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/‑/\n/g'|grep -v '^$'|sort|uniq > words/$language/dict_$version
#	elif [ $language = fr ];then # split on hyphen and ndash and underscore
#		tail -n +2 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/[_–-]/\n/g'|grep -v '^$'|sort|uniq > words/$language/dict_$version
#	if [ $language = ar ];then # custom # and ::
#		tail -n +2 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|grep -v \# |grep -v :: |sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|grep -v '^$'|sort|uniq > words/$language/dict_$version
#	if [ $language = de_AT_frami -o $language = de_AT -o $language = de_CH_frami -o $language = de_CH -o $language = de_DE_frami -o $language = de_DE ];then # also license # also '(STp'
#		tail -n +18 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|grep -v '^$'|grep -v '(STp' |sort|uniq > words/$language/dict_$version
#	elif [ $language = it_IT ];then # also license
#		tail -n +35 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|grep -v '^$'|sort|uniq > words/$language/dict_$version
#	else # default


# 1) remove end of line
#    " ts:transitiva / pronominal VOLG: t pr al:zólar"
#
# 2) remove all after non-escaped slash, including that slash
#    "t\/m/!" -> "t\/m"
#
# 3) unescape escaped slashes
#    "t\/m" -> "t/m"
#
# 5) remove question mark at beginning of line
#    "!boerbul" -> "boerbul"
#    https://bugs.documentfoundation.org/show_bug.cgi?id=118344
#
# 6) remove lines starting with two colons
#    "::::::::::::::"
#    https://bugs.documentfoundation.org/show_bug.cgi?id=117389
#
# 7) Remove (Stp from German dictionary files
#    https://bugs.documentfoundation.org/show_bug.cgi?id=118343
#    "(STp" -> ""
#
# 8) remove all lines beginnen with a slash
#
# 9) remove all after a tab or after a hash, including tab and hash
#
# 10) remove empty lines
#    https://bugs.documentfoundation.org/show_bug.cgi?id=117408

	tail -n +2 ../1-support/utf8/$language.txt|sed -e 's/[ \t][a-z][a-z]:.*$//g'|sed -e 's/\([^\]\)\/.*/\1/g'|sed -e 's/\\\//\//g'|sed -e 's/^!//'|grep -v '^::'|grep -v '(STp'|grep -v '^/'|sed -e 's/[\t#].*//'|grep -v '^$'|sort|uniq > gathered/$language/dict_$version
#	fi


	# Words from word lists

	word_list=`../0-tools/language_support_to_word_list_name.sh $language`
	if [ `echo $word_list|grep -c ERROR` = 0 ]; then
		wordpackage=`echo $word_list|awk '{print $2}'`
		wordfile=`echo $word_list|awk '{print $3}'`
		for list in ../2-word-lists/files/$wordpackage/*/usr/share/dict/$wordfile; do
			wordversion=`echo $list|awk -F '/' '{print $5}'`
###			if [ $language = br_FR -o $language = en_CA -o $language = en_GB -o $language = en_US -o $language = en_ZA -o $language = nn_NO -o $language = nb_NO -o $language = oc_FR -o $language = ro_RO -o $language = sv_SE -o $language = sv_FI -o $language = sk_SK -o $language = sw_TZ -o $language = ga_IE -o $language = fo -o $language = eo ]; then # split on hyphen
###				cat ../2-word-lists/utf8/$wordfile.txt|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|sed -e 's/-/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$language/list_$wordversion
###			else
###				cat ../2-word-lists/utf8/$wordfile.txt|sed -e 's/\t.*//g'|sed -e 's/#.*//g'|sed -e 's/\s/\n/g'|sed -e 's/,/\n/g'|grep -v [_\&]|grep -v '^$'|sort|uniq > words/$language/list_$wordversion

# 1) remove all after a tab or after a hash, including tab and hash
#
# 2) remove empty lines
#    https://bugs.documentfoundation.org/show_bug.cgi?id=117408

			cat ../2-word-lists/utf8/$wordfile.txt|sed -e 's/[\t#].*//g'|grep -v '^$'|sort|uniq > gathered/$language/list_$wordversion
###			fi
		done
	fi


	# Joining words

	#TODO for testing, limit via "sort -R|head -n 4096"
#	cat words/$language/*|sort|uniq|sort -R|head -n 4096 >words/$language/gathered
## 	if [ $language = br_FR ]; then # period colon
## 		cat words/$language/*|grep -v [:.] |sort|uniq >words/$language/gathered
## ###	elif [ $language = da_DK ]; then # numerals (also in subscript and superscript) and apostrophe and hyphen begin of word
## ###		cat words/$language/*|grep -v "[0-9¹²³₁₂₃']" |grep -v "^-" |sort|uniq >words/$language/gathered
## ###		cat words/$language/*|sed -e 's/ /\n/g'|sort|uniq >words/$language/gathered
## #	elif [ $language = fr ]; then # numerals in subscript and superscript and apostrophe and opening and closing braces and hyphen end of word and &
## #		cat words/$language/*|grep -v "[&¹²³₁₂₃'()]" |grep -v "\-$" |sort|uniq >words/$language/gathered
## 	elif [ $language = ro_RO ]; then # numerals
## 		cat words/$language/*|grep -v "[0-9]" |sort|uniq >words/$language/gathered
## 	elif [ $language = nl ]; then # subscriptnumerals plus -BOL
## 		cat words/$language/*|grep -v "[+₁₂₃]" |grep -v "^-" |sort|uniq >words/$language/gathered
## 	elif [ $language = sv_SE -o $language = sv_FI ]; then # subscriptnumerals plus -BOL
## 		cat words/$language/*|grep -v "[:']" |grep -v "^-" |sort|uniq >words/$language/gathered
## ###	elif [ $language = en_GB ]; then # omit period apostrophe plus
## ###		cat words/$language/*|grep -v "[+.']" |sort|uniq >words/$language/gathered
## 	elif [ $language = en_US ]; then # omit period apostrophe
## 		cat words/$language/*|grep -v "[.']" |sort|uniq >words/$language/gathered
## 	elif [ $language = gl_ES ]; then # period numerals
## 		cat words/$language/*|grep -v "[0-9.]" |sort|uniq >words/$language/gathered
## 	elif [ $language = nb_NO -o $language = et_EE ]; then # period
## 		cat words/$language/*|grep -v "\." |sort|uniq >words/$language/gathered
## 	elif [ $language = sw_TZ ]; then # period apostrophe numerals
## 		cat words/$language/*|grep -v "[0-9.']" |sort|uniq >words/$language/gathered
## 	elif [ $language = en_ZA -o $language = af_ZA ]; then # omit period apostrophe numerals exclamationmark
## 		cat words/$language/*|grep -v "[0-9.']" |grep -v ! |sort|uniq >words/$language/gathered
## 	elif [ $language = sr_RS ]; then # period specialapostrophe
## 		cat words/$language/*|grep -v "[.’]" |sort|uniq >words/$language/gathered
## ##	elif [ $language = gd_GB ]; then # period and ⁊ TIRONIAN SIGN ET and equals and numerals underscore
## ##		cat words/$language/*|grep -v "[0-9⁊.=_]"|sort|uniq >words/$language/gathered
## 	elif [ $language = it_IT -o $language = tl -o $language = ga_IE -o $language = kmr_Latn -o $language = fo -o $language = en_CA -o $language = en_AU -o $language = eo -o $language = gv_GB -o $language = oc_FR ]; then # apostrophe
## 		cat words/$language/*|grep -v "'" |sort|uniq >words/$language/gathered
## 	elif [ $language = de_CH_frami -o $language = de_AT_frami ]; then # apostrophe plus
## 		cat words/$language/*|grep -v "[+']" |sort|uniq >words/$language/gathered
## 	elif [ $language = lv_LV ]; then # period braceopen braceclose
## 		cat words/$language/*|grep -v "[.()]" |sort|uniq >words/$language/gathered
## 	elif [ $language = hu_HU ]; then # omit misc
## 		cat words/$language/*|grep -v "[@$€}:=§%{|±+'()]" |grep -v "^-"|grep -v "\-$"|sort|uniq >words/$language/gathered
## 	elif [ $language = de_DE_frami ]; then # apostrophe
# Trög°litz is probably an error
## 		cat words/$language/*|grep -v "[+'°]" |sort|uniq >words/$language/gathered
## 	elif [ $language = ca -o $language = ca_ES-valencia ]; then # numerals subscriptnumerals superscriptnumerals apostrophe plus
## 		cat words/$language/*|grep -v "[0-9¹²³₁₂₃+']" |sort|uniq >words/$language/gathered
## #	elif [ $language = te_IN ]; then # Uxc02 ం
## #		cat words/$language/*|grep -v "[ ంు]"  |sort|uniq >words/$language/gathered
## 	elif [ $language = se ]; then # -BOL EOL- underscore ampersand
## 		cat words/$language/*|grep -v [_\&²³] |grep -v "^-"|grep -v "\-$"|sort|uniq >words/$language/gathered
## 	else
		cat gathered/$language/*|sort|uniq >gathered/$language/words
## 	fi

### FOR ANALYSIS PURPOSES ONLY
#	for file in gathered/$language/*; do
#		../0-tools/histogram.py $file > gathered/$language/`basename $file`-histogram.md
#	done

	wc -l gathered/$language/words|awk '{print $1}' > gathered/$language/words.total
	echo ', totaling '`cat gathered/$language/words.total`
	echo '`'`cat gathered/$language/words.total`'` |' >> Gathered-Words.md

fi # errors that need fixing
done
