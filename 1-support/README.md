# 1-support

This directory holds downloaded and processed Ubuntu packages containing language support for Hunspell and Nuspell. These are packages containing dictionary files and affix files.

## Download

The script `./1-download.sh` will download all known and practical language support packages. The downloaded DEB files can be found in the directory `debs`. Note that package `myspell-fo` still isn't refactored to a name for Hunspell. This is a bug. Other exceptions are some French packages who are alternative implementation or meta packages. The list of packages is retrieved from `apt-cache search`.

The directory `debs` is excluded from version management.

The output of the script is:

    Get:1 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-af all 1:5.2.5-1 [535 kB]
    Get:2 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-an all 0.2-2 [75.2 kB]
    Get:3 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-ar all 3.2-1 [824 kB]
    Get:4 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-be all 0.53-3 [364 kB] 
    Get:5 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-bg all 1:5.2.5-1 [246 kB]
    Get:6 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-bn all 1:5.2.5-1 [295 kB]
    Get:7 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-bo all 0.4.0-1 [6,572 B] 
    Get:8 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-br all 0.12-2 [723 kB] 
    Get:9 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-bs all 1:5.2.5-1 [138 kB]
    Get:10 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-ca all 3.0.2+repack1-2 [424 kB] 
    Get:11 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-cs all 1:5.2.5-1 [535 kB] 
    Get:12 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-da all 1:5.2.5-1 [566 kB] 
    Get:13 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-de-at all 20161207-1 [284 kB] 
    Get:14 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-de-at-frami all 1:5.2.5-1 [988 kB]
    Get:15 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-de-ch all 20161207-1 [284 kB] 
    Get:16 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-de-ch-frami all 1:5.2.5-1 [987 kB]
    Get:17 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-de-de all 20161207-1 [284 kB] 
    Get:18 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-de-de-frami all 1:5.2.5-1 [988 kB]
    Get:19 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-dz all 0.1.0-1 [6,936 B]
    Get:20 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-el all 1:5.2.5-1 [1,617 kB] 
    Get:21 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-en-au all 1:5.2.5-1 [264 kB]
    Get:22 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-en-ca all 1:5.2.5-1 [202 kB]
    Get:23 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-en-gb all 1:5.2.5-1 [272 kB]
    Get:24 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-en-us all 20070829-6ubuntu3 [206 kB]
    Get:25 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-en-za all 1:5.2.5-1 [273 kB]
    Get:26 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-es all 1:5.2.5-1 [242 kB] 
    Get:27 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-eu all 0.5.20151110-2 [564 kB]
    Get:28 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-gd all 1:5.2.5-1 [737 kB] 
    Get:29 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-gl-es all 13.10-1 [332 kB]
    Get:30 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-gu all 1:5.2.5-1 [538 kB] 
    Get:31 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-he all 1:5.2.5-1 [694 kB] 
    Get:32 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-hi all 1:5.2.5-1 [91.6 kB]
    Get:33 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-hr all 1:5.2.5-1 [515 kB] 
    Get:34 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-hu all 1:5.2.5-1 [590 kB] 
    Get:35 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-is all 1:5.2.5-1 [598 kB] 
    Get:36 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-it all 1:5.2.5-1 [339 kB] 
    Get:37 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-kk all 1.1-2 [216 kB] 
    Get:38 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-kmr all 1:5.2.5-1 [57.4 kB] 
    Get:39 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-ko all 0.6.4-1 [2,618 kB] 
    Get:40 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-lo all 1:5.2.5-1 [77.3 kB]
    Get:41 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-lt all 1:5.2.5-1 [313 kB] 
    Get:42 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-ml all 0.1-2 [739 kB] 
    Get:43 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-ne all 1:5.2.5-1 [176 kB] 
    Get:44 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-nl all 1:5.2.5-1 [569 kB] 
    Get:45 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-no all 1:5.2.5-1 [1,604 kB] 
    Get:46 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-oc all 1:5.2.5-1 [200 kB] 
    Get:47 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-pl all 1:5.2.5-1 [953 kB] 
    Get:48 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-pt-br all 1:5.2.5-1 [1,163 kB]
    Get:49 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-pt-pt all 1:5.2.5-1 [232 kB]
    Get:50 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-ro all 1:5.2.5-1 [527 kB] 
    Get:51 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-ru all 1:5.2.5-1 [463 kB] 
    Get:52 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-se all 1.0~beta6.20081222-1.2 [3,323 kB]
    Get:53 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-si all 1:5.2.5-1 [264 kB] 
    Get:54 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-sk all 1:5.2.5-1 [688 kB] 
    Get:55 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-sl all 1:5.2.5-1 [988 kB] 
    Get:56 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-sr all 1:5.2.5-1 [854 kB] 
    Get:57 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-sv all 1:5.2.5-1 [641 kB] 
    Get:58 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-sw all 1:5.2.5-1 [232 kB] 
    Get:59 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-te all 1:5.2.5-1 [466 kB] 
    Get:60 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-th all 1:5.2.5-1 [172 kB] 
    Get:61 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-uk all 1:5.2.5-1 [435 kB] 
    Get:62 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-uz all 0.6-4 [224 kB] 
    Get:63 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 hunspell-vi all 1:5.2.5-1 [50.7 kB]
    Get:64 http://nl.archive.ubuntu.com/ubuntu artful/main amd64 myspell-fo all 0.4.2-11 [896 kB] 
    Get:65 http://nl.archive.ubuntu.com/ubuntu artful/universe amd64 hunspell-de-med all 20160103-1 [47.5 kB] 
    Get:66 http://nl.archive.ubuntu.com/ubuntu artful/universe amd64 hunspell-en-med all 0.0.20080513-2 [166 kB]
    Get:67 http://nl.archive.ubuntu.com/ubuntu artful/universe amd64 hunspell-fr-comprehensive all 1:6.1-1 [328 kB] 
    Fetched 36.3 MB in 2min 42s (223 kB/s) 

## Extract

The script `./2-extract.sh` will process all the downloaded packages and extract the language support files in terms of affix files and dictionary files to the directory `packages`. Not that it will use the package version in the path names it creates. This script is very straight forward, but has to handle the exception for Myspell.

The directory `packages` is excluded from version management.

## Report and Convert

The script `./3-report-and-convert.sh` reports on the affix and dictionary files and and, where needed, converts them to UTF-8. The report can be found in `Dictionary-Files.md`. The report also mentions encoding differences between the affix file and the dictionary file. All word list files in UTF-8 format can be found in the directory `utf8`.

Additionally, in the `utf8` directory are also histogram files in order to assess which characters are used in the dictionary file. These file have a name ending with `-histogram.tsv` and cointain tab characters for separtion of values.

These histrograms might be used to filter words with e.g. a period or splitting words on spaces when using these words for testing. Note that histograms are generated over the complete dictionary file, including word count, flags, comments whitespaces and license information.

The directory `utf8` is excluded from version management.

## Analyssis

The script `4-analyse_under_development.py` is currently being refactored. Do not use it yet.
