# 2-word-lists

This directory holds downloaded and processed Ubuntu packages containing word lists.

## Download

The script `./1-download.sh` will download all known and practical word list packages. The packages names are collected by iterating all downloaded Hunspell language support packages and looking up the related word list via the custom script `../0-tools/hunspell_language_support_to_word_list_name.sh`. This script will also mitigate some bugs in the packages, such as incorrect direction of symbolic links. The downloaded DEB files can be found in the directory `debs`.

The directory `debs` is excluded from version management.

## Extract

The script `./2-extract.sh` will process all the downloaded packages and extract the word list files to the directory `packages`. Not that it will use the package version in the path names it creates. This script is very straight forward.

The directory `packages` is excluded from version management.

## Report and Convert

The script `./3-report-and-convert.sh` reports on the word list files and and, where needed, converts them to UTF-8. The report can be found in `Word-List-Files.md`. The report also mentions encoding differences with Hunspell language support files. All word list files in UTF-8 format can be found in the directory `utf8`.

Additionally, in the `utf8` directory are also histogram files in order to assess which characters are used. These file have a name ending with `-histogram.tsv` and cointain tab charcters for separtion of values.

These histrograms might be used to filter words with e.g. a period or splitting words on spaces when using these words for testing. The script `histogram.py` is used automatically for creating the histrograms.

The directory `utf8` is excluded from version management.
