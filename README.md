# Misc Docs and Charts

This repository contains miscellaneous documentation, charts, tools and test
scripts for Hunspell and, its successor, Nuspell.


## 1 Written documentation

* [Annotated source code](code-comments/) in FODT files in the top-level
  directory. These cannot be viewed in GitHub or a browser and need LibreOffice
  for proper viewing.

## 2 Charts

Charts with documentation can be found in:

* [UML Diagrams](uml/README.md)
* [DFD](dfd/)


## 3 Tools

Tools for generating the docs:

1.  [Asciidoctor](http://asciidoctor.org/)
      - Install: `sudo apt install asciidoctor`
2.  Project management tool: [RationalPlan
    Single](https://www.rationalplan.com/on-premise/#single)
      - Install by double clicking the .deb with Ubuntu software center
      - <https://wiki.mozilla.org/MOSS#Applicant.2FAwardee_Resources>
      - start `rationalplan-single &` and open
        `misc-hunspell/hunspell2-ratpln.srp`
      - remove lock file and other user preferences `rm -rf
        ~/.RationalPlan/ ~/.java/.userPrefs/RationalPlan`
3.  [PlantUML](http://plantuml.com/).
      - Install with: `sudo apt install plantuml`
4.  [Dataflow](https://github.com/sonyxperiadev/dataflow) for DFD.
      - Install: `sudo apt install cabal-install && cabal update &&
        cabal install dataflow`
      - Use: `~/.cabal/bin/dataflow`


## 4 Testing

Testing has been moved to a separate repository. The remaining directories
`dictionaries` and `wordlists` will be migrated soon.


## 5 Talks

In the directories `fosdem19` and `fosdem20`, talks on Nuspell can be found.


## 6 Packaging

See the directories `packaging` and `snap` for packaging.
