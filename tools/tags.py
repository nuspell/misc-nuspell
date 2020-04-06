#!/usr/bin/env python3

from datetime import datetime
from operator import itemgetter
from sys import argv
from unicodedata import category, name

__author__ = 'Pander'
__email__ = 'pander@users.sourceforge.net'


# Provide formatted date and time
def stamp_time():
    return datetime.now().strftime('%Y-%m-%d at %H:%M:%S')


if len(argv) != 2:
    print('ERROR: Missing filename')
    exit(1)

words = set()
double = True
for line in open(argv[1]):
    line = line[:-1]
    if len(line) == 0 or line[0] == '#' or line[0] == ' ' or '/' not in line:
        continue

    index = None
    prev = None
    for i in range(len(line)):
        char = line[i]
        if char == '/' and prev != None and prev != '\\':
            index = i
            continue
        prev = char
    if index == None:
        continue
    word = line[:index]
    tags = line[index+1:].split(' ')[0].split('\t')[0]
    words.add((word, tags))
    if double and len(tags) % 2 != 0:
        double = False

tag_words = {}
tag_count = {}
for pair in words:
    word, tags = pair
    found = set()
    duplicate = False
    for i in range(len(tags)):
        tag = None
        if double:
            if i % 2 != 0:
                continue
            else:
                tag = tags[i:i+2]
        else:
            tag = tags[i]
        if tag in found and not duplicate:
            print('WARNING: Duplicate tag {} found in tags {} for word {}'.format(tag, tags, word))
            duplicate = True
            continue
        else:
            found.add(tag)
        if tag in tag_words:
            tag_words[tag].append(word)
            tag_count[tag] += 1
        else:
            tag_words[tag] = [word]
            tag_count[tag] = 1

out = open('{}-tags.tsv'.format(argv[1]), 'w')
print('Number of different tags found: {}'.format(len(tag_count)))
out.write('#count\ttag\tdescription\texamples\n')
for tag, count in sorted(tag_count.items(), key=itemgetter(1), reverse=True):
    words = sorted(tag_words[tag])
    if len(words) > 16:
        words = ', '.join(words[:4]) + ', …, '+ ', '.join(words[len(words)//2-2:len(words)//2+2]) + ', …, '+ ', '.join(words[-4:])
    elif len(words) > 8:
        words = ', '.join(words[:4]) + ', …, '+ ', '.join(words[-4:])
    else:
        words = ', '.join(words)
    out.write('{}\t{}\t\t{}\n'.format(count, tag, words))

exit(0)

path = argv[1].split('/')
print('# Histogram {}'.format(path[len(path) - 1]))
print('')
print('| special characters ocurring |   |')
print('|---|---|')

# order below is partly optimized by overall frequency in dic files




print()
print('| count | char | code | category | name |')
print('|--:|---|--:|---|---|')
for char, count in sorted(chars.items(), key=itemgetter(1)):
    try:
        if char == '|':
            print('| {} | <code>&#124;</code> | `{}` | {} | {} |'.format(count, hex(ord(char)), decode_category(char), name(char).lower()))
        else:
            print('| {} | `{}` | `{}` | {} | {} |'.format(count, char, hex(ord(char)), decode_category(char), name(char).lower()))
    except ValueError:
        if char == '\t':
            print('| {} | `{}` | `{}` | {} | character tabulation |'.format(count, char, hex(ord(char)), decode_category(char)))
        else:
            print('| {} | `{}` | `{}` | {} | VALUE ERROR |'.format(count, char, hex(ord(char)), decode_category(char)))

