# 3-checks

First, run this:

    cd ../1-support
    ./1-download.sh
    ./2-extract.sh
    ./3-report-and-convert.sh
    cd ../2-word-lists
    ./1-download.sh
    ./2-extract.sh
    ./3-report-and-convert.sh

## 1 Prepare word lists

Prepare word lists from Hunspell language support dictionary files and from word lists to do regression testing on with:

    ./1-prepare.sh

This will create a word list called `words/PLATFORM/LANGUAGE/gathered` such as `words/linux/nl_NL/gathered`. Note that in that directory are also some other files and histograms. In `words/linux/time-HOSTNAME` will be the time in seconds that it took to prepare all word lists.

The output of the script is:

    Gathering words for ar, totaling 108364
    Gathering words for be_BY, totaling 81516
    Gathering words for bn_BD, totaling 110750
    Gathering words for bo, totaling 376
    Gathering words for br_FR, totaling 464627
    Gathering words for bs_BA, totaling 30442
    Gathering words for ca, totaling 655439
    Gathering words for ca_ES-valencia, totaling 128053
    Gathering words for cs_CZ, totaling 165085
    Gathering words for da_DK, totaling 388125
    Gathering words for de_AT, totaling 71981
    Gathering words for de_AT_frami, totaling 243760
    Gathering words for de_CH, totaling 381037
    Gathering words for de_CH_frami, totaling 552521
    Gathering words for de_DE, totaling 380889
    Gathering words for de_DE_frami, totaling 552753
    Gathering words for dz, totaling 401
    Gathering words for en_AU, totaling 49837
    Gathering words for en_CA, totaling 82388
    Gathering words for en_GB, totaling 97007
    Gathering words for en_US, totaling 94055
    Gathering words for en_ZA, totaling 50085
    Gathering words for eu, totaling 106319
    Gathering words for fo, totaling 425089
    Gathering words for fr, totaling 186604
    Gathering words for gd_GB, totaling 288008
    Gathering words for gl_ES, totaling 551223
    Gathering words for gu_IN, totaling 168951
    Gathering words for he_IL, totaling 464946
    Gathering words for hi_IN, totaling 15983
    Gathering words for hu_HU, totaling 85203
    Gathering words for is_IS, totaling 191571
    Gathering words for it_IT, totaling 183594
    Gathering words for kmr_Latn, totaling 4734
    Gathering words for lo_LA, totaling 18
    Gathering words for ml_IN, totaling 142402
    Gathering words for ne_NP, totaling 34576
    Gathering words for nl_NL, totaling 351602
    Gathering words for nb_NO, totaling 932037
    Gathering words for oc_FR, totaling 54919
    Gathering words for pt_PT, totaling 419581
    Gathering words for ro_RO, totaling 168725
    Gathering words for ru_RU, totaling 146269
    Gathering words for se, totaling 297413
    Gathering words for si_LK, totaling 30319
    Gathering words for sk_SK, totaling 246133
    Gathering words for sl_SI, totaling 246856
    Gathering words for sr_Latn_RS, totaling 222280
    Gathering words for sr_RS, totaling 222281
    Gathering words for sv_FI, totaling 149589
    Gathering words for sv_SE, totaling 245764
    Gathering words for sw_TZ, totaling 67564
    Gathering words for uk_UA, totaling 111375
    Gathering words for uz_UZ, totaling 97000
    Gathering words for vi_VN, totaling 6631


## 2 Create reference test

Run Hunspell on gathered word lists to get reference for word correctness and speed

    ./2-reference.sh

This will create a directories and files in the form of:
* `references/PLATFORM/LANGUAGE/gathered.full` containing the full result from Hunspell
* `references/PLATFORM/LANGUAGE/gathered.words` containing only the words passed into Hunspell
* `references/PLATFORM/LANGUAGE/gathered` containing only the spellling for the words passed into Hunspell
* `references/PLATFORM/LANGUAGE/gathered.tsv` containing the spelling result from Hunspell and the word separated passed in, with a tab
* `references/PLATFORM/LANGUAGE/gathered.correct` containing the number of correct words
* `references/PLATFORM/LANGUAGE/time-HOSTNAME` containing the time in seconds that it took to run this

