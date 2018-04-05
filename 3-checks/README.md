Prepare word lists from Hunspell dictionary files and word list packages to do regression testing on

    ./1-prepare.sh

This will create a directories and files in the form of `words/LANGUAGE/gathered`

Run Hunspell on gathered word lists to get reference for word correctness and speed

    ./2-reference.sh

This will create a directories and files in the form of:
* `references/LANGUAGE/gathered` containing the result from Hunspell, i.e. `*` for correct or `&` for incorrect
* `references/LANGUAGE/gathered.good` containing all the correct word according to Hunspell
* `references/LANGUAGE/gathered.bad` containing all the incorrect word according to Hunspell
* `references/LANGUAGE/gathered.tsv` containing the original word list and the result from Hunspell on the same line, separated with a tab

Run current local (and uncommitted) development version of Nuspell (from `../nuspell`) on gathered word lists and compare with results from reference

    ./3-current.sh

Run regression test with Nuspell for latest commit or any specific commit on gathered word lists and compare with results from reference

    ./4-regression.sh
