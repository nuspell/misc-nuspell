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

# Decode abbreviated Unicode category
def decode_category(value):
    c = category(value)
    if c[0] == 'C':
        return 'control'
    elif c[0] == 'L':
        return 'letter'
    elif c[0] == 'M':
        return 'mark'
    elif c[0] == 'N':
        return 'number'
    elif c[0] == 'P':
        return 'punctuation'
    elif c[0] == 'S':
        return 'symbol'
    elif c[0] == 'Z':
        return 'whitespace'
    else:
        print('ERROR: Illegal or unsupported abbreviated Unicode category {}'.format(c))
        exit(1)

#bug si_LK has invalid unicode character U+0DFE


if len(argv) != 2:
	print('ERROR: Missing filename')
	exit(1)

chars = {}
starts_hyphen = False
for line in open(argv[1]):
	line = line[:-1]
	if len(line) > 0 and line[0] == '-':
		starts_hyphen = True
	for char in line:
		if char in chars:
			chars[char] += 1
		else:
			chars[char] = 1

path = argv[1].split('/')
print('# Histogram {}'.format(path[len(path) - 1]))
print('')
print('| special characters ocurring |   |')
print('|---|---|')

# order below is partly optimized by overall frequency in dic files


if '/' in chars:
	print('| slash character | / |')
if '\\' in chars:
	print('| backslash character | \\ |')


if '-' in chars:
	if starts_hyphen:
		print('| hyphen character and some lines start with this | - |')
	else:
		print('| hyphen character | - |')
if '‑' in chars:
	print('| non-breaking hyphen character | ‑ |')
if '­' in chars:
	print('| soft hyphen character |   |')
if '_' in chars:
	print('| underscore character | _ |')
if '–' in chars:
	print('| en-dash character | – |')
if '—' in chars:
	print('| em-dash character | — |')


if '\'' in chars:
	print('| apostrophe character | \' |')
if '`' in chars:
	print('| grave accent character | ` |')
if '’' in chars:
	print('| single right quotation mark character | ’ |')


if '\t' in chars:
	print('| tab character | ↹ |')
if ' ' in chars:
	print('| space character | ␣ |')
if ' ' in chars:
	print('| figure space character | ␣ |')
if ' ' in chars:
	print('| punctuation space character | ␣ |')
if ' ' in chars:
	print('| thin space character | ␣ |')
if '‌' in chars:
	print('| zero width non-joiner character |   |')
if '‍' in chars:
	print('| zero width joiner character |   |')
if '‏' in chars:
	print('| narrow no-break space character | ␣ |')


if '.' in chars:
	print('| period character | . |')
if ',' in chars:
	print('| comma character | , |')
if ':' in chars:
	print('| colon character | : |')
if ';' in chars:
	print('| semicolon character | ; |')


if '+' in chars:
	print('| plus character | + |')
if '&' in chars:
	print('| ampersand character | & |')
if '=' in chars:
	print('| equals character | = |')
if '(' in chars:
	print('| bracket opening character | ( |')
if ')' in chars:
	print('| bracket closing character | ) |')


if '¹' in chars:
	print('| superscript 1 | ¹ |')
if '²' in chars:
	print('| superscript 2 | ² |')
if '³' in chars:
	print('| superscript 3 | ³ |')
if '₁' in chars:
	print('| subscript 1 | ₁ |')
if '₂' in chars:
	print('| subscript 2 | ₂ |')
if '₃' in chars:
	print('| subscript 3 | ₃ |')
if '·' in chars:
	print('| centered dot | · |')


if 'ß' in chars:
	print('| sharp s character | ß |')
if 'ẞ' in chars:
	print('| sharp S character, upper case | ẞ |')
if 'ĳ' in chars:
	print('| ij character | ĳ |')
if 'Ĳ' in chars:
	print('| IJ character, upper case | Ĳ |')
if 'İ' in chars:
	print('| dotted I character, upper case | İ |')


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

