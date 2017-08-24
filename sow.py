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
total_duration = int(e.find('task-duration').text)
total_cost = float(e.find('project-budget').text)

for e1 in e.findall('./task-list/task'):

    name = e1.find('task-name').text.strip()
    if str.isalpha(name[0]):
        continue

    duration = int(e1.find('task-duration').text)
    days = int(round(duration / 3600000 / 8))
    percent = duration / total_duration
    cost = int(round(percent * total_cost))

    print('{}.  {} (${}, {} days)\n\n    '.
            format(i, name[2:], cost, days), end='')
    process_node(e1)
    print()
    i += 1

    j = 1
    for e2 in e1.findall('./task-list/task'):
        print('\t{}. '.format(j), end='')
        process_node(e2)
        j += 1

    print()
