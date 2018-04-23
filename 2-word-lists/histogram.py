#!/usr/bin/env python3

from sys import argv
from operator import itemgetter

if len(argv) != 2:
	print('ERROR: Missing filename')
	exit(1)

chars = {}
for line in open(argv[1], 'r'):
	line = line[:-1]
	for char in line:
		if char in chars:
			chars[char] += 1
		else:
			chars[char] = 1

if ' ' in chars:
	print('yes\tspace character, ␣')
else:
	print('no\tspace character, ␣')

if '\'' in chars:
	print('yes\tapostrophe character, \'')
else:
	print('no\tapostrophe character, \'')

if '-' in chars:
	print('yes\thyphen character, -')
else:
	print('no\thyphen character, -')

if '.' in chars:
	print('yes\tperiod character, .')
else:
	print('no\tperiod character, .')

if ',' in chars:
	print('yes\tcomma character, ,')
else:
	print('no\tcomma character, ,')

if ':' in chars:
	print('yes\tcolon character, :')
else:
	print('no\tcolon character, :')

if 'ß' in chars:
	print('yes\tsharp s character, ß')
else:
	print('no\tsharp s character, ß')

if 'ẞ' in chars:
	print('yes\tsharp S character, upper case, ẞ')
else:
	print('no\tsharp S character, upper case, ẞ')

if 'ĳ' in chars:
	print('yes\tij character, ĳ')
else:
	print('no\tij character, ĳ')

if 'Ĳ' in chars:
	print('yes\tIJ character, upper case, Ĳ')
else:
	print('no\tIJ character, upper case, Ĳ')

if 'İ' in chars:
	print('yes\tdotted I character, upper case, İ')
else:
	print('no\tdotted I character, upper case, İ')

if '₂' in chars:
	print('yes\tsubscript 2, ₂')
else:
	print('no\tsubscript 2, ₂')

if '+' in chars:
	print('yes\tplus character, +')
else:
	print('no\tplus character, +')

if '/' in chars:
	print('yes\tslash character, /')
else:
	print('no\tslash character, /')

for char, count in sorted(chars.items(), key=itemgetter(1), reverse=True):
	code = hex(ord(char))
	if char == ' ':
		char = '␣ space character'
	elif char == '\'':
		char += ' apostrophe character'
	elif char == '-':
		char += ' hyphen character'
	elif char == '.':
		char += ' period character'
	elif char == ',':
		char += ' comma character'
	elif char == ':':
		char += ' colon character'
	elif char == 'ß':
		char += ' sharp s character'
	elif char == 'ẞ':
		char += ' sharp S character, upper case'
	elif char == 'ĳ':
		char += ' ij character'
	elif char == 'Ĳ':
		char += ' IJ character, upper case'
	elif char == 'İ':
		char += ' dotted I character, upper case'
	elif char == '₂':
		char += ' subscript 2 character'
	elif char == '+':
		char += ' plus character'
	elif char == '/':
		char += ' slash character'
	print('{}\t{}\t{}'.format(count, code, char))

