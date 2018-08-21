#!/usr/bin/env python3

from glob import glob
from operator import itemgetter
from uniseg.wordbreak import words, word_break
from nltk.tokenize import sent_tokenize, word_tokenize 

# http://uniseg-python.readthedocs.io/en/latest/wordbreak.html
# http://www.unicode.org/reports/tr29/tr29-21.html#Word_Boundaries
# http://www.unicode.org/reports/tr29/tr29-15.html#Word_Boundaries

# http://www.nltk.org/api/nltk.tokenize.html#nltk.tokenize.sent_tokenize
# http://www.nltk.org/api/nltk.tokenize.html#nltk.tokenize.word_tokenize

def report(histogram, lang):
	out = open('word-count-{}.tsv'.format(lang), 'w')
	for word, count in sorted(histogram.items(), key=itemgetter(1), reverse=True):
		out.write('{}\t{}\n'.format(count, word))

def count(word, histogram):
	for character in word:
		if word_break(character) == 'ALetter':
			# as soon as the word contains a letter
			if word in histogram:
				histogram[word] += 1
			else:
				histogram[word] = 1
			if len(histogram) >= 1048576:
				# histrogram limit is reached
				# (compared to ==, using >= is extra safe)
				return True
			break
	return False

def process_uniseg(line, histogram):
	for word in words(line):
		if count(word, histogram):
			# histrogram limit is reached
			return True
	return False

def process_nltk_uniseg(text, histogram):
	# https://github.com/nltk/nltk/issues/1968
	text = text.replace("'s", "ИЯЯБ").replace("'d", "БЯЯИ")
	for sentence in sent_tokenize(text, 'dutch'):
		for word in word_tokenize(text, 'dutch'):
			word = word.replace("ИЯЯБ", "'s").replace("БЯЯИ", "'d")
			if count(word, histogram):
				# histrogram limit is reached
				return True
	return False

def main():
	for input in glob('combined-*.txt'):
		lang = input[9:-4]
		print('INFO: Processing {}'.format(lang))
 		histogram = {}
		i = 0
		opening = False
		text = None
		for line in open(input):
			i += 1
			if i % 1000 == 0:
				print('INFO: Processing {} paragraph {}, found {} unique words...'.format(lang, i, len(histogram)))
				
			if line.startswith('<doc'):
				opening = True
				# start accumulating text
				text = ''
				# skip line with opening doc element
				continue
			elif opening == True:
				opening = False
				# skip line with title
				continue
			elif line.startswith('</doc'):
				# processed accumulated text
				if lang == 'nl':
					if process_nltk_uniseg(text, histogram):
						# histrogram limit is reached
						break
				# skip line with closing doc element
				continue
			if lang == 'nl':
				# accumulate text
				text += line
			else:
				if process_uniseg(line, histogram):
					# histrogram limit is reached
					break
		report(histogram, lang)

if __name__ == "__main__":
    main()
