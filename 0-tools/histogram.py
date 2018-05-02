#!/usr/bin/env python3

#bug si_LK has invalid unicode character U+0DFE

from operator import itemgetter
from sys import argv
from unicodedata import category, name

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

print('| occurs | character |')
print('|---|---|')
if ' ' in chars:
	print('| yes | space character, ␣ |')
else:
	print('| no | space character, ␣ |')

if ' ' in chars:
	print('| yes | figure space character, ␣ |')
else:
	print('| no | figure space character, ␣ |')

if ' ' in chars:
	print('| yes | punctuation space character, ␣ |')
else:
	print('| no | punctuation space character, ␣ |')

if ' ' in chars:
	print('| yes | thin space character, ␣ |')
else:
	print('| no | thin space character, ␣ |')

if '‌' in chars:
	print('| yes | zero width non-joiner character |')
else:
	print('| no | zero width non-joiner character |')

if '‍' in chars:
	print('| yes | zero width joiner character |')
else:
	print('| no | zero width joiner character |')

if '‏' in chars:
	print('| yes | narrow no-break space character, ␣ |')
else:
	print('| no | narrow no-break space character, ␣ |')

if '\t' in chars:
	print('| yes | tab character, ↹ |')
else:
	print('| no | gab character, ↹ |')

if '\'' in chars:
	print('| yes | apostrophe character, \' |')
else:
	print('| no | apostrophe character, \' |')

if '’' in chars:
	print('| yes | single right quotation mark character, ’ |')
else:
	print('| no | single right quotation mark character, ’ |')

if '`' in chars:
	print('| yes | grave accent character, ` |')
else:
	print('| no | grave accent character, ` |')

if '-' in chars:
	print('| yes | hyphen character, - |')
else:
	print('| no | hyphen character, - |')

if '‑' in chars:
	print('| yes | non-breaking hyphen character, ‑ |')
else:
	print('| no | non-breaking hyphen character, ‑ |')

if '­' in chars:
	print('| yes | soft hyphen character |')
else:
	print('| no | soft hyphen character |')

if '_' in chars:
	print('| yes | underscore character, _ |')
else:
	print('| no | underscore character, _ |')

if '.' in chars:
	print('| yes | period character, . |')
else:
	print('| no | period character, . |')

if ',' in chars:
	print('| yes | comma character, , |')
else:
	print('| no | comma character, , |')

if ':' in chars:
	print('| yes | colon character, : |')
else:
	print('| no | colon character, : |')

if ';' in chars:
	print('| yes | semicolon character, ; |')
else:
	print('| no | semicolon character, ; |')

if 'ß' in chars:
	print('| yes | sharp s character, ß |')
else:
	print('| no | sharp s character, ß |')

if 'ẞ' in chars:
	print('| yes | sharp S character, upper case, ẞ |')
else:
	print('| no | sharp S character, upper case, ẞ |')

if 'ĳ' in chars:
	print('| yes | ij character, ĳ |')
else:
	print('| no | ij character, ĳ |')

if 'Ĳ' in chars:
	print('| yes | IJ character, upper case, Ĳ |')
else:
	print('| no | IJ character, upper case, Ĳ |')

if 'İ' in chars:
	print('| yes | dotted I character, upper case, İ |')
else:
	print('| no | dotted I character, upper case, İ |')

if '₁' in chars:
	print('| yes | subscript 1, ₁ |')
else:
	print('| no | subscript 1, ₁ |')

if '₂' in chars:
	print('| yes | subscript 2, ₂ |')
else:
	print('| no | subscript 2, ₂ |')

if '₃' in chars:
	print('| yes | subscript 3, ₃ |')
else:
	print('| no | subscript 3, ₃ |')

if '·' in chars:
	print('| yes | centered dot, · |')
else:
	print('| no | centered dot, · |')

if '¹' in chars:
	print('| yes | superscript 1, ¹ |')
else:
	print('| no | superscript 1, ¹ |')

if '²' in chars:
	print('| yes | superscript 2, ² |')
else:
	print('| no | superscript 2, ² |')

if '³' in chars:
	print('| yes | superscript 3, ³ |')
else:
	print('| no | superscript 3, ³ |')

if '+' in chars:
	print('| yes | plus character, + |')
else:
	print('| no | plus character, + |')

if '/' in chars:
	print('| yes | slash character, / |')
else:
	print('| no | slash character, / |')

if '\\' in chars:
	print('| yes | backslash character, \\ |')
else:
	print('| no | backslash character, \\ |')

print()
print('| count | char | code | category | name |')
print('|--:|---|---|---|---|')
for char, count in sorted(chars.items(), key=itemgetter(1)):
	try:
		print('| {} | `{}` | `{}` | {} | {} |'.format(count, char, hex(ord(char)), category(char), name(char).lower()))
	except ValueError:
		print('| {} | `{}` | `{}` | VALUE ERROR | {} |'.format(count, char, hex(ord(char)), category(char)))

