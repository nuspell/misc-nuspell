#!/usr/bin/env python3

# Content of option-usage.md is to be copy-pasted into the following wiki page
# https://github.com/hunspell/hunspell/wiki/Option-Usage

from pprint import pprint
from os import listdir, path
from datetime import datetime
from pycountry import countries, languages


def get_country(code):
    if len(code) == 2:
#        if ',' in countries.get(alpha_2=code).name or '(' in countries.get(alpha_2=code).name:
#            print(countries.get(alpha_2=code).name)
        return countries.get(alpha_2=code).name
    elif len(code) == 3:
#        if ',' in countries.get(alpha_3=code).name or '(' in countries.get(alpha_3=code).name:
#            print(countries.get(alpha_3=code).name)
        return countries.get(alpha_3=code).name
    else:
        print('ERROR: Unsupported language code {}'.format(code))
        exit(1)

def get_lang(code):
    if len(code) == 2:
#        if ',' in languages.get(alpha_2=code).name or '(' in languages.get(alpha_2=code).name:
#            print(languages.get(alpha_2=code).name)
        return languages.get(alpha_2=code).name.split(' (')[0]
    elif len(code) == 3:
#        if ',' in languages.get(alpha_3=code).name or '(' in languages.get(alpha_3=code).name:
#            print(languages.get(alpha_3=code).name)
        return languages.get(alpha_3=code).name.split(' (')[0]
    else:
        print('ERROR: Unsupported language code {}'.format(code))
        exit(1)

def get_desc(code):
    if code == 'classical':
        return 'classical version'
    elif code == 'comprehensive':
        return 'comprehensive version'
    elif code == 'frami':
        return 'Franz Michael version'
    elif code == 'Latn':
        return 'Latin version'
    elif code in ('med', 'MED', ):
        return 'medical version'
    elif code == 'modern':
        return 'modern version'
    elif code == 'revised':
        return 'revised version'
    elif code == 'valencia':
        return 'Valencia version'
    else:
        print('ERROR: Unsupported description code {}'.format(code))
        exit(1)

def report(output, desc, dikt_has, options, doc, option_count, all_dikts=False):
    # header
    output.write('## {} Options\n\n'.format(desc))
    difopt = 0
    for option in options:
        if option in option_count:
            difopt += 1
    if difopt == 0:
        output.write('A total of {} {} different options are recognised by Hunspell. None of these options are used'.format(
        len(options), desc.lower()))
    elif difopt == len(options):
        output.write('A total of {} {} different options are recognised by Hunspell. All of these options are used'.format(
        len(options), desc.lower()))
    elif difopt == 1:
        output.write('A total of {} {} different options are recognised by Hunspell. Of these, only 1 option is used'.format(
        len(options), desc.lower()))
    else:
        output.write('A total of {} {} different options are recognised by Hunspell. Of these, only {} different options are used'.format(
        len(options), desc.lower(), difopt))
    if len(dikt_has) == 0:
        output.write('\n\n')
    elif len(dikt_has) == 1:
        if len(dikt_has) == len(doc):
            output.write(' in all 1 dictionary.\n\n')
        else:
            output.write(' in only 1 dictionary.\n\n')
    else:
        if len(dikt_has) == len(doc):
            output.write(' in all {} dictionaries.\n\n'.format(len(dikt_has)))
        else:
            output.write(' in only {} dictionaries.\n\n'.format(len(dikt_has)))
        
    output.write('| {} vs. Dictionary'.format(desc))
    if all_dikts:
        for dikt in sorted(doc):
            output.write(' | {}'.format(dikt.replace('_', '\_')))
    else:
        for dikt in sorted(dikt_has):
            output.write(' | {}'.format(dikt.replace('_', '\_')))
    output.write(' |\n')

    # format
    output.write('|---')
    if all_dikts:
        for dikt in sorted(doc):
            output.write('|--:')
    else:
        for dikt in sorted(dikt_has):
            output.write('|--:')
    output.write('|\n')

    # content
    for option in options:
        output.write('| {}'.format(option))
        if all_dikts:
            for dikt in sorted(doc):
                oc = doc[dikt]
                if option in oc:
                    output.write(' | {}'.format(oc[option]))
                else:
                    output.write(' |')
        else:
            for dikt in sorted(dikt_has):
                oc = doc[dikt]
                if option in oc:
                    output.write(' | {}'.format(oc[option]))
                else:
                    output.write(' |')
        output.write(' |\n')
    output.write('\n\n')

# followings list are manually obtained from $ man -K 5 hunspell
options_general = ('SET', 'FLAG', 'COMPLEXPREFIXES',
                   'LANG', 'IGNORE', 'AF', 'AM', )
