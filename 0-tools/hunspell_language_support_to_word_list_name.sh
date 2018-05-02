#!/usr/bin/env bash

# Name: hunspell_language_support_to_wordlist_name.sh
# Description: Converts a Hunspell language support in terms of Debian/Ubuntu
# package language code and Hunspell's dictionary language code to a wordlist
# package name and wordlist file name. The Hunspell dictionary language code
# can be found in filenames in .aff or .dic files in /usr/share/hunspell/. The
# wordlist filenames can be found in /usr/share/dict/*. For example, package
# en-us with language en_US is converted to wordlist package name wamerican
# and wordlist filename american-english. Another example is de-ch-frami with
# de_CH_frami which converts to wswiss swiss.
# License: MPL 1.1/GPL 2.0/LGPL 2.1
# Author: Pander <pander@users.sourceforge.net>

#TODO Rewrite this scripts as Python 3 script in order for analyse.py to use
# it and make it platform independent.

#TODO Support all Hunspell languages and dictionary files.
# wogerman wgerman-medical
# wmanx
# dict-freedict-afr-eng dict-freedict-ara-eng dict-freedict-bre-fra
# dict-freedict-isl-eng dict-freedict-lit-eng dict-freedict-nno-nob
# dict-freedict-oci-cat
# apertium-arg apertium-br-fr apertium-eu-en apertium-kaz apertium-nno

if [ $# -ne 1 ]
then
    echo 'ERROR: Missing language code'
    exit 1
fi

case $1 in
bg_BG)
	echo -e $1'\twbulgarian\tbulgarian'
	;;
#FIXME    ca_ES)
#FIXME    ca_ES-valencia)
ca)
	echo -e $1'\twcatalan\tcatala'  #FIXME Reverse symbolic link and file.
	;;
da_DK)
	echo -e $1'\twdanish\tdanish'
	;;
#TODO de-at)
#TODO de-at-frami)
de_CH)
	echo -e $1'\twswiss\tswiss'
	;;
de_CH_frami)
	echo -e $1'\twswiss\tswiss'
	;;
#FIXME    de_BE)
#FIXME    de_LU)
de_DE)
	echo -e $1'\twngerman\tngerman'
	;;
#FIXME    de_DE)
#INFO there is also wogerman for old german
de_DE_frami)
        echo -e $1'\twngerman\tngerman'
        ;;
en_CA)
	# wcanadian-huge wcanadian-insane wcanadian-large wcanadian-small
	echo -e $1'\twcanadian\tcanadian-english'
;;
en_GB)
	# wbritish-huge wbritish-insane wbritish-large wbritish-small
	echo -e $1'\twbritish\tbritish-english'
;;
en_US)
	# wamerican-huge wamerican-insane wamerican-large wamerican-small
	echo -e $1'\twamerican\tamerican-english'
	;;
#FIXME    es_AR)
#FIXME    es_BO)
#FIXME    es_CL)
#FIXME    es_CO)
#FIXME    es_CR)
#FIXME    es_CU)
#FIXME    es_DO)
#FIXME    es_EC)
#FIXME    es_GT)
#FIXME    es_HN)
#FIXME    es_MX)
#FIXME    es_NI)
#FIXME    es_PA)
#FIXME    es_PE)
#FIXME    es_PR)
#FIXME    es_PY)
#FIXME    es_SV)
#FIXME    es_US)
#FIXME    es_UY)
#FIXME    es_VE)
es_ES)
	echo -e $1'\twspanish\tspanish'
	;;
#FIXME    fo_FO)
fo)
	echo -e $1'\twfaroese\tfaroese'
	;;
#FIXME    fr_BE)
#FIXME    fr_CA)
#FIXME    fr_CH)
#FIXME    fr_FR)
#FIXME    fr_LU)
#FIXME    fr_MC)
fr)
	echo -e $1'\twfrench\tfrench'
	;;
gd_GB)
	echo -e $1'\twgaelic\tgaelic'
	;;
gl_ES)
	echo -e $1'\twgalician-minimos\tgalician-minimos'
	;;
#FIXME    it_CH)
it_IT)
	echo -e $1'\twitalian\titalian'
	;;
#FIXME    nl_BE)
#FIXME    nl_NL)
nl)
	echo -e $1'\twdutch\tdutch'
	;;
nb_NO)
	echo -e $1'\twnorwegian\tbokmaal'
	;;
nn_NO)
	#FIXME norsk -> /etc/dictionaries-common/norsk Is this correct? Not nynorsk?
	echo -e $1'\twnorwegian\tnynorsk'
	;;
pl_PL)
	echo -e $1'\twpolish\tpolish'
	;;
pt_BR)
	echo -e $1'\twbrazilian\tbrazilian'
	;;
pt_PT)
	echo -e $1'\twportuguese\tportuguese'
	;;
sv_SE)
	echo -e $1'\twswedish\tswedish'
	;;
*)
	echo 'ERROR: Unsupported package '$1
	exit 1
	;;
esac
