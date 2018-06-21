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

def process_file(input):
	histogram = {}
	i = 0
	opening = False
	for line in open(combined, lang):
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


		for word in words(paragraph):
			if len(word) == 1 and word_break(word) == 'ALetter':
				if word in histogram:
					histogram[word] += 1
				else:
					histogram[word] = 1
			elif len(word) > 1:
				for character in word:
					if word_break(character) == 'ALetter':
						if word in histogram:
							histogram[word] += 1
						else:
							histogram[word] = 1
						break

def main():
	for input in glob('combined-*.txt'):
	lang = input[9:-4]
	if lang == 'nl':
		pass
	else:
		process_file(input, lang)


	out = open('word-count-{}.txt'.format(lang), 'w')
	for word, count in sorted(histogram.items(), key=itemgetter(1), reverse=True):
		out.write('{}\t{}\n'.format(count, word))





# 
# #!/usr/bin/env python3
# 
# from glob import glob
# from operator import itemgetter
# from uniseg.wordbreak import words, word_break
# 
# # http://uniseg-python.readthedocs.io/en/latest/wordbreak.html
# # http://www.unicode.org/reports/tr29/tr29-21.html#Word_Boundaries
# # http://www.unicode.org/reports/tr29/tr29-15.html#Word_Boundaries
# 
# 
# for combined in glob('combined-*.txt'):
# 	lang = combined[9:-4]
# 	histogram = {}
# 	out = open('word-count-{}.txt'.format(lang), 'w')
# 	i = 0
# 
# 	for line in open(combined):
# 		i += 1
# 		if i % 1000 == 0:
# 			print('INFO: Processing {} paragraph {}...'.format(lang, i))
# 		paragraph = line[:-1]
# 		for word in words(paragraph):
# 			if len(word) == 1 and word_break(word) == 'ALetter':
# 				if word in histogram:
# 					histogram[word] += 1
# 				else:
# 					histogram[word] = 1
# 			elif len(word) > 1:
# 				for character in word:
# 					if word_break(character) == 'ALetter':
# 						if word in histogram:
# 							histogram[word] += 1
# 						else:
# 							histogram[word] = 1
# 						break
# 	
# 	for word, count in sorted(histogram.items(), key=itemgetter(1), reverse=True):
# 		out.write('{}\t{}\n'.format(count, word))
# 
# 
# ИИЯЯББ

if __name__ == "__main__":
    main()