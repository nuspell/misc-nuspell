#!/usr/bin/env bash

# Name: test_hunspell_language_support_to_wordlist_name.sh
# Description: Test the script hunspell_language_support_to_wordlist_name.sh
# License: MPL 1.1/GPL 2.0/LGPL 2.1
# Author: Pander <pander@users.sourceforge.net>

#TODO Optimise this script, also add echo for input.

./hunspell_language_support_to_wordlist_name.sh bg bg_BG
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh ca ca
if [ $? -ne 0 ]
then
    exit 1
fi
#FIXME ./hunspell_language_support_to_wordlist_name.sh ca ca_ES
if [ $? -ne 0 ]
then
    exit 1
fi
#FIXME ./hunspell_language_support_to_wordlist_name.sh ca ca_ES-valencia
#FIXME ca_ES-valencia should be ca_ES_valencia
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh da da_DK
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh de-ch de_CH
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh de-ch-frami de_CH_frami
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh de-de de_DE
if [ $? -ne 0 ]
then
    exit 1
fi
#FIXME ./hunspell_language_support_to_wordlist_name.sh de-de de_BE
if [ $? -ne 0 ]
then
    exit 1
fi
#FIXME ./hunspell_language_support_to_wordlist_name.sh de-de de_LU
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh de-de-frami de_DE_frami
if [ $? -ne 0 ]
then
    exit 1
fi
#./hunspell_language_support_to_wordlist_name.sh de-ch-frami de_DE
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh en-ca en_CA
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh en-gb en_GB
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh en-us en_US
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh es es_ES
if [ $? -ne 0 ]
then
    exit 1
fi
#TODO./hunspell_language_support_to_wordlist_name.sh fr-classical fr
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh fr-modern fr
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh fr-revised fr
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh fr-comprehensive fr
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh gd gd_GB
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh gl gl_ES
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh it it_IT
if [ $? -ne 0 ]
then
    exit 1
fi
#FIXME ./hunspell_language_support_to_wordlist_name.sh it it_CH
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh nl nl_NL
if [ $? -ne 0 ]
then
    exit 1
fi
#FIXME ./hunspell_language_support_to_wordlist_name.sh nl nl_BE
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh no nn_NO
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh no nb_NO
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh pl pl_PL
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh pt-br pt_BR
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh pt-pt pt_PT
if [ $? -ne 0 ]
then
    exit 1
fi
./hunspell_language_support_to_wordlist_name.sh sv sv_SE
if [ $? -ne 0 ]
then
    exit 1
fi
#FIXME ./hunspell_language_support_to_wordlist_name.sh sv sv_FI
if [ $? -ne 0 ]
then
    exit 1
fi
