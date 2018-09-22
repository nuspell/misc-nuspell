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


## 1 Gather words

Gathering words from dictionary files and from word lists to do regression testing on with:

    ./1-gather.sh

This will create a word list called `gathered/LANGUAGE/words` such as `gathered/nl_NL/words`. Note that the directory also will contain intermediate words list from the dictionary or source word list file. A file called `words.total` will contian the total word count of the file `words`. The script can be tuned also generate histograms for analysis purposes.

The output of the script is:

    Gathering words for af_ZA, totaling 125470
    Gathering words for an_ES, totaling 20535
    Gathering words for ar, totaling 108362
    ...
    Gathering words for zu_ZA, totaling 73194

The file `Gathered-Words.md` will contain a table with the same information.


### 1.1 Note

Sorting is used via `sort` in order to merge source word lists with `uniq`. However, for the following languages, sorting takes extremely long:
    * `ko`
    * `te_IN`
    * `th_TH`

Therefore these language are not included in further testing at the moment.


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
    ...
    Running Hunspell on gathered words for vi_VN, scoring 100.000%


## 3 Regression test

Run regression test with Nuspell for latest commit or any specific commit on gathered word lists and compare with results from reference

    ./3-regression.sh [commit]


The output of the script is:

    Running Nuspell 44d9cb6 for af_ZA on 124308 gathered words, scoring 99.277%
    Running Nuspell 44d9cb6 for ar on 108362 gathered words, scoring 100.000%
    Running Nuspell 44d9cb6 for be_BY on 81516 gathered words, scoring 100.000%
    ...
    Running Nuspell 44d9cb6 for vi_VN on 6631 gathered words, scoring 100.000%

Note that the third word in the output are the first seven characters of the commit used.


## 4 Reporting

Reporting on the output of reference and regression test is done with a Python script. Is is run byu:

    ./4-report.py

The output is at the moment mainly stored in text files. However, some overviews are already generated in MarkDown format as can be seen in the two screenshots below:

[![https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/example-confusion-matrix-all.png](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/example-confusion-matrix-all.png)](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/example-confusion-matrix-all.png)

[![https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/example-confusion-matrix-nl.png](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/example-confusion-matrix-nl.png)](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/example-confusion-matrix-nl.png)

In the nearby future also graphs will be part of the output to more easily compare the changes in functioanlity and performance from commit to commit.

The output of the script is:

    commit_dir: 44d9cb6ec97994743218ee6725e4195ff67f69b7_1528028190
    commit: 44d9cb6ec97994743218ee6725e4195ff67f69b7
    handle: 44d9cb6
    timestamp: 1528028190
    lang dir: af_ZA
    lang dir: ar
    lang dir: be_BY
    ...
    lang dir: vi_VN
