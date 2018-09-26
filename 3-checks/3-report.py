#!/usr/bin/env python3

from csv import reader, writer
from glob import glob
from operator import itemgetter
from os import sep
from sys import maxsize, float_info 
from statistics import mean, stdev

# input files
#
# machine
# +- commit
#   +- language
#      +- result (can hold reruns for identical SHAs)
#
# output is per machine and (averaged) per commit

def main():
	# iterate machines
	for path in glob('regression/*'):
		machine = path.split(sep)[-1]
		shas = set()
		print('INFO: Processing machine {}'.format(machine))
		# iterate languages
		for file in glob('{}/??*/result'.format(path)):
			lang = file.split(sep)[-2]
			print('INFO: Processing language {}'.format(lang))
			data = reader(open(file), delimiter=' ')
			speedups_min = float_info.max 
			speedups_max = 0.0
			speedups = []
			#shas
			# iterate values
			for values in data:
				if values == []:
					continue
				sha = values[0]
				if sha[0] == '#':
					continue
				shas.add(sha)
				timestamp = values[1]
				run = values[2]
				words = values[3]
				true_pos = values[4]
				true_pos_rate = values[5]
				true_neg = values[6]
				true_neg_rate = values[7]
				false_pos = values[8]
				false_pos_rate = values[9]
				false_neg = values[10]
				false_neg_rate = values[11]
				accuracy = values[12]
				precision = values[13]
				duration = values[14]
				speedup = float(values[15])
				speedups.append(speedup)
				if speedup < speedup_min:
					speedup_min = speedup
				if speedup > speedup_max:
					speedup_max = speedup

#				print(sha, timestamp, run, true_pos, true_pos_rate, true_neg, true_neg_rate, false_pos, false_pos_rate, false_neg, false_neg_rate, words, accuracy, precision, duration, speedup)
				average = writer(open('test.tsv', 'w'), delimiter='\t')
				average.writerow([1, 2, 3])
				number += 1
			speedup_stdev = 0
			speedup_mean = speedups[0]
			if len(speedups) > 1:
				speedup_stdev = stdev(speedups)
				speedup_mean = mean(speedups)
			# values loop
		# lang loop
	# machine loop


if __name__ == "__main__":
    main()
