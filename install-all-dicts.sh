# In ^wordlist$ the arrow and the dollar sign are needed,
# otherwise it will match more packages than needed.
wordlists=$(apt-cache search --names-only ^wordlist$ | awk '{print $1}')
exclude="\
myspell-es
myspell-fr
hunspell-fr-comprehensive
hunspell-fr-revised
hunspell-fr-modern
hunspell-de-de-frami
hunspell-de-at-frami
hunspell-de-ch-frami"
dicts=$(apt-cache search --names-only ^hunspell-dictionary$ | awk '{print $1}' |
        grep --fixed-strings --invert-match --line-regexp "$exclude")
apt-get install $wordlists $dicts
