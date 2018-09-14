#!/usr/bin/env python3

from random import randint

words = set()
out = open('random.txt', 'w')
while len(words) < 8000000:
    length = randint(4, 16)
    word = ''
    while len(word) < length:
        word += chr(ord('a') + randint(0, 25))
    if word not in words:
        out.write('{}\n'.format(word))
    words.add(word)
