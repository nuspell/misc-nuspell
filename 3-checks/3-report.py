#!/usr/bin/env python3

from csv import reader, writer
from glob import glob
from operator import itemgetter


def main():
	for machine in glob('regression/*'):
		print(machine)
		for result in glob('{}/??*/result'.format(machine)):
			print('INFO: Processing {}'.format(result))
			data = reader(open(result), delimiter=' ')
			for values in data:
				if values == []:
					continue
				sha = values[0]
				if sha[0] == '#':
					continue
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
				speedup = values[15]
				print(sha, timestamp, run, true_pos, true_pos_rate, true_neg, true_neg_rate, false_pos, false_pos_rate, false_neg, false_neg_rate, words, accuracy, precision, duration, speedup)
				average = writer(open('test.tsv', 'w'), delimiter='\t')
				average.writerow([1, 2, 3])


if __name__ == "__main__":
    main()
