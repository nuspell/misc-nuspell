#!/usr/bin/env python3

from time import sleep, time
from operator import itemgetter
from random import randint, random
from sys import maxsize
from pprint import pprint

# data structure
cache_key = {}
cache_time = {}
cache_value = {}
cache_hits = 0
cache_dels = 0
histogram = {}

# data
operations = 1000
cache_size = 12
high_freq = ('a', 'an', 'thé')
med_freq = ('mE', 'you', 'he', 'she', 'we', 'they')
low_freq = ('wheel', 'trunk', 'carpet', 'handle', 'white', 'black', 'red',
		'green', 'yellow', 'orange', 'purple', 'blue', 'cyan', 'book', 'chair',
		'table', 'door', 'window', 'lamp', 'street', 'car', 'person', 'fish',
		'dog', 'cat', 'bird', 'city', 'country', 'bed', 'rtee', 'lfower', 'brigde')
# Note the third word of high_freq, the first word of med_freq and the last
# three words in low_freq have spelling errors.

# fill structure with data
for i in range(operations+1):
	
	# report an very time
	if i != 0:
		if i % 100 == 0:
			print('Processed', i, 'words...')
		sleep(random()/100)
		
	# chose random word, but weighted
	r = randint(0, 9)
	if r < 6:
		word = high_freq[randint(0, len(high_freq)-1)]
	elif r > 5 and r < 9:
		word = med_freq[randint(0, len(med_freq)-1)]
	else:
		word = low_freq[randint(0, len(low_freq)-1)]
		
	# track overal word usage
	if word in histogram:
		histogram[word] += 1
		cache_hits += 1
	else:
		histogram[word] = 1
		
	# store word with count, time and spelling in cache
	if word in cache_key:
		cache_key[word] += 1
	else:
		cache_key[word] = 1
		if word == high_freq[2] or word == med_freq[0] or word in low_freq[-3:]:
			cache_value[word] = False
		else:
			cache_value[word] = True
	cache_time[word] = time()
	
	# remove least frequently used (LFU) word from cache
	if len(cache_key) > cache_size:
		# find words with lowest count
		lowest_count = set()
		prev_count = maxsize
		for word, count in sorted(cache_key.items(), key=itemgetter(1)):
			if count > prev_count:
				break
			lowest_count.add(word)
			prev_count = count
		# find word that was added longest ago and delete it from cache
		for word, t in sorted(cache_time.items(), key=itemgetter(1)):
			if word in lowest_count:
				del cache_key[word]
				del cache_time[word]
				del cache_value[word]
				cache_dels += 1
				break

# report histogram of data
print('Histogram ({}):'.format(len(histogram)))
for word, count in sorted(histogram.items(), key=itemgetter(1)):
	print('{:>3}\t{}'.format(count, word))
print('Cache ({}):'.format(cache_size))
for word, count in sorted(cache_key.items(), key=itemgetter(1)):
	print('{:>3}/{:>3}\t{}\t{}\t{}'.format(count, histogram[word], cache_time[word], word, cache_value[word]))
print('Operations:\t{}'.format(operations))
print('Cache Hits:\t{}'.format(cache_hits))
print('Cache Dels:\t{}'.format(cache_dels))
