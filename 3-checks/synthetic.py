#!/usr/bin/env python3

from glob import glob
from os import makedirs 
from random import choice, shuffle, randrange
from unicodedata import category

# Decode abbreviated Unicode category
def is_letter(value):
    c = category(value)
    if c in ('LC', 'Ll', 'Lo', 'Lu'): # excluding Lm: Letter. Modifier
        return True
    return False

def main():
    #TODO may rise up to 3
    #FIXME value of 1 gives error with double loop
    max_changes = 2
    max_cor = max_changes * 8
    for filename in sorted(glob('gathered/*/words')):
        words = {}
        alphabet = set()
        min = 1
        language = filename[9:-6]
        print(language)
        for line in open(filename):
            word = line.strip()
            if word == '':
                continue
            skip = False
            for char in word:
                if is_letter(char):
                    alphabet.add(char)
                else:
                    skip = True
                    break
            if skip:
                continue
            length = len(word)
            if length < min or ' ' in word:
                continue
            if length not in words:
                words[length] = set()
            words[length].add(word)
            if len(words[length]) == max_cor:
                min += 1
        corrections = []
        for length in sorted(words, reverse=True):
            values = list(words[length])
            shuffle(values)
            corrections.extend(values[:max_cor-len(corrections)])
            if len(corrections) == max_cor:
                makedirs('gathered/{}'.format(language), exist_ok=True)
#print(''.join(sorted(alphabet)))
                out = open('gathered/{}/synt.tsv'.format(language), 'w')
                shuffle(corrections)
                changes = 1 # iterates with suggestions in other tempo
                for suggestion in corrections:
                    if changes == max_changes:
                        changes = 1
                    error = suggestion
                    indices = list(range(len(suggestion)))
                    replacements = alphabet
                    for i in range(changes):
                        index = choice(indices)
                        if error[index] in replacements:
                            replacements.remove(error[index])
                        error = error[:index] + choice(list(replacements)) + error[index+1:] 
                        indices.remove(index)
                    out.write('{}\t{}\n'.format(error, suggestion))
                    changes += 1
                break
if __name__ == "__main__":
    main()
