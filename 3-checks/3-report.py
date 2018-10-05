#!/usr/bin/env python3

from csv import reader, writer
from glob import glob
from sys import maxsize, float_info 
from statistics import mean, stdev


def main():
	# iterate os with hostname
	for filename in glob('*_*.ssv'):
		basename = filename[:-4]
		os, hostname = basename.split('_')
		print('INFO: Processing hostname {} for OS {}'.format(hostname, os))
		data = {}
		file = reader(open(filename), delimiter=' ')

		# iterate values
		for values in file:
			if values == [] or values[0][0] == '#':
				continue
			sha = values[0]
			timestamp = int(values[1])
			lang = values[2]
			run = values[3]
			words = values[4]
			true_pos = values[5]
			true_pos_rate = values[6]
			true_neg = values[7]
			true_neg_rate = values[8]
			false_pos = values[9]
			false_pos_rate = values[10]
			false_neg = values[11]
			false_neg_rate = values[12]
			accuracy = float(values[13])
			precision = float(values[14])
			duration = values[15]
			speedup = float(values[16])

			if timestamp not in data:
				data[timestamp] = {}
			if 'sha' not in data[timestamp]: 
				data[timestamp]['sha'] = sha
				
			if 'accuracy_min' not in data[timestamp]: 
				data[timestamp]['accuracy_min'] = float_info.max
			if 'precision_min' not in data[timestamp]: 
				data[timestamp]['precision_min'] = float_info.max
			if 'speedup_min' not in data[timestamp]: 
				data[timestamp]['speedup_min'] = float_info.max
				
			if 'accuracy_max' not in data[timestamp]: 
				data[timestamp]['accuracy_max'] = 0.0
			if 'precision_max' not in data[timestamp]: 
				data[timestamp]['precision_max'] = 0.0
			if 'speedup_max' not in data[timestamp]: 
				data[timestamp]['speedup_max'] = 0.0
			
			if 'accuracies' not in data[timestamp]: 
				data[timestamp]['accuracies'] = {}
			if 'precisions' not in data[timestamp]: 
				data[timestamp]['precisions'] = {}
			if 'speedups' not in data[timestamp]: 
				data[timestamp]['speedups'] = {}

			if lang not in data[timestamp]['accuracies']:
				 data[timestamp]['accuracies'][lang] = accuracy
				 if accuracy < data[timestamp]['accuracy_min']:
				 	data[timestamp]['accuracy_min'] = accuracy
				 if accuracy > data[timestamp]['accuracy_max']:
				 	data[timestamp]['accuracy_max'] = accuracy
				 	
			if lang not in data[timestamp]['precisions']:
				 data[timestamp]['precisions'][lang] = precision
				 if accuracy < data[timestamp]['precision_min']:
				 	data[timestamp]['precision_min'] = precision
				 if accuracy > data[timestamp]['precision_max']:
				 	data[timestamp]['precision_max'] = precision
				 	
			if lang not in data[timestamp]['speedups']:
				 data[timestamp]['speedups'][lang] = speedup
				 if accuracy < data[timestamp]['speedup_min']:
				 	data[timestamp]['speedup_min'] = speedup
				 if accuracy > data[timestamp]['speedup_max']:
				 	data[timestamp]['speedup_max'] = speedup
		# iterate values
		
		average = writer(open('{}.tsv'.format(basename), 'w'), delimiter='\t')
		line = []
		line.append('#timestamp')
		line.append('handle')
		line.append('acc_min')
		line.append('acc_max')
		line.append('acc_mea')
		line.append('acc_std')
		line.append('acc_mms')
		line.append('acc_mps')
		line.append('pre_min')
		line.append('pre_max')
		line.append('pre_mea')
		line.append('pre_std')
		line.append('pre_mms')
		line.append('pre_mps')
		line.append('spe_min')
		line.append('spe_max')
		line.append('spe_mea')
		line.append('spe_std')
		line.append('spe_mms')
		line.append('spe_mps')
		average.writerow(line)
		for timestamp, values in sorted(data.items()):
			data[timestamp]['accuracy_mean'] = mean(data[timestamp]['accuracies'].values())
			data[timestamp]['precision_mean'] = mean(data[timestamp]['precisions'].values())
			data[timestamp]['speedup_mean'] = mean(data[timestamp]['speedups'].values())
					
			data[timestamp]['accuracy_stdev'] = 0.0
			data[timestamp]['precision_stdev'] = 0.0
			data[timestamp]['speedup_stdev'] = 0.0
			if len(data[timestamp]['accuracies'].values()) > 1: 
				data[timestamp]['accuracy_stdev'] = stdev(data[timestamp]['accuracies'].values())
			if len(data[timestamp]['precisions'].values()) > 1: 
				data[timestamp]['precision_stdev'] = stdev(data[timestamp]['precisions'].values())
			if len(data[timestamp]['speedups'].values()) > 1: 
				data[timestamp]['speedup_stdev'] = stdev(data[timestamp]['speedups'].values())

			if len(data[timestamp]['accuracies'].values()) != len(data[timestamp]['precisions'].values()) or len(data[timestamp]['precisions'].values()) != len(data[timestamp]['speedups'].values()):
				print('ERROR: Different amount of values amongst lists.')
				exit(1) 
			data[timestamp]['languages'] = len(data[timestamp]['accuracies'].values())
			
			line = []
			line.append(timestamp)
			line.append(values['sha'][:7]) # handle
			
			line.append('{0:1.3f}'.format(values['accuracy_min']))
			line.append('{0:1.3f}'.format(values['accuracy_max']))
			line.append('{0:1.3f}'.format(values['accuracy_mean']))
			line.append('{0:1.3f}'.format(values['accuracy_stdev']))
			line.append('{0:1.3f}'.format(values['accuracy_mean'] - values['accuracy_stdev']))
			line.append('{0:1.3f}'.format(values['accuracy_mean'] + values['accuracy_stdev']))
			
			line.append('{0:1.3f}'.format(values['precision_min']))
			line.append('{0:1.3f}'.format(values['precision_max']))
			line.append('{0:1.3f}'.format(values['precision_mean']))
			line.append('{0:1.3f}'.format(values['precision_stdev']))
			line.append('{0:1.3f}'.format(values['precision_mean'] - values['precision_stdev']))
			line.append('{0:1.3f}'.format(values['precision_mean'] + values['precision_stdev']))

			line.append('{0:1.3f}'.format(values['speedup_min']))
			line.append('{0:1.3f}'.format(values['speedup_max']))
			line.append('{0:1.3f}'.format(values['speedup_mean']))
			line.append('{0:1.3f}'.format(values['speedup_stdev']))
			line.append('{0:1.3f}'.format(values['speedup_mean'] - values['speedup_stdev']))
			line.append('{0:1.3f}'.format(values['speedup_mean'] + values['speedup_stdev']))
			average.writerow(line)

		average = writer(open('{}-latest.tsv'.format(basename), 'w'), delimiter='\t')
		values = data[sorted(data)[-1]]
		a = 1
#			a = subprocess.run(['../0-tools/language_support_to_language_name.sh', lang], capture_output=True)

	# iterate os with hostname
				


if __name__ == "__main__":
    main()
