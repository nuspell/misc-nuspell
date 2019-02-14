# 4-profiling

Profiling can identify which methods use which amount of processing power.


## 1 Installing

The software needed is installed with:

    sudo apt-get install valgrind kcachegrind linux-tools-common \
    linux-tools-generic linux-tools-4.18.0-15-generic

In order to run perf, the following change has to be made to the operating system. Add to the file `/etc/sysctl.conf` the follwing line, save and reboot: 

    kernel.perf_event_paranoid = -1


## 2 Application preparation

Nuspell should be available in `../../nuspell` and should be build with

    ./configure CXXFLAGS='-Og -g3 -ggdb -fno-omit-frame-pointer'
    make


## 3 Data preparation

Also dictionaries and word lists should be made available via

    cd ../1-support
    ./1-download.sh
    ./2-extract.sh
    ./3-report-and-convert.sh
    cd ../2-word-lists
    ./1-download.sh
    ./2-extract.sh
    ./3-report-and-convert.sh


## 4 Running profiler

Consider removing content of `~/.debug/` before continuing.

Profiling by means of [perf](https://perf.wiki.kernel.org/index.php/Main_Page) and [vallgrind](http://valgrind.org/) ([callgrind](http://valgrind.org/docs/manual/cl-manual.html)) is done by running the scripts:

    ./1-profile.sh
    ./2-specific.sh
    ./3-verify.sh

See the content of the scripts for what is being profiled.


### 5.1 Analysis with perf and hotspot

First, go to a specific directory such as `./results/de_DE_frami` or  `./results/en_US`. The results for perf are in `perf.data` and can be viewed by:

    perf report
    perf list

A gui for viewing perf's results is [hotspot](https://github.com/KDAB/hotspot), which will also open the `perf.data` file from the directry from which it is started.

Below is an impression of the overviews and visualisations offered by hotspot.

[![https://raw.githubusercontent.com/hunspell/misc-hunspell/master/4-profiling/images/hotspot_graphflame.png](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/4-profiling/images/hotspot_graphflame.png)](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/4-profiling/images/hotspot_graphflame.png)

[![https://raw.githubusercontent.com/hunspell/misc-hunspell/master/4-profiling/images/hotspot_topdown.png](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/4-profiling/images/hotspot_topdown.png)](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/4-profiling/images/hotspot_topdown.png)


### 5.2 Analysis with callgrind and KCachegrind

Use [Kcachegrind](https://kcachegrind.github.io/) to view the results from callgrind. go as well to a specific directory such as `./results/de_DE_frami` or `./results/en_US` and run `kcachegrind`. It will open for the results in `callgrind.out.NUMBER`.

Below is an impression of the overviews and visualisations offered by kcachegrind.

[![https://raw.githubusercontent.com/hunspell/misc-hunspell/master/4-profiling/images/kcachegrind_screenshot.png](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/4-profiling/images/kcachegrind_screenshot.png)](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/4-profiling/images/kcachegrind_screenshot.png)

[![https://raw.githubusercontent.com/hunspell/misc-hunspell/master/4-profiling/images/kcachegrind_callgraph.png](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/4-profiling/images/kcachegrind_callgraph.png)](https://raw.githubusercontent.com/hunspell/misc-hunspell/master/4-profiling/images/kcachegrind_callgraph.png)


### 5.3 Analysis with Qt Creator

Qt Creator can also offer profiling. For Nuspell, this has not been setup yet. See http://doc.qt.io/qtcreator/creator-cpu-usage-analyzer.html for more information.
