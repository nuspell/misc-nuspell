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

    if str.isalpha(e1.find('task-name').text[0]):
        continue

    print('- Milestone {}: '.format(i), end='')
    process_node(e1)
    i += 1

    for e2 in e1.findall('./task-list/task'):
        print('\t- ', end='')
        process_node(e2)
