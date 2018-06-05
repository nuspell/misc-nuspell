# Testing - 1 Language Support (1-support)

This directory holds downloaded and processed Ubuntu packages containing language support for Hunspell and Nuspell. These are packages containing dictionary files and affix files.

Install the following packages:

     iconv python3


## 1.1 Download

The script `./1-download.sh` will download all known and practical language support packages. The downloaded DEB files can be found in the directory `debs`. Note that package `myspell-fo` still isn't refactored to a name for Hunspell. This is a bug. Other exceptions are some French packages who are alternative implementation or meta packages. The list of packages is retrieved from `apt-cache search`.

The directory `debs` is excluded from version management.

The output of the script is:

    Get:1 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-af all 1:5.2.5-1 [535 kB]
    Get:2 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-an all 0.2-2 [75.2 kB]
    Get:3 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-ar all 3.2-1 [824 kB]
    ...
    Get:67 http://nl.archive.ubuntu.com/ubuntu artful/universe amd64 hunspell-fr-comprehensive all 1:6.1-1 [328 kB] 
    Fetched 36.3 MB in 2min 42s (223 kB/s) 


## 1.2 Extract

The script `./2-extract.sh` will process all the downloaded packages and extract the language support files in terms of affix files and dictionary files to the directory `packages`. Not that it will use the package version in the path names it creates. This script is very straight forward, but has to handle the exception for Myspell.

The directory `packages` is excluded from version management.

The output of the script is:

    af	1%3a6.0.3-3
    an	0.2-2
    ar	3.2-1
    ...
    tl	0.4-0-17


## 1.3 Report and Convert

The script `./3-report-and-convert.sh` reports on the affix and dictionary files and and, where needed, converts them to UTF-8. The report can be found in `Dictionary-Files.md`. The report also mentions encoding differences between the affix file and the dictionary file. All word list files in UTF-8 format can be found in the directory `utf8`.

Additionally, in the `utf8` directory are also histogram files in order to assess which characters are used in the dictionary file. These file have a name ending with `-histogram.tsv` and cointain tab characters for separtion of values.

These histrograms might be used to filter words with e.g. a period or splitting words on spaces when using these words for testing. Note that histograms are generated over the complete dictionary file, including word count, flags, comments whitespaces and license information.

The directory `utf8` is excluded from version management.

The output of the script is:

    af_ZA
    an_ES
    ar
    ...
    vi_VN


## 1.4 Analysis

The script `4-analyse_under_development.py` is currently being refactored. Do not use it yet.
