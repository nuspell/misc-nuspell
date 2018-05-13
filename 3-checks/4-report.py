#!/usr/bin/env python3

from glob import glob
from os.path import isdir, isfile

#TODO support handle and timestamp            
def write_matrix_2(path, tot_pop, con_pos, con_neg, pre_con_pos, true_pos, false_pos, pre_con_neg, false_neg, true_neg, lang=None):
    out = open('{}/confusion_matrix.md'.format(path), 'w')
    if lang:
        out.write('# Confusion matrix language {}\n'.format(lang))
    else:
        out.write('# Confusion matrix over all languages\n')
    out.write('\n')
    out.write('## Confusion matrix correct vs. incorrect spelling\n')
    out.write('\n')


    prevalence = 'n/a'
    try:
        prevalence = '{0:.5f}'.format(con_pos/tot_pop) 
    except ZeroDivisionError:
        pass
    accuracy = 'n/a'
    try:
        accuracy = '{0:.5f}'.format((true_pos+true_neg)/tot_pop) 
    except ZeroDivisionError:
        pass
    
    true_pos__pre_con_pos = 'n/a'
    try:
        true_pos__pre_con_pos = '{0:.5f}'.format(true_pos/pre_con_pos) 
    except ZeroDivisionError:
        pass
    false_pos__pre_con_pos = 'n/a'
    try:
        false_pos__pre_con_pos = '{0:.5f}'.format(false_pos/pre_con_pos) 
    except ZeroDivisionError:
        pass
    false_neg__pre_con_neg = 'n/a'
    try:
        false_neg__pre_con_neg = '{0:.5f}'.format(false_neg/pre_con_neg) 
    except ZeroDivisionError:
        pass
    true_neg__pre_con_neg = 'n/a'
    try:
        true_neg__pre_con_neg = '{0:.5f}'.format(true_neg/pre_con_neg) 
    except ZeroDivisionError:
        pass

    sensitivity = 'n/a'
    try:
        sensitivity = '{0:.5f}'.format(true_pos/con_pos) 
    except ZeroDivisionError:
        pass
    fallout = 'n/a'
    try:
        fallout = '{0:.5f}'.format(false_neg/con_neg) 
    except ZeroDivisionError:
        pass

    pos_lik_rat = 'n/a'
    try:
        pos_lik_rat = '{0:.5f}'.format(float(sensitivity)/float(fallout)) 
    except (ZeroDivisionError, ValueError):
        pass

    missrate = 'n/a'
    try:
        missrate = '{0:.5f}'.format(false_neg/con_pos) 
    except ZeroDivisionError:
        pass
    specificity = 'n/a'   
    try:
        specificity = '{0:.5f}'.format(true_neg/con_neg) 
    except ZeroDivisionError:
        pass

    neg_lik_rat = 'n/a'
    try:
        neg_lik_rat = '{0:.5f}'.format(float(missrate)/float(specificity))
    except (ZeroDivisionError, ValueError):
        pass

    dia_odd_rat = 'n/a'
    try:
        dia_odd_rat = '{0:.5f}'.format(float(pos_lik_rat)/float(neg_lik_rat))
    except (ZeroDivisionError, ValueError):
        pass
    f1_score = 'n/a'
    try:
        f1_score = '{0:.5f}'.format(2/((1/float(sensitivity))+(1/float(true_pos__pre_con_pos)))) 
    except (ZeroDivisionError, ValueError):
        pass

    out.write('<table border="1">\n')
    out.write('<tr><td></td><td></td><th colspan="2" bgcolor="#EEB">True condition</th></tr>\n')
    out.write('<tr><td bgcolor="white"></td><td bgcolor="#DDD">Total population {:,}</td><td bgcolor="#FFC">Condition positive {:,}</td><td bgcolor="#DDA">Condition negative {:,}</td><td bgcolor="#EEC">Prevalence {}</td><td colspan="2" bgcolor="#CEC">Accuracy (ACC) {}</td></tr>\n'.format(tot_pop, con_pos, con_neg, prevalence, accuracy))
    out.write('<tr><th rowspan="2" bgcolor="#BEE">Predicted condition</th>')
    out.write('<td bgcolor="#CFF">Predicted condition positive {:,}</td><td bgcolor="#CFC"><strong>True positive</strong>, Power <strong>{:,}</strong></td><td bgcolor="#EDD"><strong>False positive</strong>, Type I error <strong>{:,}</strong></td><td bgcolor="#CFE">Positive predictive value (PPV), Precision {}</td><td colspan="2" bgcolor="#CEF">False discovery rate (FDR) {}</td></tr>\n'.format(pre_con_pos, true_pos, false_pos, true_pos__pre_con_pos, false_pos__pre_con_pos))
    out.write('<tr><td bgcolor="#ADD">Predicted condition negative {:,}</td><td bgcolor="#FDD"><strong>False negative</strong>, Type II error <strong>{:,}</strong></td><td bgcolor="#BEB"><strong>True negative</strong> <strong>{:,}</strong></td><td bgcolor="#EDE">False omission rate (FOR) {}</td><td colspan="2" bgcolor="#ADC">Negative predictive value (NPV) {}</td></tr>\n'.format(pre_con_neg, false_neg, true_neg, false_neg__pre_con_neg, true_neg__pre_con_neg))
    out.write('<tr><td></td><td></td><td bgcolor="#EFC">True positive rate (TPR), Recall, Sensitivity, probability of detection {}</td><td bgcolor="#EDB">False positive rate (FPR), Fall-out, probability of false alarm {}</td><td bgcolor="#EEE">Positive likelihood ratio (LR+) {}</td><td rowspan="2" bgcolor="#DDD">Diagnostic odds ratio {}</td><td rowspan="2" bgcolor="#DFD">F1 score {}</td></tr>\n'.format(sensitivity, fallout, pos_lik_rat, dia_odd_rat, f1_score))
    out.write('<tr><td bgcolor="white"></td><td bgcolor="white"></td><td bgcolor="#FEC">False negative rate (FNR), Miss rate {}</td><td bgcolor="#DEB">True negative rate (TNR), Specificity (SPC) {}</td><td bgcolor="#CCC">Negative likelihood ratio (LR−) {}</td></tr>\n'.format(missrate, specificity, neg_lik_rat))
    out.write('</table>\n')
    out.write('\n')
    out.write('\n')
    out.write('## Confusion matrix regarding five classifications\n')
    out.write('\n')
    out.write('TODO\n')
    out.write('\n')
    out.write('\n')

