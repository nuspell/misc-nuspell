Resources:
* https://wiki.mozilla.org/MOSS#Applicant.2FAwardee_Resources
* https://www.rationalplan.com/on-premise/#single
* start `rationalplan-single &` and open misc-hunspell/hunspell2-ratpln.srp
* remove lock file and other user preferences `rm -rf ~/.RationalPlan/ ~/.java/.userPrefs/RationalPlan`

After cloning or pulling run this only once to add the zippy filter:

	git config filter.zippey.smudge "$PWD/zippey.py d"
	git config filter.zippey.clean "$PWD/zippey.py e"
	git ls-files -z | xargs -0 rm
	git checkout -- .