options_suggest = ('KEY', 'TRY', 'NOSUGGEST', 'MAXCPDSUGS', 'MAXNGRAMSUGS', 'MAXDIFF',
                   'ONLYMAXDIFF', 'NOSPLITSUGS', 'SUGSWITHDOTS', 'REP', 'MAP', 'PHONE', 'WARN', 'FORBIDWARN', )
options_compounding = ('BREAK', 'COMPOUNDRULE', 'COMPOUNDMIN', 'COMPOUNDFLAG', 'COMPOUNDBEGIN', 'COMPOUNDLAST', 'COMPOUNDMIDDLE', 'ONLYINCOMPOUND', 'COMPOUNDPERMITFLAG', 'COMPOUNDFORBIDFLAG', 'COMPOUNDMORESUFFIXES', 'COMPOUNDROOT',
                       'COMPOUNDWORDMAX', 'CHECKCOMPOUNDDUP', 'CHECKCOMPOUNDREP', 'CHECKCOMPOUNDCASE', 'CHECKCOMPOUNDTRIPLE', 'SIMPLIFIEDTRIPLE', 'CHECKCOMPOUNDPATTERN', 'FORCEUCASE', 'COMPOUNDSYLLABLE', 'SYLLABLENUM', )  # 'COMPOUND',
options_affix = ('PFX', 'SFX', 'CIRCUMFIX', 'FORBIDDENWORD', 'FULLSTRIP', 'KEEPCASE',
                 'ICONV', 'OCONV', 'NEEDAFFIX', 'SUBSTANDARD', 'WORDCHARS', 'CHECKSHARPS', )
options_deprecated = ('LEMMA_PRESENT', 'PSEUDOROOT', )

# self-check
for o in options_general:
    if o in options_suggest:
        print('ERROR: Overlap general and sugest')
        exit(1)
    if o in options_compounding:
        print('ERROR: Overlap general and compounding')
        exit(1)
    if o in options_affix:
        print('ERROR: Overlap general and affix')
        exit(1)
    if o in options_deprecated:
        print('ERROR: Overlap general and deprecated')
        exit(1)
for o in options_suggest:
    if o in options_compounding:
        print('ERROR: Overlap suggest and compounding')
        exit(1)
    if o in options_affix:
        print('ERROR: Overlap suggest and affix')
        exit(1)
    if o in options_deprecated:
        print('ERROR: Overlap sugges and deprecated')
        exit(1)
for o in options_compounding:
    if o in options_affix:
        print('ERROR: Overlap compounding and affix')
        exit(1)
    if o in options_deprecated:
        print('ERROR: Overlap compounding and deprecated')
        exit(1)
for o in options_affix:
    if o in options_deprecated:
        print('ERROR: Overlap affix and deprecated')
        exit(1)

def get_details(packs, pack):
    lang = None
    country = None
    desc = None
    name = None
    sep = None
    skip = False
    if '-' not in pack and '_' not in pack:
        sep = '/'  # This will never be a separator, here number should be 0
    elif '-' in pack and '_' not in pack:
        sep = '-'
    elif '-' not in pack and '_' in pack:
        sep = '_'
    else:
        if pack == 'ca_ES-valencia':  # FIXME
            lang = 'ca'
            country = 'ES'
            desc =  'valencia'
            name = '{} for {} ({})'.format(get_lang(lang), get_country(country), get_desc(desc))
            skip = True
        else:
            print('ERROR: Mixed separators in pack {}'.format(pack))
            exit(1)
    if not skip:
        number = pack.count(sep)
        if number == 0:
            lang = pack
            name = '{}'.format(get_lang(lang))
        elif number == 1:
            lang, country = pack.split(sep)
            if len(country) != 2:
                desc = country
                country = None
            else:
                country = country.upper()
            if country:
                name = '{} for {}'.format(get_lang(lang), get_country(country))
            else:
                name = '{} ({})'.format(get_lang(lang), get_desc(desc))
        elif number == 2:
            lang, country, desc = pack.split(sep)
            if len(country) != 2:
                tmp = country
                country = desc
                desc = tmp
            country = country.upper()
            name = '{} for {} ({})'.format(get_lang(lang), get_country(country), get_desc(desc))
        else:
            print('ERROR: Unsupported number of subdivisions in package name')
            exit(1)

    if pack not in packs:
        packs[pack] = {}
    packs[pack]['lang'] = lang
    packs[pack]['name'] = name
    if country:
        packs[pack]['country'] = country
    if desc:
        packs[pack]['desc'] = desc

