#!/usr/bin/env python3

from enum import Enum
from _ast import Num

def has_non_zero(lens):
    for i in range(len(lens)):
        if lens[i] != 0:
            return True
    return False

def is_int_and_convert(s):
    try: 
        n = int(s)
        return (True, n)
    except ValueError:
        return (False, None)

class Affix():
    flag = 'SHORT'

    breac = None
    breacs = []
    
    compoundrules = [] # order is important
    compoundrules_flags = set()
    compoundrules_parts = {}
    
    compoundmin = 3
    compoundflag = None
    compoundbegin = None
    compoundend = None
    compoundmiddle = None
    compoundflag_parts = []
    compoundbegin_parts = []
    compoundend_parts = []
    compoundmiddle_parts = []
    
    checkcompoundpatterns = [] # order is important
    checkcompoundpatterns_flags = set()
    checkcompoundpatterns_parts = {}

aff = Affix()

compoundrule_num = 0
checkcompoundpattern_num = 0
for line in open('nl.aff'):
    line = line.split('#')[0].strip() #perhaps too strong
    if line == '':
        continue
    if line.startswith('FLAG'):
        value = line.split('FLAG')[1].strip()
        if value.upper() == 'LONG':
            aff.flag = 'LONG'
        elif value.upper() == 'NUM': 
            aff.flag = 'NUM'
        elif value.upper() == 'UTF-8': 
            aff.flag = 'UTF-8'
        elif value.upper() != 'SHORT':
            print('ERROR: {} {}'.format(value, line))
            exit(1)
    elif line.startswith('COMPOUNDRULE'):
        value = line.split('COMPOUNDRULE')[1].strip()
        type, number = is_int_and_convert(value)
        if type:
            compoundrule_num = number
        else:
            values = value[1:-1].split(')(')
            aff.compoundrules.append(values)
            for value in values:
                aff.compoundrules_flags.add(value)
            compoundrule_num -= 1
    elif line.startswith('COMPOUNDFLAG'):
        aff.compoundflag = line.split('COMPOUNDFLAG')[1].strip()
    elif line.startswith('COMPOUNDBEGIN'):
        aff.compoundbegin = line.split('COMPOUNDBEGIN')[1].strip()
    elif line.startswith('COMPOUNDMIDDLE'):
        aff.compoundmiddle = line.split('COMPOUNDMIDDLE')[1].strip()
    elif line.startswith('COMPOUNDEND'):
        aff.compoundend = line.split('COMPOUNDEND')[1].strip()
    elif line.startswith('CHECKCOMPOUNDPATTERN'):
        value = line.split('CHECKCOMPOUNDPATTERN')[1].strip()
        type, number = is_int_and_convert(value)
        if type:
            checkcompoundpattern_num = number
        else:
            values = value.split(' ')
            aff.checkcompoundpatterns.append(values)
            for value in values:
                if value[0] == '/':
                    aff.checkcompoundpatterns_flags.add(value[1:])
            checkcompoundpattern_num -= 1

aff.compoundflag_parts = sorted(aff.compoundflag_parts)
aff.compoundbegin_parts = sorted(aff.compoundbegin_parts)
aff.compoundmiddle_parts = sorted(aff.compoundmiddle_parts)
aff.compoundend_parts = sorted(aff.compoundend_parts)
    
for line in open('nl.dic'):
    line = line.split('#')[0].strip() #perhaps too strong
    word = None
    flags = None
    if '/' in line:
        word, flags = line.split('/')
        for i in range(0, len(flags), 2):
            flag = flags[i:i+2]
            if flag in aff.compoundrules_flags:
                if flag not in aff.compoundrules_parts:
                    aff.compoundrules_parts[flag] = [] 
                aff.compoundrules_parts[flag].append(word) 
            if flag in aff.checkcompoundpatterns_flags:
                if flag not in aff.checkcompoundpatterns_parts:
                    aff.checkcompoundpatterns_parts[flag] = [] 
                aff.checkcompoundpatterns_parts[flag].append(word) 
            if flag == aff.compoundflag:
                aff.compoundflag_parts.append(word) 
            if flag == aff.compoundbegin:
                aff.compoundbegin_parts.append(word) 
            if flag == aff.compoundmiddle:
                aff.compoundmiddle_parts.append(word) 
            if flag == aff.compoundend:
                aff.compoundend_parts.append(word) 
    else:
        word = line

print('FLAG', aff.flag)

print('BREAK {} ({})'.format(aff.breac, len(aff.breacs)))
print('COMPOUNDFLAG {} ({})'.format(aff.compoundflag, len(aff.compoundflag_parts)))
print('COMPOUNDBEGIN {} ({})'.format(aff.compoundbegin, len(aff.compoundbegin_parts)))
print('COMPOUNDMIDDLE {} ({})'.format(aff.compoundmiddle, len(aff.compoundmiddle_parts)))
print('COMPOUNDEND {} ({})'.format(aff.compoundend, len(aff.compoundend_parts)))
print(aff.checkcompoundpatterns_flags)

out = open('generated.md', 'w')

out.write('## 1 Compound rules\n')
out.write('\n')
out.write('\n')
number = 0
for rule in aff.compoundrules:
    word = []
    number += 1
    out.write('## 1.{} Compound rule ({})\n'.format(number, ')('.join(rule)))
    out.write('\n')
    lens = []
    first = True
    for flag in rule:
        if first:
            first = False
        else:
            out.write('|')
        length = len(aff.compoundrules_parts[flag])
        lens.append(len(aff.compoundrules_parts[flag]))
        out.write(' {} ({}) '.format(flag, length))
    out.write('\n')
    first = True
    for flag in rule:
        if first:
            out.write('---')
            first = False
        else:
            out.write('|---')
#TODO        word.append(aff.compoundrules_parts[flag])
    out.write('\n')
    while has_non_zero(lens):
        for i in range(len(rule)):
            flag = rule[i]
            if i != 0:
                out.write('|')
            if lens[i] > 0:
                out.write(' `{}` '.format(aff.compoundrules_parts[flag][lens[i]-1]))
                lens[i] -= 1
            else:
                out.write(' ↑ ')
        out.write('\n')
    out.write('\n')
    out.write('\n')

out.write('## 2 Compound flags\n')
out.write('\n')
lens = []
lens.append(len(aff.compoundbegin_parts))
lens.append(len(aff.compoundmiddle_parts))
lens.append(len(aff.compoundend_parts))
out.write(' begin | middle | end\n')
out.write('---|---|---\n')
number = 0
while has_non_zero(lens):
    number += 1
    bail = False
    if lens[0] > 0:
        out.write(' `{}` '.format(aff.compoundbegin_parts[lens[0]-1]))
        lens[0] -= 1
    else:
        out.write(' ↑ ')
    out.write('|')
    if lens[1] > 0:
        out.write(' `{}` '.format(aff.compoundmiddle_parts[lens[1]-1]))
        lens[1] -= 1
    else:
        out.write(' ↑ ')
    out.write('|')
    if lens[2] > 0:
        out.write(' `{}` '.format(aff.compoundend_parts[lens[2]-1]))
        lens[2] -= 1
    else:
        out.write(' ↑ ')
    out.write('\n')
out.write('\n')
out.write('\n')

out.write('## 3 Check compound patterns\n')
out.write('\n')
out.write('\n')
number = 0  
for pattern in aff.checkcompoundpatterns:
    number += 1
    out.write('## 3.{} Check compound pattern `{}`\n'.format(number, ' '.join(pattern)))
