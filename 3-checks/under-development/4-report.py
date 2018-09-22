#!/usr/bin/env python3

from glob import glob
from os.path import isdir, isfile

#TODO support handle and timestamp            
def write_header(path, lang=None, langs=None):
    out = open('{}/confusion_matrix.md'.format(path), 'w')
    if lang:
        out.write('# Confusion matrix language {}\n'.format(lang))
        out.write('\n')
        out.write('See results over [all languages](../confusion_matrix.md).\n')
        out.write('\n')
    else:
        out.write('# Confusion matrix over all languages\n')
        out.write('\n')
    if langs:
        ls = set()
        for l in langs:
            ls.add('[{}]({}/confusion_matrix.md)'.format(l, l))
        out.write('Reported for languages: {}\n'.format(', '.join(sorted(ls))))
        out.write('\n')
    out.write('\n')
    
    return out

def write_matrix_2(out, tot_pop, con_pos, con_neg, pre_con_pos, true_pos, false_pos, pre_con_neg, false_neg, true_neg):    
    out.write('# Confusion matrix correct vs. incorrect spelling\n')
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
    out.write('<tr><td colspan="2" bgcolor="white"></td><th colspan="2" bgcolor="#EEB">True condition</th></tr>\n')
    out.write('<tr><td bgcolor="white"></td><td bgcolor="#DDD">Total population {:,}</td><td bgcolor="#FFC">Condition positive {:,}</td><td bgcolor="#DDA">Condition negative {:,}</td><td bgcolor="#EEC">Prevalence {}</td><td colspan="2" bgcolor="#CEC">Accuracy (ACC) {}</td></tr>\n'.format(tot_pop, con_pos, con_neg, prevalence, accuracy))
    out.write('<tr><th rowspan="2" bgcolor="#BEE">Predicted condition</th>')
    out.write('<td bgcolor="#CFF">Predicted condition positive {:,}</td><td bgcolor="#CFC"><strong>True positive</strong>, Power <strong>{:,}</strong></td><td bgcolor="#EDD"><strong>False positive</strong>, Type I error <strong>{:,}</strong></td><td bgcolor="#CFE">Positive predictive value (PPV), Precision {}</td><td colspan="2" bgcolor="#CEF">False discovery rate (FDR) {}</td></tr>\n'.format(pre_con_pos, true_pos, false_pos, true_pos__pre_con_pos, false_pos__pre_con_pos))
    out.write('<tr><td bgcolor="#ADD">Predicted condition negative {:,}</td><td bgcolor="#FDD"><strong>False negative</strong>, Type II error <strong>{:,}</strong></td><td bgcolor="#BEB"><strong>True negative</strong> <strong>{:,}</strong></td><td bgcolor="#EDE">False omission rate (FOR) {}</td><td colspan="2" bgcolor="#ADC">Negative predictive value (NPV) {}</td></tr>\n'.format(pre_con_neg, false_neg, true_neg, false_neg__pre_con_neg, true_neg__pre_con_neg))
    out.write('<tr><td colspan="2" rowspan="2" bgcolor="white"></td><td bgcolor="#EFC">True positive rate (TPR), Recall, Sensitivity, probability of detection {}</td><td bgcolor="#EDB">False positive rate (FPR), Fall-out, probability of false alarm {}</td><td bgcolor="#EEE">Positive likelihood ratio (LR+) {}</td><td rowspan="2" bgcolor="#DDD">Diagnostic odds ratio {}</td><td rowspan="2" bgcolor="#DFD">F1 score {}</td></tr>\n'.format(sensitivity, fallout, pos_lik_rat, dia_odd_rat, f1_score))
    out.write('<tr><td bgcolor="#FEC">False negative rate (FNR), Miss rate {}</td><td bgcolor="#DEB">True negative rate (TNR), Specificity (SPC) {}</td><td bgcolor="#CCC">Negative likelihood ratio (LR−) {}</td></tr>\n'.format(missrate, specificity, neg_lik_rat))
    out.write('</table>\n')
    out.write('\n')
    out.write('\n')