def get_files(base, pack):
    dics = []
    affs = []
    base = base.format(pack)
    for filE in listdir(base):
        if not path.islink(base + filE):
            if filE.endswith('.dic'):
                dics.append(filE)
            elif filE.endswith('.aff'):
                affs.append(filE)
            else:
                print('ERROR: Unsupported file extension for {}'.format(filE))
                exit(1)
    return sorted(dics), sorted(affs)

def get_links(base, pack, filE):
    links = {}
    base = base.format(pack)
    for link in listdir(base):
        if path.islink(base + link):
            if path.realpath(base + link).split(base)[1] == filE:
                if link[:-4] in ('.dic', '.aff'):
                    print('ERROR: Link {} has unsupported extension'.format(link))
                    exit(1)
                elif link[-4:] != filE[-4:]:
                    print('ERROR: Link {} has incompatible extension for target file {}'.format(link, filE))
                    exit(1)
                else:
                    get_details(links, link[:-4])
    return links

def get_packs():
    packs = {}
    for pack in listdir('packages/'):
        get_details(packs, pack)
        base = 'packages/{}/usr/share/hunspell/'
        dics, affs = get_files(base, pack)
        if dics or affs:
            for dic in dics:
                dic_name = dic[:-4]
                if 'dics' not in packs[pack]:
                    packs[pack]['dics'] = {}
                get_details(packs[pack]['dics'], dic_name)
                links = get_links(base, pack, dic)
                if links:
                    packs[pack]['dics'][dic_name]['links'] = links
                path = base.format(pack) + dic
                dic_file = open(path, 'r')
                first = True
                count = 0
                words = 0
                try:
                    for line in dic_file:
                        line = line[:-1]
                        if first:
                            first = False
                            if dic in ('kk_KZ.dic', 'hr_HR.dic'):  #FIXME first character in file should not be \uFEFF
                                if 'error' not in packs[pack]['dics'][dic_name]:
                                    packs[pack]['dics'][dic_name]['error'] = []
                                packs[pack]['dics'][dic_name]['error'].append('First character \uFEFF')
                                words = int(line[1:].split('#')[0].split('\t')[0].strip())
                            else:
                                words = int(line.split('#')[0].split('\t')[0].strip())
                        else:
                            if line != '' and line[0] != '#':
                                if line != '::::::::::::::' and line != 'stopwords.dic':  #FIXME in ar.dic
                                    if 'error' not in packs[pack]['dics'][dic_name]:
                                        packs[pack]['dics'][dic_name]['error'] = []
                                    packs[pack]['dics'][dic_name]['error'].append('Contains header with source filename')
                                    count += 1
                except UnicodeDecodeError as ude:
                    if 'error' not in packs[pack]['dics'][dic_name]:
                        packs[pack]['dics'][dic_name]['error'] = []
                    packs[pack]['dics'][dic_name]['error'].append('Should be in UTF-8, not in ISO-8859-1')
                    dic_file = open(path, 'r', encoding='ISO-8859-1')  #FIXME File encoding should be UTF-8
                    for line in dic_file:
                        line = line[:-1]
                        if first:
                            first = False
                            words = int(line.split('#')[0].split('\t')[0].strip())
                        else:
                            if line != '' and line[0] != '#':
                                count += 1
                if words != count:
                    packs[pack]['dics'][dic_name]['error'].append('Should be in UTF-8, not in ISO-8859-1', words)
                packs[pack]['dics'][dic_name]['error'].append('Should be in UTF-8, not in ISO-8859-1', count)

            for aff in affs:
                if 'affs' not in packs[pack]:
                    packs[pack]['affs'] = {}
                get_details(packs[pack]['affs'], aff[:-4])
                links = get_links(base, pack, aff)
                if links:
                    packs[pack]['affs'][aff[:-4]]['links'] = links
    
    return packs

packs = get_packs()         
#pprint(packs)
#print(packs['sr']['affs']['sr_RS']['links']['sr_ME']['name'])

output = open('dictionary-packages.md', 'w')
output.write('# Hunspell Dictionary Packages\n\n')
output.write('This page has been generated at {}. Do not edit this page manually.\n\n'.format(datetime.now().strftime('%Y-%m-%d %H:%M:%S').replace(' ' , ' at ')))

output.write('## Packages\n\n')
output.write('The following {} dictionary packages are available for Hunspell.\n\n'.format(len(packs)))

output.write('| Package Name | Supported Language | Details |\n')
output.write('|---|---|---|\n')
for pack, value in sorted(packs.items()):
        output.write('| `hunspell-{}` | {} | [D](https://packages.debian.org/search?keywords=hunspell-{}), [U](http://packages.ubuntu.com/hunspell-{}) |\n'.format(pack, value['name'], pack, pack))