# iterate platforms
for platform_path in glob('regression/*'):
    if isfile(platform_path):
        continue
    platform_dir = platform_path.split('/')[-1]
    print('platform dir: {}'.format(platform_dir))
    
    # iterate commits
    for commit_path in glob('{}/*'.format(platform_path)):
        if isfile(commit_path):
            continue
        commit_dir = commit_path.split('/')[-1]
        commit, timestamp = commit_dir.split('_') 
        handle = commit[:7]
        print('commit_dir: {}'.format(commit_dir))
        print('commit: {}'.format(commit))
        print('handle: {}'.format(handle))
        print('timestamp: {}'.format(timestamp))
        time_path = None
        time_file = None

        tot_tot_pop = 0
        tot_con_pos = 0
        tot_con_neg = 0

        tot_pre_con_pos = 0            
        tot_true_pos = 0
        tot_false_pos = 0

        tot_pre_con_neg = 0            
        tot_false_neg = 0
        tot_true_neg = 0
        
        # iterate languages
        for lang_path in glob('{}/*'.format(commit_path)):
            if isfile(lang_path):
                if 'time-' in lang_path:
                    time_path = lang_path
                    time_file = lang_path.split('/')[-1]
                    print('time file: {}'.format(time_file))
                continue
            lang_dir = lang_path.split('/')[-1]
            print('lang dir: {}'.format(lang_dir))

            # read counts
            
            if not isfile('{}/gathered.confusion_true_pos'.format(lang_path)):
                continue

            tot_pop = None
            con_pos = None
            con_neg = None

            pre_con_pos = None            
            true_pos = None
            false_pos = None

            pre_con_neg = None            
            false_neg = None
            true_neg = None

            with open('{}/gathered.total'.format(lang_path)) as f:
                tot_pop = int(f.readline().strip())
            with open('{}/gathered.total_correct_src'.format(lang_path)) as f:
                con_pos = int(f.readline().strip())
            with open('{}/gathered.total_incorrect_src'.format(lang_path)) as f:
                con_neg = int(f.readline().strip())

            with open('{}/gathered.total_correct'.format(lang_path)) as f:
                pre_con_pos = int(f.readline().strip())
            with open('{}/gathered.confusion_true_pos'.format(lang_path)) as f:
                true_pos = int(f.readline().strip())
            with open('{}/gathered.confusion_false_pos'.format(lang_path)) as f:
                false_pos = int(f.readline().strip())

            with open('{}/gathered.total_incorrect'.format(lang_path)) as f:
                pre_con_neg = int(f.readline().strip())
            with open('{}/gathered.confusion_false_neg'.format(lang_path)) as f:
                false_neg = int(f.readline().strip())
            with open('{}/gathered.confusion_true_neg'.format(lang_path)) as f:
                true_neg = int(f.readline().strip())

            tot_tot_pop += tot_pop
            tot_con_pos += con_pos
            tot_con_neg += con_neg

            tot_pre_con_pos += pre_con_pos
            tot_true_pos += true_pos
            tot_false_pos += false_pos

            tot_pre_con_neg += pre_con_neg
            tot_false_neg += false_neg
            tot_true_neg += true_neg
            
            # write confusion matrix correct vs. incorrect spelling for language
            write_matrix_2(lang_path, tot_pop, con_pos, con_neg, pre_con_pos, true_pos, false_pos, pre_con_neg, false_neg, true_neg, lang_dir)

        # write overall confusion matrix correct vs. incorrect spelling
        write_matrix_2(commit_path, tot_tot_pop, tot_con_pos, tot_con_neg, tot_pre_con_pos, tot_true_pos, tot_false_pos, tot_pre_con_neg, tot_false_neg, tot_true_neg)

