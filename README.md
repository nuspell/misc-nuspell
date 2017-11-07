Resources:

1.  Project management tool: [RationalPlan
    Single](https://www.rationalplan.com/on-premise/#single)
    - Install by double clicking the .deb with Ubuntu software center
    - https://wiki.mozilla.org/MOSS#Applicant.2FAwardee_Resources
    - start `rationalplan-single &` and open
      `misc-hunspell/hunspell2-ratpln.srp`
    - remove lock file and other user preferences `rm -rf
      ~/.RationalPlan/ ~/.java/.userPrefs/RationalPlan`
2.  [PlantUML](http://plantuml.com/).
    - Install with: `sudo apt install plantuml`
3.  [Dataflow](https://github.com/sonyxperiadev/dataflow) for DFD.
    - Install: `sudo apt install cabal-install && cabal update &&
      cabal install dataflow`
    - Use: `~/.cabal/bin/dataflow`
4.  [Fabuala](http://drakon.su/programma_fabula_._redaktor_drakon-sxem)
    - Extranct manually then `wine fabula_0.1b_r001.exe`

After cloning or pulling run this only once to add the zippy filter:

    git config filter.zippey.smudge "$PWD/zippey.py d"
    git config filter.zippey.clean "$PWD/zippey.py e"
    rm $(git ls-files drakon)
    git checkout -- .