output.write('\nEach package can offer more than one dictionary or reuse a dictionary via symbolic links to serve multiple regions in the world.\n\n')
output.write('Note that the package `hunspell-fr` is a dependency package and is therefore excluded from this overview. See [Debian](https://packages.debian.org/search?keywords=hunspell-fr) or [Ubuntu](http://packages.ubuntu.com/hunspell-fr) for more details on this package.\n')

options_found = []
options_undocumented = []
option_count = {}  # option / count


pdoc = {}  # package / dictionary / option / count
options = []
exit(0)
#FIXME add package (p)
dikt_has_general = []
dikt_has_suggest = []
dikt_has_compounding = []
dikt_has_affix = []
dikt_has_deprecated = []
dikt_has_undocumented = []

for directory in listdir('dicts/'):
    for filename in listdir('dicts/' + directory + '/usr/share/hunspell/'):
        filepath = 'dicts/' + directory + '/usr/share/hunspell/' + filename
        print('XXXXX', filepath)
        if filename.endswith('.aff') and path.islink(filepath):
            print('XX', filename)
        if filename.endswith('.dic') and not path.islink(filepath):
            print('YY', filename)
        if not filename.endswith('.aff') or path.islink(filepath) or filename in ('kk_KZ.aff', ):  #FIXME kk_KZ.aff has invalid first character
            continue
        input = None
        print(filename)
        if filename in ('de_AT_frami.aff', 'de_CH_frami.aff', 'de_DE_frami.aff', 'de_DE.aff', 'en_US.aff', 'pt_BR.aff', 'sl_SI.aff', 'th_TH.aff', 'ru_RU.aff', 'nn_NO.aff', 'an_ES.aff', 'af_ZA.aff', 'el_GR.aff', 'bg_BG.aff', 'de_CH.aff', 'it_IT.aff', 'hu_HU.aff', 'pl_PL.aff', 'cs_CZ.aff', 'eu.aff', 'lt_LT.aff', 'nb_NO.aff', 'oc_FR.aff', 'bs_BA.aff', 'de_AT.aff', ):
            input = open(filepath, 'r', encoding='ISO-8859-1')
        else:
            input = open(filepath, 'r')
        dikt = filename.replace('.aff', '')
        doc[dikt] = {}
        oc = doc[dikt]
        for line in input:
            if dikt == 'kk_KZ':
                line.replace('﻿', '')
                print(line)
            line = line.strip()
            if line == '' or line.startswith('#'):
                continue
            while '  ' in line:  # TODO
                line = line.replace('  ', ' ')
            while '\t' in line:  # TODO report?
                line = line.replace('\t', ' ')
            br = line.split(' ')
            option = br[0]
    #            print(option, oc[option])
            if option not in options_found:
                options_found.append(option)
            if option in oc:
                oc[option] += 1
            else:
                oc[option] = 1
                if option in options_general:
                    if dikt not in dikt_has_general:
                        dikt_has_general.append(dikt)
                elif option in options_suggest:
                    if dikt not in dikt_has_suggest:
                        dikt_has_suggest.append(dikt)
                elif option in options_compounding:
                    if dikt not in dikt_has_compounding:
                        dikt_has_compounding.append(dikt)
                elif option in options_affix:
                    if dikt not in dikt_has_affix:
                        dikt_has_affix.append(dikt)
                elif option in options_deprecated:
                    if dikt not in dikt_has_deprecated:
                        dikt_has_deprecated.append(dikt)
                else:
                    if dikt not in dikt_has_undocumented:
                        dikt_has_undocumented.append(dikt)
                    if option not in options_undocumented:
                        options_undocumented.append(option)
            if option in option_count:
                option_count[option] += 1
            else:
                option_count[option] = 1

output = open('option-usage.md', 'w')
output.write('# Hunspell Option Usage per Dictionary\n\n')
output.write('This page has been generated at {}. Do not edit this page manually.\n\n'.format(datetime.now().strftime('%Y-%m-%d %H:%M:%S').replace(' ' , ' at ')))

print('dictionaries found', len(doc))
print('options found', len(options_found))

report(output, 'General', dikt_has_general, options_general, doc, option_count, all_dikts=True)
report(output, 'Suggest', dikt_has_suggest, options_suggest, doc, option_count)
report(output, 'Compounding', dikt_has_compounding, options_compounding, doc, option_count)
report(output, 'Affix', dikt_has_affix, options_affix, doc, option_count)
report(output, 'Deprecated', dikt_has_deprecated, options_deprecated, doc, option_count)
report(output, 'Undocumented', dikt_has_undocumented, options_undocumented, doc, option_count)
