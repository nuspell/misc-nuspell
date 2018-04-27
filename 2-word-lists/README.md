# 2-word-lists

This directory holds downloaded and processed Ubuntu packages containing word lists.

## Download

The script `./1-download.sh` will download all known and practical word list packages. The downloaded DEB files can be found in the directory `debs`. The packages names are collected by iterating all downloaded Hunspell language support packages and looking up the related word list via the custom script `../0-tools/hunspell_language_support_to_word_list_name.sh`.

This script will also mitigate some bugs in the packages, such as incorrect direction of symbolic links. The filename of the word list should be in English and any native filenames for the particular language should be used in symbolic links.

The directory `debs` is excluded from version management.

The output of the script is:

    Get:1 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wamerican all 2017.01.22-1 [207 kB]
    Get:2 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wbrazilian all 3.0~beta4-19 [454 kB]
    Get:3 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wbritish all 2017.01.22-1 [207 kB]
    Get:4 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wbulgarian all 4.1-3ubuntu1 [2,102 kB]
    Get:5 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wcatalan all 0.20111230b-10 [1,018 kB]
    Get:6 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wdanish all 1.6.36-9 [646 kB]
    Get:7 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wdutch all 1:2.10-5 [1,137 kB]
    Get:8 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wfaroese all 0.4.2-11 [912 kB]
    Get:9 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wfrench all 1.2.3-10.1 [273 kB]
    Get:10 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wgalician-minimos all 0.5-43 [859 kB]
    Get:11 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 witalian all 1.8 [223 kB]
    Get:12 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wngerman all 20161207-1 [690 kB] 
    Get:13 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wnorwegian all 2.2-3 [3,199 kB]
    Get:14 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wpolish all 20170707-1 [6,936 kB]
    Get:15 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wportuguese all 20170814-1 [780 kB]
    Get:16 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wspanish all 1.0.27 [211 kB]
    Get:17 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wswedish all 1.4.5-2.2 [233 kB]
    Get:18 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 wswiss all 20161207-1 [690 kB]
    Get:19 http://nl.archive.ubuntu.com/ubuntu artful/universe amd64 wcanadian all 2017.01.22-1 [207 kB]
    Get:20 http://nl.archive.ubuntu.com/ubuntu artful/universe amd64 wgaelic all 0.50-12 [41.3 kB]
    Fetched 21.0 MB in 1min 14s (282 kB/s)

## Extract

The script `./2-extract.sh` will process all the downloaded packages and extract the word list files to the directory `packages`. Not that it will use the package version in the path names it creates. This script is very straight forward.

The directory `packages` is excluded from version management.

## Report and Convert

The script `./3-report-and-convert.sh` reports on the word list files and and, where needed, converts them to UTF-8. The report can be found in `Word-List-Files.md`. The report also mentions encoding differences with Hunspell language support files. All word list files in UTF-8 format can be found in the directory `utf8`.

Additionally, in the `utf8` directory are also histogram files in order to assess which characters are used. These file have a name ending with `-histogram.tsv` and cointain tab characters for separtion of values.

These histrograms might be used to filter words with e.g. a period or splitting words on spaces when using these words for testing.

The directory `utf8` is excluded from version management.
