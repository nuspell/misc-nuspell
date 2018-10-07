#!/usr/bin/env python3

from csv import reader, writer
from datetime import datetime
from glob import glob
from operator import itemgetter
from sys import maxsize, float_info 
from statistics import mean, stdev
from subprocess import getoutput


def main():
	# iterate filename
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
			words = int(values[4])
			true_pos = values[5]
			true_pos_rate = float(values[6])
			true_neg = values[7]
			true_neg_rate = float(values[8])
			false_pos = values[9]
			false_pos_rate = float(values[10])
			false_neg = values[11]
			false_neg_rate = float(values[12])
			accuracy = float(values[13])
			precision = float(values[14])
			duration = values[15]
			speedup = float(values[16])

			if timestamp not in data:
				data[timestamp] = {}
			if 'sha' not in data[timestamp]: 
				data[timestamp]['sha'] = sha

			if 'words_min' not in data[timestamp]: 
				data[timestamp]['words_min'] = maxsize
			if 'true_pos_rate_min' not in data[timestamp]: 
				data[timestamp]['true_pos_rate_min'] = float_info.max
			if 'true_neg_rate_min' not in data[timestamp]: 
				data[timestamp]['true_neg_rate_min'] = float_info.max
			if 'false_pos_rate_min' not in data[timestamp]: 
				data[timestamp]['false_pos_rate_min'] = float_info.max
			if 'false_neg_rate_min' not in data[timestamp]: 
				data[timestamp]['false_neg_rate_min'] = float_info.max
			if 'accuracy_min' not in data[timestamp]: 
				data[timestamp]['accuracy_min'] = float_info.max
			if 'precision_min' not in data[timestamp]: 
				data[timestamp]['precision_min'] = float_info.max
			if 'speedup_min' not in data[timestamp]: 
				data[timestamp]['speedup_min'] = float_info.max
				
			if 'words_max' not in data[timestamp]: 
				data[timestamp]['words_max'] = 0
			if 'true_pos_rate_max' not in data[timestamp]: 
				data[timestamp]['true_pos_rate_max'] = 0.0
			if 'true_neg_rate_max' not in data[timestamp]: 
				data[timestamp]['true_neg_rate_max'] = 0.0
			if 'false_pos_rate_max' not in data[timestamp]: 
				data[timestamp]['false_pos_rate_max'] = 0.0
			if 'false_neg_rate_max' not in data[timestamp]: 
				data[timestamp]['false_neg_rate_max'] = 0.0
			if 'accuracy_max' not in data[timestamp]: 
				data[timestamp]['accuracy_max'] = 0.0
			if 'precision_max' not in data[timestamp]: 
				data[timestamp]['precision_max'] = 0.0
			if 'speedup_max' not in data[timestamp]: 
				data[timestamp]['speedup_max'] = 0.0
			
			if 'wordss' not in data[timestamp]: 
				data[timestamp]['wordss'] = {}
			if 'true_pos_rates' not in data[timestamp]: 
				data[timestamp]['true_pos_rates'] = {}
			if 'true_neg_rates' not in data[timestamp]: 
				data[timestamp]['true_neg_rates'] = {}
			if 'false_pos_rates' not in data[timestamp]: 
				data[timestamp]['false_pos_rates'] = {}
			if 'false_neg_rates' not in data[timestamp]: 
				data[timestamp]['false_neg_rates'] = {}
			if 'accuracies' not in data[timestamp]: 
				data[timestamp]['accuracies'] = {}
			if 'precisions' not in data[timestamp]: 
				data[timestamp]['precisions'] = {}
			if 'speedups' not in data[timestamp]: 
				data[timestamp]['speedups'] = {}

			if lang not in data[timestamp]['wordss']:
				 data[timestamp]['wordss'][lang] = words
				 if words < data[timestamp]['words_min']:
				 	data[timestamp]['words_min'] = words
				 if words > data[timestamp]['words_max']:
				 	data[timestamp]['words_max'] = words
				 	
			if lang not in data[timestamp]['true_pos_rates']:
				 data[timestamp]['true_pos_rates'][lang] = true_pos_rate
				 if true_pos_rate < data[timestamp]['true_pos_rate_min']:
				 	data[timestamp]['true_pos_rate_min'] = true_pos_rate
				 if true_pos_rate > data[timestamp]['true_pos_rate_max']:
				 	data[timestamp]['true_pos_rate_max'] = true_pos_rate
				 	
			if lang not in data[timestamp]['true_neg_rates']:
				 data[timestamp]['true_neg_rates'][lang] = true_neg_rate
				 if true_neg_rate < data[timestamp]['true_neg_rate_min']:
				 	data[timestamp]['true_neg_rate_min'] = true_neg_rate
				 if true_neg_rate > data[timestamp]['true_neg_rate_max']:
				 	data[timestamp]['true_neg_rate_max'] = true_neg_rate
				 	
			if lang not in data[timestamp]['false_pos_rates']:
				 data[timestamp]['false_pos_rates'][lang] = false_pos_rate
				 if false_pos_rate < data[timestamp]['false_pos_rate_min']:
				 	data[timestamp]['false_pos_rate_min'] = false_pos_rate
				 if false_pos_rate > data[timestamp]['false_pos_rate_max']:
				 	data[timestamp]['false_pos_rate_max'] = false_pos_rate
				 	
			if lang not in data[timestamp]['false_neg_rates']:
				 data[timestamp]['false_neg_rates'][lang] = false_neg_rate
				 if false_neg_rate < data[timestamp]['false_neg_rate_min']:
				 	data[timestamp]['false_neg_rate_min'] = false_neg_rate
				 if false_neg_rate > data[timestamp]['false_neg_rate_max']:
				 	data[timestamp]['false_neg_rate_max'] = false_neg_rate 
				 	
			if lang not in data[timestamp]['accuracies']:
				 data[timestamp]['accuracies'][lang] = accuracy
				 if accuracy < data[timestamp]['accuracy_min']:
				 	data[timestamp]['accuracy_min'] = accuracy
				 if accuracy > data[timestamp]['accuracy_max']:
				 	data[timestamp]['accuracy_max'] = accuracy
				 	
			if lang not in data[timestamp]['precisions']:
				 data[timestamp]['precisions'][lang] = precision
				 if precision < data[timestamp]['precision_min']:
				 	data[timestamp]['precision_min'] = precision
				 if precision > data[timestamp]['precision_max']:
				 	data[timestamp]['precision_max'] = precision
				 	
			if lang not in data[timestamp]['speedups']:
				 data[timestamp]['speedups'][lang] = speedup
				 if speedup < data[timestamp]['speedup_min']:
				 	data[timestamp]['speedup_min'] = speedup
				 if speedup > data[timestamp]['speedup_max']:
				 	data[timestamp]['speedup_max'] = speedup
		# iterate values
		
		average = writer(open('{}.tsv'.format(basename), 'w'), delimiter='\t')
		line = []
		line.append('#timestamp')
		line.append('handle')
		line.append('langs')
		line.append('wds_min')
		line.append('wds_max')
		line.append('wds_mea')
		line.append('wds_std')
		line.append('wds_mms')
		line.append('wds_mps')
		line.append('tpr_min')
		line.append('tpr_max')
		line.append('tpr_mea')
		line.append('tpr_std')
		line.append('tpr_mms')
		line.append('tpr_mps')
		line.append('tnr_min')
		line.append('tnr_max')
		line.append('tnr_mea')
		line.append('tnr_std')
		line.append('tnr_mms')
		line.append('tnr_mps')
		line.append('fpr_min')
		line.append('fpr_max')
		line.append('fpr_mea')
		line.append('fpr_std')
		line.append('fpr_mms')
		line.append('fpr_mps')
		line.append('fnr_min')
		line.append('fnr_max')
		line.append('fnr_mea')
		line.append('fnr_std')
		line.append('fnr_mms')
		line.append('fnr_mps')
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
			data[timestamp]['words_mean'] = mean(data[timestamp]['wordss'].values())
			data[timestamp]['true_pos_rate_mean'] = mean(data[timestamp]['true_pos_rates'].values())
			data[timestamp]['true_neg_rate_mean'] = mean(data[timestamp]['true_neg_rates'].values())
			data[timestamp]['false_pos_rate_mean'] = mean(data[timestamp]['false_pos_rates'].values())
			data[timestamp]['false_neg_rate_mean'] = mean(data[timestamp]['false_neg_rates'].values())
			data[timestamp]['accuracy_mean'] = mean(data[timestamp]['accuracies'].values())
			data[timestamp]['precision_mean'] = mean(data[timestamp]['precisions'].values())
			data[timestamp]['speedup_mean'] = mean(data[timestamp]['speedups'].values())
					
			data[timestamp]['words_stdev'] = 0.0
			data[timestamp]['true_pos_rate_stdev'] = 0.0
			data[timestamp]['true_neg_rate_stdev'] = 0.0
			data[timestamp]['false_pos_rate_stdev'] = 0.0
			data[timestamp]['false_neg_rate_stdev'] = 0.0
			data[timestamp]['accuracy_stdev'] = 0.0
			data[timestamp]['precision_stdev'] = 0.0
			data[timestamp]['speedup_stdev'] = 0.0
			if len(data[timestamp]['wordss'].values()) > 1: 
				data[timestamp]['words_stdev'] = stdev(data[timestamp]['wordss'].values())
			if len(data[timestamp]['true_pos_rates'].values()) > 1: 
				data[timestamp]['true_pos_rate_stdev'] = stdev(data[timestamp]['true_pos_rates'].values())
			if len(data[timestamp]['true_neg_rates'].values()) > 1: 
				data[timestamp]['true_neg_rate_stdev'] = stdev(data[timestamp]['true_neg_rates'].values())
			if len(data[timestamp]['false_pos_rates'].values()) > 1: 
				data[timestamp]['false_pos_rate_stdev'] = stdev(data[timestamp]['false_pos_rates'].values())
			if len(data[timestamp]['false_neg_rates'].values()) > 1: 
				data[timestamp]['false_neg_rate_stdev'] = stdev(data[timestamp]['false_neg_rates'].values())
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
			line.append(values['sha'][:7])  # handle
			line.append(values['languages'])
			
			line.append('{}'.format(values['words_min']))
			line.append('{}'.format(values['words_max']))
			line.append('{:.1f}'.format(values['words_mean']))
			line.append('{:.1f}'.format(values['words_stdev']))
			line.append('{:.1f}'.format(max(values['words_mean'] - values['words_stdev'], values['words_min'])))
			line.append('{:.1f}'.format(min(values['words_mean'] + values['words_stdev'], values['words_max'])))
			
			line.append('{:1.3f}'.format(values['true_pos_rate_min']))
			line.append('{:1.3f}'.format(values['true_pos_rate_max']))
			line.append('{:1.3f}'.format(values['true_pos_rate_mean']))
			line.append('{:1.3f}'.format(values['true_pos_rate_stdev']))
			line.append('{:1.3f}'.format(max(values['true_pos_rate_mean'] - values['true_pos_rate_stdev'], values['true_pos_rate_min'])))
			line.append('{:1.3f}'.format(min(values['true_pos_rate_mean'] + values['true_pos_rate_stdev'], values['true_pos_rate_max'])))
			
			line.append('{:01.3f}'.format(values['true_neg_rate_min']))
			line.append('{:01.3f}'.format(values['true_neg_rate_max']))
			line.append('{:01.3f}'.format(values['true_neg_rate_mean']))
			line.append('{:01.3f}'.format(values['true_neg_rate_stdev']))
			line.append('{:01.3f}'.format(max(values['true_neg_rate_mean'] - values['true_neg_rate_stdev'], values['true_neg_rate_min'])))
			line.append('{:01.3f}'.format(min(values['true_neg_rate_mean'] + values['true_neg_rate_stdev'], values['true_neg_rate_max'])))
			
			line.append('{:01.3f}'.format(values['false_pos_rate_min']))
			line.append('{:01.3f}'.format(values['false_pos_rate_max']))
			line.append('{:01.3f}'.format(values['false_pos_rate_mean']))
			line.append('{:01.3f}'.format(values['false_pos_rate_stdev']))
			line.append('{:01.3f}'.format(max(values['false_pos_rate_mean'] - values['false_pos_rate_stdev'], values['false_pos_rate_min'])))
			line.append('{:01.3f}'.format(min(values['false_pos_rate_mean'] + values['false_pos_rate_stdev'], values['false_pos_rate_max'])))
			
			line.append('{:01.3f}'.format(values['false_neg_rate_min']))
			line.append('{:01.3f}'.format(values['false_neg_rate_max']))
			line.append('{:01.3f}'.format(values['false_neg_rate_mean']))
			line.append('{:01.3f}'.format(values['false_neg_rate_stdev']))
			line.append('{:01.3f}'.format(max(values['false_neg_rate_mean'] - values['false_neg_rate_stdev'], values['false_neg_rate_min'])))
			line.append('{:01.3f}'.format(min(values['false_neg_rate_mean'] + values['false_neg_rate_stdev'], values['false_neg_rate_max'])))
			
			line.append('{:01.3f}'.format(values['accuracy_min']))
			line.append('{:01.3f}'.format(values['accuracy_max']))
			line.append('{:01.3f}'.format(values['accuracy_mean']))
			line.append('{:01.3f}'.format(values['accuracy_stdev']))
			line.append('{:01.3f}'.format(max(values['accuracy_mean'] - values['accuracy_stdev'], values['accuracy_min'])))
			line.append('{:01.3f}'.format(min(values['accuracy_mean'] + values['accuracy_stdev'], values['accuracy_max'])))
			
			line.append('{:01.3f}'.format(values['precision_min']))
			line.append('{:01.3f}'.format(values['precision_max']))
			line.append('{:01.3f}'.format(values['precision_mean']))
			line.append('{:01.3f}'.format(values['precision_stdev']))
			line.append('{:01.3f}'.format(max(values['precision_mean'] - values['precision_stdev'], values['precision_min'])))
			line.append('{:01.3f}'.format(min(values['precision_mean'] + values['precision_stdev'], values['precision_max'])))

			line.append('{:01.2f}'.format(values['speedup_min']))
			line.append('{:01.2f}'.format(values['speedup_max']))
			line.append('{:01.2f}'.format(values['speedup_mean']))
			line.append('{:01.2f}'.format(values['speedup_stdev']))
			line.append('{:01.2f}'.format(max(values['speedup_mean'] - values['speedup_stdev'], values['speedup_min'])))
			line.append('{:01.2f}'.format(min(values['speedup_mean'] + values['speedup_stdev'], values['speedup_max'])))
			average.writerow(line)

		latest = writer(open('{}-latest.tsv'.format(basename), 'w'), delimiter='\t')
		line = []
		line.append('#timestamp')
		line.append('handle')
		line.append('words')
		line.append('tpr')
		line.append('tnr')
		line.append('fpr')
		line.append('fnr')
		line.append('acc')
		line.append('pre')
		line.append('spe')
		line.append('lang')
		line.append('language')
		latest.writerow(line)
		timestamp = sorted(data)[-1]  # latest
		values = data[timestamp]
		for lang, v in sorted(values['wordss'].items()):
			line = []
			line.append(timestamp)
			line.append(values['sha'][:7])
			line.append(values['wordss'][lang])
			line.append(values['true_pos_rates'][lang])
			line.append(values['true_neg_rates'][lang])
			line.append(values['false_pos_rates'][lang])
			line.append(values['false_pos_rates'][lang])
			line.append(values['accuracies'][lang])
			line.append(values['precisions'][lang])
			line.append(values['speedups'][lang])
			line.append(lang)
			language = getoutput('../0-tools/language_support_to_language_name.sh {}'.format(lang))
			line.append(language)
			latest.writerow(line)

		if filename == 'linux_yari.ssv':
			md = open('performance.md', 'w')
			md.write('''---
title: Performance
layout: page
---

Performance can be measured in a variety of ways. For Nuspell, performance is firstly measured in terms of correctness of spell checking functionality and speedup compared to Hunspell.

# Verification Nuspell vs. Hunspell

Below are the overall results from the verification testing in terms if functional and speedup performance for the latest version of Nuspell, i.e. commit [`{}`](https://github.com/nuspell/nuspell/commit/{}) from {}.  This is done by using [words lists](https://github.com/nuspell/nuspell/wiki/Word-List-Files) and [dictionaries](https://github.com/nuspell/nuspell/wiki/Dictionary-Files) for {} different languages.

| metric statistics | minimum | mean - std. (capped) | mean | mean + std. (capped) | maximum |
|---|--:|--:|--:|--:|--:|
'''.format(values['sha'][:7], values['sha'], datetime.utcfromtimestamp(timestamp).strftime('%Y-%m-%d %H:%M:%S').replace(' ' , ' at '), len(values['wordss'])))

			md.write('| **words tested** | `{:,}`| `{:,.0f}`| `{:,.0f}`| `{:,.0f}`| `{:,}` |\n'.format(values['words_min'], max(values['words_mean'] - values['words_stdev'], values['words_min']), values['words_mean'], min(values['words_mean'] + values['words_stdev'], values['words_max']), values['words_max']))
			md.write('| **true positive rate** | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` |\n'.format(values['true_pos_rate_min'], max(values['true_pos_rate_mean'] - values['true_pos_rate_stdev'], values['true_pos_rate_min']), values['true_pos_rate_mean'], min(values['true_pos_rate_mean'] + values['true_pos_rate_stdev'], values['true_pos_rate_max']), values['true_pos_rate_max'])) 
			md.write('| **true negative rate** | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` |\n'.format(values['true_neg_rate_min'], max(values['true_neg_rate_mean'] - values['true_neg_rate_stdev'], values['true_neg_rate_min']), values['true_neg_rate_mean'], min(values['true_neg_rate_mean'] + values['true_neg_rate_stdev'], values['true_neg_rate_max']), values['true_neg_rate_max']))
			md.write('| **false positive rate** | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` |\n'.format(values['false_pos_rate_min'], max(values['false_pos_rate_mean'] - values['false_pos_rate_stdev'], values['false_pos_rate_min']), values['false_pos_rate_mean'], min(values['false_pos_rate_mean'] + values['false_pos_rate_stdev'], values['false_pos_rate_max']), values['false_pos_rate_max']))
			md.write('| **false negative rate** | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` |\n'.format(values['false_neg_rate_min'], max(values['false_neg_rate_mean'] - values['false_neg_rate_stdev'], values['false_neg_rate_min']), values['false_neg_rate_mean'], min(values['false_neg_rate_mean'] + values['false_neg_rate_stdev'], values['false_neg_rate_max']), values['false_neg_rate_max']))
			md.write('| **accuracy** | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` |\n'.format(values['accuracy_min'], max(values['accuracy_mean'] - values['accuracy_stdev'], values['accuracy_min']), values['accuracy_mean'], min(values['accuracy_mean'] + values['accuracy_stdev'], values['accuracy_max']), values['accuracy_max']))
			md.write('| **precision** | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` | `{:01.3f}` |\n'.format( values['precision_min'], max(values['precision_mean'] - values['precision_stdev'], values['precision_min']), values['precision_mean'], min(values['precision_mean'] + values['precision_stdev'], values['precision_max']), values['precision_max']))
			md.write('| **speedup** | `{:01.2f}` | `{:01.2f}` | `{:01.2f}` | `{:01.2f}` | `{:01.2f}` |\n'.format(values['speedup_min'], max(values['speedup_mean'] - values['speedup_stdev'], values['speedup_min']), values['speedup_mean'], min(values['speedup_mean'] + values['speedup_stdev'], values['speedup_max']), values['speedup_max']))

			md.write('''
Broken down per language, the functional and performance measurements are in the table below.
			
| language | code | words tested | true positive rate | true negative rate | false positive rate | false negative rate | accuracy | precision | speedup |
|---|---|--:|--:|--:|--:|--:|--:|--:|--:|
''')

			for lang, v in sorted(values['wordss'].items()):
				language = getoutput('../0-tools/language_support_to_language_name.sh {}'.format(lang))
				md.write('| {} '.format(language))
				md.write('| `{}` '.format(lang))
				md.write('| `{:,}`'.format(values['wordss'][lang]))
				md.write('| `{:01.3f}` '.format(values['true_pos_rates'][lang]))
				md.write('| `{:01.3f}` '.format(values['true_neg_rates'][lang]))
				md.write('| `{:01.3f}` '.format(values['false_pos_rates'][lang]))
				md.write('| `{:01.3f}` '.format(values['false_neg_rates'][lang]))
				md.write('| `{:01.3f}` '.format(values['accuracies'][lang]))
				md.write('| `{:01.3f}` '.format(values['precisions'][lang]))
				md.write('| `{:01.2f}` '.format(values['speedups'][lang]))
				md.write('|\n')
						
			md.write('''
			
Soon this information will also be offered in graphs, showing regression of performance in terms of functionality and speed over key commits to the source code repository.

# See also

Upcoming features improving performance are listed in the project's [roadmap](roadmap.html).
''')
	# iterate filename


if __name__ == "__main__":
    main()
