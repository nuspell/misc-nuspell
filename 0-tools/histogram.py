#!/usr/bin/env python3

#bug si_LK has invalid unicode character U+0DFE

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

if ' ' in chars:
	print('yes\tfigure space character, ␣')
else:
	print('no\tfigure space character, ␣')

if ' ' in chars:
	print('yes\tpunctuation space character, ␣')
else:
	print('no\tpunctuation space character, ␣')

if ' ' in chars:
	print('yes\tthin space character, ␣')
else:
	print('no\tthin space character, ␣')

if '‌' in chars:
	print('yes\tzero width non-joiner character')
else:
	print('no\tzero width non-joiner character')

if '‍' in chars:
	print('yes\tzero width joiner character')
else:
	print('no\tzero width joiner character')

if '‏' in chars:
	print('yes\tnarrow no-break space character, ␣')
else:
	print('no\tnarrow no-break space character, ␣')

if '\t' in chars:
	print('yes\ttab character, ↹')
else:
	print('no\tgab character, ↹')

if '\'' in chars:
	print('yes\tapostrophe character, \'')
else:
	print('no\tapostrophe character, \'')

if '’' in chars:
	print('yes\tsingle right quotation mark character, ’')
else:
	print('no\tsingle right quotation mark character, ’')

if '`' in chars:
	print('yes\tgrave accent character, `')
else:
	print('no\tgrave accent character, `')

if '-' in chars:
	print('yes\thyphen character, -')
else:
	print('no\thyphen character, -')

if '‑' in chars:
	print('yes\tnon-breaking hyphen character, ‑')
else:
	print('no\tnon-breaking hyphen character, ‑')

if '­' in chars:
	print('yes\tsoft hyphen character')
else:
	print('no\tsoft hyphen character')

if '_' in chars:
	print('yes\tunderscore character, _')
else:
	print('no\tunderscore character, _')

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

if ';' in chars:
	print('yes\tsemicolon character, ;')
else:
	print('no\tsemicolon character, ;')

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

if '₁' in chars:
	print('yes\tsubscript 1, ₁')
else:
	print('no\tsubscript 1, ₁')

if '₂' in chars:
	print('yes\tsubscript 2, ₂')
else:
	print('no\tsubscript 2, ₂')

if '₃' in chars:
	print('yes\tsubscript 3, ₃')
else:
	print('no\tsubscript 3, ₃')

if '·' in chars:
	print('yes\tcentered dot, ·')
else:
	print('no\tcentered dot, ·')

if '¹' in chars:
	print('yes\tsuperscript 1, ¹')
else:
	print('no\tsuperscript 1, ¹')

if '²' in chars:
	print('yes\tsuperscript 2, ²')
else:
	print('no\tsuperscript 2, ²')

if '³' in chars:
	print('yes\tsuperscript 3, ³')
else:
	print('no\tsuperscript 3, ³')

if '+' in chars:
	print('yes\tplus character, +')
else:
	print('no\tplus character, +')

if '/' in chars:
	print('yes\tslash character, /')
else:
	print('no\tslash character, /')

if '\\' in chars:
	print('yes\tbackslash character, \\')
else:
	print('no\tbackslash character, \\')

for char, count in sorted(chars.items(), key=itemgetter(1), reverse=True):
	code = hex(ord(char))
	if char == ' ':
		char = '␣ space character'
	elif char == ' ':
		char = '␣ figure space character'
	elif char == ' ':
		char = '␣ punctuation character'
	elif char == ' ':
		char = '␣ thin space character'
	elif char == '‌':
		char = 'zero width non-joiner character'
	elif char == '‍':
		char = 'zero width joiner character'
	elif char == '‏':
		char = '␣ narrow no-break space character'
	elif char == '\t':
		char = '↹ tab character'
	elif char == '\'':
		char += ' apostrophe character'
	elif char == '’':
		char += ' single right quotation mark character'
	elif char == '`':
		char += ' grave accent character'
	elif char == '-':
		char += ' hyphen character'
	elif char == '‑':
		char += ' non-breaking hyphen character'
	elif char == '­':
		char += ' soft hyphen character'
	elif char == '_':
		char += ' underscore character'
	elif char == '.':
		char += ' period character'
	elif char == ',':
		char += ' comma character'
	elif char == ':':
		char += ' colon character'
	elif char == ';':
		char += ' semicolon character'
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
	elif char == '₁':
		char += ' subscript 1 character'
	elif char == '₂':
		char += ' subscript 2 character'
	elif char == '₃':
		char += ' subscript 3 character'
	elif char == '·':
		char += ' centered dot character'
	elif char == '¹':
		char += ' superscript 1 character'
	elif char == '²':
		char += ' superscript 2 character'
	elif char == '³':
		char += ' superscript 3 character'
	elif char == '+':
		char += ' plus character'
	elif char == '/':
		char += ' slash character'
	elif char == '\\':
		char += ' backslash character'
	print('{}\t{}\t{}'.format(count, code, char))

