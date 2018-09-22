# Testing - 1 Language Support (1-support)

This directory holds downloaded and processed Ubuntu packages containing language support for Hunspell and Nuspell. These are packages containing dictionary files and affix files.

Install the following packages:

     iconv python3


## 1.1 Download

The script `./1-download.sh` will download all known and practical language support packages. The downloaded DEB files can be found in the directory `debs`. Note that package `myspell-fo` still isn't refactored to a name for Hunspell. This is a bug. Other exceptions are some French packages who are alternative implementation or meta packages. The list of packages is retrieved from `apt-cache search`.

The directory `debs` is excluded from version management.

The output of the script is:

    Skipping package myspell-bg...
    Skipping package myspell-cs...
    Skipping package myspell-da...
    ...
    Skipping package hunspell-gl...
    Get:1 http://nl.archive.ubuntu.com/ubuntu bionic/main amd64 hunspell-af all 1:6.0.3-3 [535 kB]
    Get:2 http://nl.archive.ubuntu.com/ubuntu bionic/main amd64 hunspell-an all 0.2-2 [75.2 kB]
    Get:3 http://nl.archive.ubuntu.com/ubuntu bionic/main amd64 hunspell-ar all 3.2-1 [824 kB]
    ...
    Get:64 http://nl.archive.ubuntu.com/ubuntu bionic/main amd64 hunspell-vi all 1:6.0.3-3 [51.4 kB]
    Get:65 http://nl.archive.ubuntu.com/ubuntu bionic/main amd64 myspell-eo all 2.1.2000.02.25-55 [83.6 kB]
    Get:66 http://nl.archive.ubuntu.com/ubuntu bionic/main amd64 myspell-et all 1:20030606-27 [637 kB]
    Get:67 http://nl.archive.ubuntu.com/ubuntu bionic/main amd64 myspell-fa all 0.20070816-3 [921 kB]
    ...
    Get:86 http://nl.archive.ubuntu.com/ubuntu bionic/universe amd64 myspell-tl all 0.4-0-17 [50.6 kB]
    Fetched 38.3 MB in 18s (2,166 kB/s)


## 1.2 Extract

The script `./2-extract.sh` will process all the downloaded packages and extract the language support files in terms of affix files and dictionary files to the directory `packages`. Not that it will use the package version in the path names it creates. This script is very straight forward, but has to handle the exception for Myspell.

The directory `packages` is excluded from version management.

The output of the script is:

    hunspell-af 1%3a6.0.3-3
    hunspell-an 0.2-2
    hunspell-ar 3.2-1
    ...
    hunspell-vi 1%3a6.0.3-3
    myspell-eo  2.1.2000.02.25-55
    myspell-et  1%3a20030606-27
    myspell-fa  0.20070816-3
    ...
    myspell-zu  20070207-5ubuntu2


## 1.3 Report and Convert

The script `./3-report-and-convert.sh` reports on the affix and dictionary files and, where needed, converts them to UTF-8. The report can be found in `Dictionary-Files.md`. The report also mentions encoding differences between the affix file and the dictionary file. All word list files in UTF-8 format can be found in the directory `utf8` as `.txt` files.

Additionally, in the `utf8` directory are also histogram files in order to assess which characters are used in the dictionary file. These file have a name ending with `-histogram.tsv` and cointain tab characters for separtion of values.

These histrograms might be used to filter words with e.g. a period or splitting words on spaces when using these words for testing. Note that histograms are generated over the complete dictionary file, including word count, flags, comments whitespaces and license information.

The directory `utf8` is excluded from version management.

The output of the script is:

    af_ZA       ISO8859-1
    an_ES       ISO8859-1
    ar  UTF-8
    ...
    zu_ZA	ISO8859-1
    WARNING: Removing trailing slash in ./hunspell-an/0.2-2/usr/share/hunspell/an_ES.dic
    WARNING: Fixing line terminators in ./hunspell-ca/3.0.2+repack1-2/usr/share/hunspell/ca.dic
    WARNING: Fixing line terminators in ./hunspell-ca/3.0.2+repack1-2/usr/share/hunspell/ca_ES-valencia.dic
    ...
    WARNING: Removing trailing slash in ./myspell-lv/0.9.6-5/usr/share/hunspell/lv_LV.dic

The displayed warnings can also be found in a file called `warnings.txt`.


## 1.4 Histogram

Histrograms can be made of the dictionary files which are placed as `.txt` files in the `utf8` directory. Running the script `./4-histogram.sh` will create histograms in `-histogram.md` files in Markdown format in the `utf8` directory. Examples are `utf8/en_US-histogram.md` and `utf8/zu_ZA-histogram.md`.

The histograms will first report the presence of special characters such as slashed et cetera and then provide a table on how many times a character was counted. Information is provided per character on its count, its Unicode representation, its Unicode codepoint, its Unicode catergory and its Unicode name.

The output of the script is:

    af_ZA
    an_ES
    ar
    ...
    zu_ZA
