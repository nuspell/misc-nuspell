# Testing - 2 Word Lists (2-word-lists)

This directory holds downloaded and processed Ubuntu packages containing word lists.


## 2.1 Download

The script `./1-download.sh` will download all known and practical word list packages. The downloaded DEB files can be found in the directory `debs`. The packages names are collected by iterating all downloaded Hunspell language support packages and looking up the related word list via the custom script `../0-tools/language_support_to_word_list_name.sh`.

This script will also mitigate some bugs in the packages, such as incorrect direction of symbolic links. The filename of the word list should be in English and any native filenames for the particular language should be used in symbolic links.

The directory `debs` is excluded from version management.

The output of the script is:

    Get:1 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wamerican all 2017.01.22-1 [207 kB]
    Get:2 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wbrazilian all 3.0~beta4-19 [454 kB]
    Get:3 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wbritish all 2017.01.22-1 [207 kB]
    ...
    Get:20 http://nl.archive.ubuntu.com/ubuntu artful/universe amd64 wgaelic all 0.50-12 [41.3 kB]
    Fetched 21.0 MB in 1min 14s (282 kB/s)


## 2.2 Extract

The script `./2-extract.sh` will process all the downloaded packages and extract the word list files to the directory `packages`. Not that it will use the package version in the path names it creates. This script is very straight forward.

The directory `packages` is excluded from version management.

The output of the script is:

    wamerican	2017.08.24-1
    wbrazilian	3.0~beta4-20
    wbritish	2017.08.24-1
    ...
    wukrainian	1.7.1-2


## 2.3 Report and Convert

The script `./3-report-and-convert.sh` reports on the word list files and and, where needed, converts them to UTF-8. The report can be found in `Word-List-Files.md`. The report also mentions encoding differences with Hunspell language support files. All word list files in UTF-8 format can be found in the directory `utf8`.

Additionally, in the `utf8` directory are also histogram files in order to assess which characters are used. These file have a name ending with `-histogram.tsv` and cointain tab characters for separtion of values.

These histrograms might be used to filter words with e.g. a period or splitting words on spaces when using these words for testing.

The directory `utf8` is excluded from version management.

The output of the script is:

    american-english
    brazilian
    british-english
    ...
    ukrainian