The output of the script is:

    Running Hunspell on gathered words for be_BY, scoring 100.000%
    Running Hunspell on gathered words for bo, scoring 91.755%
    Running Hunspell on gathered words for br_FR, scoring 99.998%
    Running Hunspell on gathered words for ca, scoring 99.593%
    Running Hunspell on gathered words for ca_ES-valencia, scoring 99.971%
    Running Hunspell on gathered words for da_DK, scoring 94.415%
    Running Hunspell on gathered words for de_AT, scoring 70.024%
    Running Hunspell on gathered words for de_AT_frami, scoring 67.844%
    Running Hunspell on gathered words for de_CH, scoring 94.332%
    Running Hunspell on gathered words for de_CH_frami, scoring 85.228%
    Running Hunspell on gathered words for de_DE, scoring 94.341%
    Running Hunspell on gathered words for de_DE_frami, scoring 85.272%
    Running Hunspell on gathered words for dz, scoring 92.518%
    Running Hunspell on gathered words for en_AU, scoring 99.993%
    Running Hunspell on gathered words for en_CA, scoring 98.805%
    Running Hunspell on gathered words for en_GB, scoring 93.313%
    Running Hunspell on gathered words for en_US, scoring 98.384%
    Running Hunspell on gathered words for en_ZA, scoring 99.662%
    Running Hunspell on gathered words for fo, scoring 99.995%
    Running Hunspell on gathered words for fr, scoring 99.043%
    Running Hunspell on gathered words for gd_GB, scoring 98.947%
    Running Hunspell on gathered words for gl_ES, scoring 41.112%
    Running Hunspell on gathered words for he_IL, scoring 97.334%
    Running Hunspell on gathered words for is_IS, scoring 99.998%
    Running Hunspell on gathered words for it_IT, scoring 99.685%
    Running Hunspell on gathered words for kmr_Latn, scoring 100.000%
    Running Hunspell on gathered words for lo_LA, scoring 100.000%
    Running Hunspell on gathered words for nl_NL, scoring 98.542%
    Running Hunspell on gathered words for nb_NO, scoring 95.324%
    Running Hunspell on gathered words for oc_FR, scoring 99.947%
    Running Hunspell on gathered words for ro_RO, scoring 99.712%
    Running Hunspell on gathered words for se, scoring 60.266%
    Running Hunspell on gathered words for sk_SK, scoring 99.999%
    Running Hunspell on gathered words for sr_RS, scoring 100.000%
    Running Hunspell on gathered words for sv_FI, scoring 97.344%
    Running Hunspell on gathered words for sv_SE, scoring 96.583%
    Running Hunspell on gathered words for sw_TZ, scoring 99.968%
    Running Hunspell on gathered words for uk_UA, scoring 100.000%
    Running Hunspell on gathered words for uz_UZ, scoring 100.000%
    Running Hunspell on gathered words for vi_VN, scoring 100.000%


## 3 Regression test

UNDER DEVELOPMENT:

Run current local (and uncommitted) development version of Nuspell (from `../nuspell`) on gathered word lists and compare with results from reference

    ./3-current.sh

Run regression test with Nuspell for latest commit or any specific commit on gathered word lists and compare with results from reference

    ./4-regression.sh

## 4 Reporting

TODO


## 5 Profiling

Profiling by means of perf and vallgrind (callgrind) is done by running the script:

    ./5-profiling.sh

The software needed is installed with:

    sudo apt-get install valgrind kcachegrind linux-tools-common linux-tools-generic linux-tools-4.15.0-20-generic

Before running the profiling script, make sure that at least the gathered word lists have been generated, see above.


### Perf and hotspot

First, go to a specific directory such as `./profiling/de_DE_frami`. The results for perf are in `perf.data` and can be viewed by:

    perf report
    perf list

A gui for viewing perf's results is [hotspot](https://github.com/KDAB/hotspot).


### Callgrind and kcachegrind

To view the results from callgrind, go as well to a specific directory such as `./profiling/de_DE_frami` and run `kcachegrind`. It will open for the results in `callgrind.out.NUMBER`.

#### Qt Creator

TODO, see http://doc.qt.io/qtcreator/creator-cpu-usage-analyzer.html

