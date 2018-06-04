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
    ...
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


## 5 Profiling

Profiling by means of [perf](https://perf.wiki.kernel.org/index.php/Main_Page) and [vallgrind](http://valgrind.org/) ([callgrind](http://valgrind.org/docs/manual/cl-manual.html)) is done by running the script:

    ./5-profiling.sh

The software needed is installed with:

    sudo apt-get install valgrind kcachegrind linux-tools-common linux-tools-generic linux-tools-4.15.0-20-generic

In order to run perf, the following change has to be made to the operating system. Add to the file `/etc/sysctl.conf` the follwing line, save and reboot: 

    kernel.perf_event_paranoid = -1


### 5.1 Perf and hotspot

First, go to a specific directory such as `./profiling/linux/de_DE_frami` or  `./profiling/linux/en_US`. The results for perf are in `perf.data` and can be viewed by:

    perf report
    perf list

A gui for viewing perf's results is [hotspot](https://github.com/KDAB/hotspot), which will also open the `perf.data` file from the directry from which it is started.

Below is an impression of the overviews and visualisations offered by hotspot.

[![https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/hotspot_graphflame.png](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/hotspot_graphflame.png)](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/hotspot_graphflame.png)

[![https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/hotspot_topdown.png](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/hotspot_topdown.png)](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/hotspot_topdown.png)


### 5.2 Callgrind and KCachegrind

Use [Kcachegrind](https://kcachegrind.github.io/) to view the results from callgrind. go as well to a specific directory such as `./profiling/linux/de_DE_frami` or `./profiling/linux/en_US` and run `kcachegrind`. It will open for the results in `callgrind.out.NUMBER`.

Below is an impression of the overviews and visualisations offered by kcachegrind.

[![https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/kcachegrind_screenshot.png](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/kcachegrind_screenshot.png)](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/kcachegrind_screenshot.png)

[![https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/kcachegrind_callgraph.png](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/kcachegrind_callgraph.png)](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/3-checks/images/kcachegrind_callgraph.png)


### 5.3 Qt Creator

Qt Creator can also offer profiling. For Nuspell, this has not been setup yet. See http://doc.qt.io/qtcreator/creator-cpu-usage-analyzer.html for more information.
