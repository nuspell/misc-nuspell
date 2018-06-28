#!/usr/bin/env python3

from glob import glob
from operator import itemgetter
from uniseg.wordbreak import words, word_break

# http://uniseg-python.readthedocs.io/en/latest/wordbreak.html
# http://www.unicode.org/reports/tr29/tr29-21.html#Word_Boundaries
# http://www.unicode.org/reports/tr29/tr29-15.html#Word_Boundaries

# http://www.nltk.org/api/nltk.tokenize.html#nltk.tokenize.simple.line_tokenize
# http://www.nltk.org/api/nltk.tokenize.html#nltk.tokenize.sent_tokenize
# http://www.nltk.org/api/nltk.tokenize.html#nltk.tokenize.word_tokenize

def report(histogram, lang):
	out = open('word-count-{}.txt'.format(lang), 'w')
	for word, count in sorted(histogram.items(), key=itemgetter(1), reverse=True):
		out.write('{}\t{}\n'.format(count, word))

def process_uniseg(line, histogram):
	for word in words(line):
		for character in word:
			if word_break(character) == 'ALetter':
				# as soon as the word contains a letter
				if word in histogram:
					histogram[word] += 1
				else:
					histogram[word] = 1
				break

def process_nltk_uniseg(text, histogram):
	pass

# ИИЯЯББ

def main():
	for input in glob('combined-*.txt'):
		lang = input[9:-4]
		if lang == 'nl':
			continue # copy from development file, initialize nltk
		histogram = {}
		i = 0
		opening = False
		for line in open(input):
			i += 1
			if i % 1000 == 0:
				print('INFO: Processing {} paragraph {}...'.format(lang, i))
				
			if line.startswith('<doc'):
				opening = True
				# skip line with opening doc element
				continue
			elif opening == True:
				opening = False
				# skip line with title
				continue
			elif line.startswith('</doc'):
				# skip line with closing doc element
				continue

			if lang == 'nl':
				process_nltk_uniseg(line, histogram)
			else:
				process_uniseg(line, histogram)
		report(histogram, lang)

if __name__ == "__main__":
    main()