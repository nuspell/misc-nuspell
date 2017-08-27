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

if [ $# -ne 2 ]
then
    echo 'ERROR: Missing package code and language code'
    exit 1
fi

case $1 in
bg)
    case $2 in
    bg_BG)
        echo 'wbulgarian bulgarian'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
ca)
    case $2 in
#FIXME    ca_ES)
#FIXME    ca_ES-valencia)
    ca)
        echo 'wcatalan catalan'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
da)
    case $2 in
    da_DK)
        echo 'wdanish danish'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
#TODO de-at)
#TODO de-at-frami)
de-ch)
    case $2 in
    de_CH)
        echo 'wswiss swiss'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
de-ch-frami)
    case $2 in
    de_CH_frami)
        echo 'wswiss swiss'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
de-de)
    case "$2" in
#FIXME    de_BE)
#FIXME    de_LU)
    de_DE)
        echo 'wngerman ngerman'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
de-de-frami)
    case "$2" in
#FIXME    de_DE)
    de_DE_frami)
        echo 'wngerman ngerman'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
en-ca)
    case $2 in
    en_CA)
        # wcanadian-huge wcanadian-insane wcanadian-large wcanadian-small
        echo 'wcanadian canadian-english'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
en-gb)
    case $2 in
    en_GB)
        # wbritish-huge wbritish-insane wbritish-large wbritish-small
        echo 'wbritish british-english'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
en-us)
    case $2 in
    en_US)
        # wamerican-huge wamerican-insane wamerican-large wamerican-small
        echo 'wamerican american-english'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
es)
    case $2 in
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
        echo 'wspanish spanish'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
#FIXME Faroese myspell-fo should be hunspell-fo.
#TODO fr-classical)
fr-modern) #FIXME Fall-through to fr_comprehensive.
    case $2 in
#FIXME    fr_BE)
#FIXME    fr_CA)
#FIXME    fr_CH)
#FIXME    fr_FR)
#FIXME    fr_LU)
#FIXME    fr_MC)
    fr)
        echo 'wfrench french'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
fr-revised) #FIXME Fall-through to fr_comprehensive.
    case $2 in
#FIXME    fr_BE)
#FIXME    fr_CA)
#FIXME    fr_CH)
#FIXME    fr_FR)
#FIXME    fr_LU)
#FIXME    fr_MC)
    fr)
        echo 'wfrench french'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
fr-comprehensive)
    case $2 in
#FIXME    fr_BE)
#FIXME    fr_CA)
#FIXME    fr_CH)
#FIXME    fr_FR)
#FIXME    fr_LU)
#FIXME    fr_MC)
    fr)
        echo 'wfrench french'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
gd)
    case $2 in
    gd_GB)
        echo 'wgaelic gaelic'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
gl)
    case $2 in
    gl_ES)
        echo 'wgalician-minimos galician-minimos'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
it)
    case $2 in
#FIXME    it_CH)
    it_IT)
        echo 'witalian italian'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
nl)
    case $2 in
#FIXME    nl_BE)
    nl_NL)
        echo 'wdutch dutch'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
no)
    case $2 in
    nb_NO)
        echo 'wnorwegian bokmaal'
        ;;
    nn_NO)
        #FIXME norsk -> /etc/dictionaries-common/norsk Is this correct? Not nynorsk?
        echo 'wnorwegian nynorsk'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
pl)
    case $2 in
    pl_PL)
        echo 'wpolish polish'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
pt-br)
    case $2 in
    pt_BR)
        echo 'wbrazilian brazilian'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
pt-pt)
    case $2 in
    pt_PT)
        echo 'wportuguese portuguese'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
sv)
    case $2 in
#FIXME    sv_FI) #TODO Which wordlist package to use as different affix file and differnt dict files
    sv_SE)
        echo 'wswedish swedish'
        ;;
    *)
        echo 'ERROR: Package '$1' with unsupported language '$2
        exit 1
        ;;
    esac
    ;;
*)
    echo 'ERROR: Unsupported package '$1
    exit 1
    ;;
esac