def write_matrix_5(out, oo, oa, oc, on, ou, ao, aa, ac, an, au, co, ca, cc, cn, cu, no, na, nc, nn, nu, uo, ua, uc, un, uu):    
    out.write('# Table of confusion regarding five classifications\n')
    out.write('\n')
    out.write('<table border="1">\n')
    out.write('<tr><td colspan="2" rowspan="2" bgcolor="white"></td><th colspan="5" bgcolor="#f8f9fa">Actual class</th></tr>\n')
    out.write('<tr><th bgcolor="#eaecf0">OK</th><th bgcolor="#eaecf0">Affixed</th><th bgcolor="#eaecf0">Compounded</th><th bgcolor="#eaecf0">Near-miss</th><th bgcolor="#eaecf0">Unknown</th></tr>\n')
    out.write('<tr><th rowspan="5" bgcolor="#eaecf0">Predicted class</th><th bgcolor="#eaecf0">OK</th><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td></tr>\n'.format(oo, oa, oc, on, ou))
    out.write('<tr><th bgcolor="#eaecf0">Affixed</th><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td></tr>\n'.format(ao, aa, ac, an, au))
    out.write('<tr><th bgcolor="#eaecf0">Compounded</th><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td></tr>\n'.format(co, ca, cc, cn, cu))
    out.write('<tr><th bgcolor="#eaecf0">Near-miss</th><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td></tr>\n'.format(no, na, nc, nn, nu))
    out.write('<tr><th bgcolor="#eaecf0">Unknown</th><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td><td bgcolor="#f8f9fa">{}</td></tr>\n'.format(uo, ua, uc, un, uu))
    out.write('</table>\n')

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

        # o = okay
        # a = affixed
        # c = compounded
        # n = nearmiss
        # u = unknown

        tot_oo = 0
        tot_oa = 0
        tot_oc = 0
        tot_on = 0
        tot_ou = 0
        tot_ao = 0
        tot_aa = 0
        tot_ac = 0
        tot_an = 0
        tot_au = 0
        tot_co = 0
        tot_ca = 0
        tot_cc = 0
        tot_cn = 0
        tot_cu = 0
        tot_no = 0
        tot_na = 0
        tot_nc = 0
        tot_nn = 0
        tot_nu = 0
        tot_uo = 0
        tot_ua = 0
        tot_uc = 0
        tot_un = 0
        tot_uu = 0

        tot_tot_pop = 0
        tot_con_pos = 0
        tot_con_neg = 0

        tot_pre_con_pos = 0            
        tot_true_pos = 0
        tot_false_pos = 0

        tot_pre_con_neg = 0            
        tot_false_neg = 0
        tot_true_neg = 0
        
        langs = set()
        # iterate languages
        for lang_path in sorted(glob('{}/*'.format(commit_path))):
            if isfile(lang_path):
                if 'time-' in lang_path:
                    time_path = lang_path
                    time_file = lang_path.split('/')[-1]
                    print('time file: {}'.format(time_file))
                continue
            lang_dir = lang_path.split('/')[-1]
            print('lang dir: {}'.format(lang_dir))
            langs.add(lang_dir)

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

            oo = None
            oa = None
            oc = None
            on = None
            ou = None
            with open('{}/gathered.okay_okay'.format(lang_path)) as f:
                oo = int(f.readline().strip())
            with open('{}/gathered.okay_affixed'.format(lang_path)) as f:
                oa = int(f.readline().strip())
            with open('{}/gathered.okay_compounded'.format(lang_path)) as f:
                oc = int(f.readline().strip())
            with open('{}/gathered.okay_nearmiss'.format(lang_path)) as f:
                on = int(f.readline().strip())
            with open('{}/gathered.okay_unknown'.format(lang_path)) as f:
                ou = int(f.readline().strip())

            ao = None
            aa = None
            ac = None
            an = None
            au = None
            with open('{}/gathered.affixed_okay'.format(lang_path)) as f:
                ao = int(f.readline().strip())
            with open('{}/gathered.affixed_affixed'.format(lang_path)) as f:
                aa = int(f.readline().strip())
            with open('{}/gathered.affixed_compounded'.format(lang_path)) as f:
                ac = int(f.readline().strip())
            with open('{}/gathered.affixed_nearmiss'.format(lang_path)) as f:
                an = int(f.readline().strip())
            with open('{}/gathered.affixed_unknown'.format(lang_path)) as f:
                au = int(f.readline().strip())

            co = None
            ca = None
            cc = None
            cn = None
            cu = None
            with open('{}/gathered.compounded_okay'.format(lang_path)) as f:
                co = int(f.readline().strip())
            with open('{}/gathered.compounded_affixed'.format(lang_path)) as f:
                ca = int(f.readline().strip())
            with open('{}/gathered.compounded_compounded'.format(lang_path)) as f:
                cc = int(f.readline().strip())
            with open('{}/gathered.compounded_nearmiss'.format(lang_path)) as f:
                cn = int(f.readline().strip())
            with open('{}/gathered.compounded_unknown'.format(lang_path)) as f:
                cu = int(f.readline().strip())

            no = None
            na = None
            nc = None
            nn = None
            nu = None
            with open('{}/gathered.nearmiss_okay'.format(lang_path)) as f:
                no = int(f.readline().strip())
            with open('{}/gathered.nearmiss_affixed'.format(lang_path)) as f:
                na = int(f.readline().strip())
            with open('{}/gathered.nearmiss_compounded'.format(lang_path)) as f:
                nc = int(f.readline().strip())
            with open('{}/gathered.nearmiss_nearmiss'.format(lang_path)) as f:
                nn = int(f.readline().strip())
            with open('{}/gathered.nearmiss_unknown'.format(lang_path)) as f:
                nu = int(f.readline().strip())

            uo = None
            ua = None
            uc = None
            un = None
            uu = None
            with open('{}/gathered.unknown_okay'.format(lang_path)) as f:
                uo = int(f.readline().strip())
            with open('{}/gathered.unknown_affixed'.format(lang_path)) as f:
                ua = int(f.readline().strip())
            with open('{}/gathered.unknown_compounded'.format(lang_path)) as f:
                uc = int(f.readline().strip())
            with open('{}/gathered.unknown_nearmiss'.format(lang_path)) as f:
                un = int(f.readline().strip())
            with open('{}/gathered.unknown_unknown'.format(lang_path)) as f:
                uu = int(f.readline().strip())

            tot_oo += oo
            tot_oa += oa
            tot_oc += oc
            tot_on += on
            tot_ou += ou
            tot_ao += ao
            tot_aa += aa
            tot_ac += ac
            tot_an += an
            tot_au += au
            tot_co += co
            tot_ca += ca
            tot_cc += cc
            tot_cn += cn
            tot_cu += cu
            tot_no += no
            tot_na += na
            tot_nc += nc
            tot_nn += nn
            tot_nu += nu
            tot_uo += uo
            tot_ua += ua
            tot_uc += uc
            tot_un += un
            tot_uu += uu
            
            # write confusion matrix correct vs. incorrect spelling for language
            out = write_header(lang_path, lang_dir)
            write_matrix_2(out, tot_pop, con_pos, con_neg, pre_con_pos, true_pos, false_pos, pre_con_neg, false_neg, true_neg)
            write_matrix_5(out, oo, oa, oc, on, ou, ao, aa, ac, an, au, co, ca, cc, cn, cu, no, na, nc, nn, nu, uo, ua, uc, un, uu)    

        # write overall confusion matrix correct vs. incorrect spelling
        out = write_header(commit_path, None, langs)
        write_matrix_2(out, tot_tot_pop, tot_con_pos, tot_con_neg, tot_pre_con_pos, tot_true_pos, tot_false_pos, tot_pre_con_neg, tot_false_neg, tot_true_neg)
        write_matrix_5(out, tot_oo, tot_oa, tot_oc, tot_on, tot_ou, tot_ao, tot_aa, tot_ac, tot_an, tot_au, tot_co, tot_ca, tot_cc, tot_cn, tot_cu, tot_no, tot_na, tot_nc, tot_nn, tot_nu, tot_uo, tot_ua, tot_uc, tot_un, tot_uu)    

