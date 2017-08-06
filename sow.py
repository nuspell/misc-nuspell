#!/usr/bin/env python3
import xml.etree.ElementTree as ET
from html import unescape
import re

def process_node(n):
    # print(n.find('task-name').text)
    note = n.find('task-notes')
    if (note != None):
        t = unescape(note.text)[4:-4]
        t = re.sub(r'\s+', ' ', t).strip()
        print(t)

tree = ET.parse('hunspell2-ratpln.srp')
e = tree.find('task')

process_node(e)
print()

i = 1

for e1 in e.findall('./task-list/task'):

    name = e1.find('task-name').text.strip()
    if str.isalpha(name[0]):
        continue

    print('1.  {}\n\n    '.format(name[2:]), end='')
    process_node(e1)
    i += 1

    for e2 in e1.findall('./task-list/task'):
        print('\t1. ', end='')
        process_node(e2)
