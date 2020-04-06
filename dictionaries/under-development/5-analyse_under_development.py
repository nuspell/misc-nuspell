#!/usr/bin/env python3

# Content of option-usage.md is to be copy-pasted into the following wiki page
# https://github.com/hunspell/hunspell/wiki/Option-Usage

from pprint import pprint
from os import listdir, path
from datetime import datetime
from pycountry import countries, languages
from logging import basicConfig, debug, DEBUG, info, INFO, warning, WARNING, error, ERROR


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
        error('Unsupported description code {}'.format(code))
        exit(1)

def report(output, desc, dikt_has, options, doc, option_count):
    # header
    output.write('## {} Options\n\n'.format(desc))
    difopt = 0
    for option in options:
        if option in option_count:
            difopt += 1
    if difopt == 0:
        output.write('A total of {} different {} options are recognized by Hunspell. None of these options are used'.format(
        len(options), desc.lower()))
    elif difopt == len(options):
        output.write('A total of {} different {} options are recognized by Hunspell. All of these options are used'.format(
        len(options), desc.lower()))
    elif difopt == 1:
        output.write('A total of {} different {} options are recognized by Hunspell. Of these, only 1 option is used'.format(
        len(options), desc.lower()))
    else:
        output.write('A total of {} different {} options are recognized by Hunspell. Of these, only {} different options are used'.format(
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
            output.write(' in all {} dictionaries combined.\n\n'.format(len(dikt_has)))
        else:
            output.write(' in only {} dictionaries combined.\n\n'.format(len(dikt_has)))
        
    output.write('| {} vs. Dictionary'.format(desc))
    for dikt in sorted(dikt_has):
        if dikt.startswith('fr@'):
            output.write(' | `{}`'.format(dikt))
        else:
            output.write(' | `{}`'.format(dikt.split('@')[0]))
    output.write(' |\n')

    # format
    output.write('|---')
    for dikt in sorted(dikt_has):
        output.write('|--:')
    output.write('|\n')

    # content
    unused_options = []
    options_used_by_all = []
    for option in options:
        output.write('| `{}`'.format(option))
        unused_option = True
        option_used_by_all = True
        for dikt in sorted(dikt_has):
            oc = doc[dikt]
            if option in oc:
                unused_option = False
                output.write(' | `{}`'.format(oc[option]))
            else:
                option_used_by_all = False
                output.write(' |')
        output.write(' |\n')
        if unused_option:
            unused_options.append(option)
        if option_used_by_all:
            options_used_by_all.append(option)
    output.write('\n\n')

    if options_used_by_all:
        if len(options_used_by_all) == 1:
            output.write('{} option that was used in all of the dictionaries above is: '.format(desc))
        else:
            output.write('{} options that were used in all of the dictionaries above are: '.format(desc))
        first = True
        for option in options_used_by_all:
            if first:
                output.write('`{}`'.format(option))
                first = False
            else:
                output.write(', `{}`'.format(option))
        output.write('.\n\n')
    if unused_options:
        if len(unused_options) == 1:
            output.write('{} option that was used in none of the dictionaries above is: '.format(desc))
        else:
            output.write('{} options that were used in none of the dictionaries above are: '.format(desc))
        first = True
        for option in unused_options:
            if first:
                output.write('`{}`'.format(option))
                first = False
            else:
                output.write(', `{}`'.format(option))
        output.write('.\n\n')

# followings list are manually obtained from $ man -K 5 hunspell
options_general = ('SET',
                   'FLAG',
                   'COMPLEXPREFIXES',
                   'LANG',
                   'IGNORE',
                   'AF',
                   'AM', )
options_suggest = ('KEY',
                   'TRY',
                   'NOSUGGEST',
                   'MAXCPDSUGS',
                   'MAXNGRAMSUGS',
                   'MAXDIFF',
                   'ONLYMAXDIFF',
                   'NOSPLITSUGS',
                   'SUGSWITHDOTS',
                   'REP',
                   'MAP',
                   'PHONE',
                   'WARN',
                   'FORBIDWARN', )
options_compounding = ('BREAK',
                       'COMPOUNDRULE',
                       'COMPOUNDMIN',
                       'COMPOUNDFLAG',
                       'COMPOUNDBEGIN',
                       'COMPOUNDLAST',
                       'COMPOUNDMIDDLE',
                       'ONLYINCOMPOUND',
                       'COMPOUNDPERMITFLAG',
                       'COMPOUNDFORBIDFLAG',
                       'COMPOUNDMORESUFFIXES',
                       'COMPOUNDROOT',
                       'COMPOUNDWORDMAX',
                       'CHECKCOMPOUNDDUP',
                       'CHECKCOMPOUNDREP',
                       'CHECKCOMPOUNDCASE',
                       'CHECKCOMPOUNDTRIPLE',
                       'SIMPLIFIEDTRIPLE',
                       'CHECKCOMPOUNDPATTERN',
                       'FORCEUCASE',
                       'COMPOUNDSYLLABLE',
                       'SYLLABLENUM', )
options_affix = ('PFX',
                 'SFX', )
options_other = ('CIRCUMFIX',
                 'FORBIDDENWORD',
                 'FULLSTRIP',
                 'KEEPCASE',
                 'ICONV',
                 'OCONV',
                 'NEEDAFFIX',
                 'SUBSTANDARD',
                 'WORDCHARS',
                 'CHECKSHARPS', )
options_undocumented = ('VERSION',
                 'CHECKNUM',
                 'NONGRAMSUGGEST', )
options_deprecated = ('LEMMA_PRESENT',
                      'PSEUDOROOT', )

# self-check
for option in options_general:
    if option in options_suggest:
        error('Overlap general and suggest')
        exit(1)
    if option in options_compounding:
        error('Overlap general and compounding')
        exit(1)
    if option in options_affix:
        error('Overlap general and affix')
        exit(1)
    if option in options_other:
        error('Overlap general and other')
        exit(1)
    if option in options_deprecated:
        error('Overlap general and deprecated')
        exit(1)
    if option in options_undocumented:
        error('Overlap general and undocumented')
        exit(1)
for option in options_suggest:
    if option in options_compounding:
        error('Overlap suggest and compounding')
        exit(1)
    if option in options_affix:
        error('Overlap suggest and affix')
        exit(1)
    if option in options_affix:
        error('Overlap suggest and other')
        exit(1)
    if option in options_deprecated:
        error('Overlap suggest and deprecated')
        exit(1)
    if option in options_undocumented:
        error('Overlap suggest and undocumented')
        exit(1)
for option in options_compounding:
    if option in options_affix:
        error('Overlap compounding and affix')
        exit(1)
    if option in options_other:
        error('Overlap compounding and other')
        exit(1)
    if option in options_deprecated:
        error('Overlap compounding and deprecated')
        exit(1)
    if option in options_undocumented:
        error('Overlap compounding and undocumented')
        exit(1)
for option in options_affix:
    if option in options_other:
        error('Overlap affix and other')
        exit(1)
    if option in options_deprecated:
        error('Overlap affix and deprecated')
        exit(1)
    if option in options_undocumented:
        error('Overlap affix and undocumented')
        exit(1)
for option in options_other:
    if option in options_deprecated:
        error('Overlap other and deprecated')
        exit(1)
    if option in options_undocumented:
        error('Overlap other and undocumented')
        exit(1)
for option in options_deprecated:
    if option in options_undocumented:
        error('Overlap deprecated and undocumented')
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
            error('Mixed separators in pack {}'.format(pack))
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
            error('Unsupported number of subdivisions in package name')
            exit(1)

    if pack in packs:
        error('Trying to add duplicate pack {} to packs {}'.format(pack, packs))
        exit(1)
    else:
        packs[pack] = {}
    packs[pack]['lang'] = lang
    packs[pack]['name'] = name
    if country:
        packs[pack]['country'] = country
    if desc:
        packs[pack]['desc'] = desc

def get_files(base, pack, vers):
    dics = []
    affs = []
    base = base.format(pack, vers)
    for filE in sorted(listdir(base)):
        if not path.islink(base + filE):
            if filE.endswith('.dic'):
                dics.append(filE)
            elif filE.endswith('.aff'):
                affs.append(filE)
            else:
                error('Unsupported file extension for {}'.format(filE))
                exit(1)
    return sorted(dics), sorted(affs)

def get_links(base, pack, vers, filE):
    links = {}
    base = base.format(pack, vers)
    for link in sorted(listdir(base)):
        if path.islink(base + link):
            if path.realpath(base + link).split(base)[1] == filE:
                if link[:-4] in ('.dic', '.aff'):
                    error('Link {} has unsupported extension'.format(link))
                    exit(1)
                elif link[-4:] != filE[-4:]:
                    error('Link {} has incompatible extension for target file {}'.format(link, filE))
                    exit(1)
                else:
                    get_details(links, link[:-4])
    return links

def get_packs():
    packs = {}
    for pack in sorted(listdir('packages/')):
        info('Analyzing package hunspell-{}'.format(pack))
        get_details(packs, pack)
        for vers in listdir('packages/{}'.format(pack)):
            if 'vers' in packs[pack]:
                debug('  vers {} already in packs {}, while trying to add vers {}'.format(packs[pack]['vers'], pack, vers))
            else:
                packs[pack]['vers'] = vers
            debug('  package details {}'.format(packs[pack]))
            base = 'packages/{}/{}/usr/share/hunspell/'
            dics, affs = get_files(base, pack, vers)
            if dics or affs:
                for dic in dics:
                    debug('  dic {}'.format(dic))
                    dic_name = dic[:-4]
                    if 'dics' in packs[pack]:
                        debug('    dic {} already in packs {}'.format(dic, pack))
                    else:
                        packs[pack]['dics'] = {}
                    get_details(packs[pack]['dics'], dic_name)
                    links = get_links(base, pack, vers, dic)
                    if links:
                        packs[pack]['dics'][dic_name]['links'] = links
                    path = base.format(pack, vers) + dic
                    dic_file = open(path)
                    first = True
                    count = 0
                    entries = 0
                    try:
                        for line in dic_file:
                            line = line[:-1]
                            #TODO find . -type f -name '*.dic' -exec head -n 4 {} \;|more
                            if first:
                                first = False
                                if dic in ('kk_KZ.dic', 'hr_HR.dic'):  #FIXME first character in file should not be \uFEFF
                                    if 'error' not in packs[pack]['dics'][dic_name]:
                                        packs[pack]['dics'][dic_name]['error'] = []
                                    packs[pack]['dics'][dic_name]['error'].append('First character \uFEFF')
                                    entries = int(line[1:].split('#')[0].split('\t')[0].strip())
                                else:
                                    entries = int(line.split('#')[0].split('\t')[0].strip())
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
                        dic_file = open(path, encoding='ISO-8859-1')  #FIXME File encoding should be UTF-8
                        for line in dic_file:
                            line = line[:-1]
                            if first:
                                first = False
                                entries = int(line.split('#')[0].split('\t')[0].strip())
                            else:
                                if line != '' and line[0] != '#':
                                    count += 1
                    if entries != count:
                        packs[pack]['dics'][dic_name]['error'].append('Should be in UTF-8, not in ISO-8859-1')#, entries
                    packs[pack]['dics'][dic_name]['error'].append('Should be in UTF-8, not in ISO-8859-1')#, count\
                    packs[pack]['dics'][dic_name]['entries'] = entries
                    packs[pack]['dics'][dic_name]['count'] = count
    
                for aff in affs:
                    debug('  aff {}'.format(aff))
                    if 'affs' in packs[pack]:
                        debug('    aff {} already in packs {}'.format(aff, pack))
                    else:
                        packs[pack]['affs'] = {}
                    get_details(packs[pack]['affs'], aff[:-4])
                    links = get_links(base, pack, vers, aff)
                    if links:
                        packs[pack]['affs'][aff[:-4]]['links'] = links
    
    return packs

#basicConfig(level=DEBUG)
basicConfig(level=INFO)
packs = get_packs()         
#pprint(packs)
#print(packs['sr']['affs']['sr_RS']['links']['sr_ME']['name'])

output = open('Dictionary-Packages.md', 'w')
output.write('This page has been generated on {} by `misc-hunspell/1-support/3-analyse.py`. Do not edit this page manually. See also Dictionaries-and-Contacts.md and Affix-file-analysis-of-publicly-available-dictionaries.md\n\n'.format(datetime.now().strftime('%Y-%m-%d %H:%M:%S').replace(' ' , ' at ')))

output.write('## Packages\n\n')
output.write('The following {} dictionary packages are available for Hunspell.\n\n'.format(len(packs)))

output.write('| Package Name | Supported Language | Details |\n')
output.write('|---|---|---|\n')
for pack, value in sorted(packs.items()):
        output.write('| `hunspell-{}` | {} | [D](https://packages.debian.org/search?keywords=hunspell-{}), [U](http://packages.ubuntu.com/hunspell-{}) |\n'.format(pack, value['name'], pack, pack))

output.write('\nA dictionary package can offer more than one dictionary. For example, the package `hunspell-no` (Norwegian) offers two different dictionaries. It contains `nb_NO` for Bokmål language and `nn_NO` for the Nynorsk lanaguage.\n\n')

output.write('It happens too that a dictionary package reuses a dictionary via symbolic links to serve multiple regions in the world that use exactly the same language. The package `hunspell-fr-revised` (French) offers a package for French langauge in general called `fr`. But it also offers under `fr_FR`, `fr_LU` and `fr_MC` literally the same dictionary for the countries of France, Luxembourgh and Monaco respectively.\n\n')

output.write('Large dictionaries which vary per region are often packages separately to save disk usage. Examples of these are `hunspell-de-de` for the German language in Germany, `hunspell-de-at` for the German language in Austria and `hunspell-de-ch` for the German language in Switzerland.\n\n')

output.write('Note that the package `hunspell-fr` is a dependency package and is therefore excluded from this overview. See [Debian](https://packages.debian.org/search?keywords=hunspell-fr) or [Ubuntu](http://packages.ubuntu.com/hunspell-fr) for more details on this package.\n')



options_found = []
option_count = {}  # option / count

doc = {}  # dictionary @ package / option / count
options = []

dikt_has_general = []
dikt_has_suggest = []
dikt_has_compounding = []
dikt_has_affix = []
dikt_has_other = []
dikt_has_deprecated = []
dikt_has_undocumented = []

for pack in sorted(packs):
    debug(pack)
#    pprint(packs[pack])
#    exit(0)
    if 'affs' not in packs[pack]:
        continue
    for basename in sorted(packs[pack]['affs']):#listdir('packages/' + pack + '/{}/usr/share/hunspell/'.format(packs[pack]['vers']))):
        filepath = 'packages/{}/{}/usr/share/hunspell/{}.aff'.format(pack, packs[pack]['vers'], basename)
        debug('filepath ' + filepath)
#        if filename.endswith('.aff') and path.islink(filepath):
#            print('aff link ' + filename)
#        if filename.endswith('.dic') and not path.islink(filepath):
#            print('dic nolink ' + filename)
#        if not filename.endswith('.aff') or path.islink(filepath) or filename in ('kk_KZ.aff', ):  #FIXME kk_KZ.aff has invalid first character
#            continue
        if basename in ('kk_KZ', ):  #FIXME kk_KZ.aff has invalid first character
            continue
        input = None
#        info('filename ' + filename)
        if basename in ('de_AT_frami', 'de_CH_frami', 'de_DE_frami', 'de_DE', 'en_US', 'pt_BR', 'sl_SI', 'th_TH', 'ru_RU', 'nn_NO', 'an_ES', 'af_ZA', 'el_GR', 'bg_BG', 'de_CH', 'it_IT', 'hu_HU', 'pl_PL', 'cs_CZ', 'eu', 'lt_LT', 'nb_NO', 'oc_FR', 'bs_BA', 'de_AT', ):
            input = open(filepath, encoding='ISO-8859-1')
            #TODO error!
        else:
            input = open(filepath)
        dikt = '{}@{}'.format(basename, pack)#filename.replace('.aff', '')
        info('Analyzing affix file {}'.format(filepath))
        if dikt in doc:
            error('dic already in doc')
            exit(1)
        doc[dikt] = {}
        for line in input:
#            if dikt == 'kk_KZ':
#                line.replace('﻿', '')
#                print(line)
            line = line.strip()
            if line == '' or line.startswith('#'):
                continue
            while '  ' in line:  # TODO
                line = line.replace('  ', ' ')
            while '\t' in line:  # TODO report?
                line = line.replace('\t', ' ')
            br = line.split(' ')
            option = br[0]
            if option not in options_found:
                options_found.append(option)
            if option in option_count:
                option_count[option] += 1
            else:
                option_count[option] = 1
            if option in doc[dikt]:
                doc[dikt][option] += 1
            else:
                doc[dikt][option] = 1
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
                elif option in options_other:
                    if dikt not in dikt_has_other:
                        dikt_has_other.append(dikt)
                elif option in options_deprecated:
                    if dikt not in dikt_has_deprecated:
                        dikt_has_deprecated.append(dikt)
                elif option in options_undocumented:
                    if dikt not in dikt_has_undocumented:
                        dikt_has_undocumented.append(dikt)
                    if option not in options_undocumented:
                        options_undocumented.append(option)

output = open('Affix-file-analysis-of-publicly-available-dictionaries.md', 'w')
output.write('This page has been generated on {} by `misc-hunspell/1-support/3-analyse.py`. Do not edit this page manually. See also Dictionaries-and-Contacts.md and Dictionary-Packages.md.\n\n'.format(datetime.now().strftime('%Y-%m-%d %H:%M:%S').replace(' ' , ' at ')))

output.write('## Overview\n\n')
output.write('In total {} dictionaries were analyzed. To be precise: '.format(len(doc)))
first = True
for dikt in sorted(doc):
    if not dikt.startswith('fr@'):
        dikt = dikt.split('@')[0] 
    if first:
        output.write('`{}`'.format(dikt))
        first = False
    else:
        output.write(', `{}`'.format(dikt))
output.write('. These used a total of {} different Hunspell options.\n\n'.format(len(options_found)))

report(output, 'General', dikt_has_general, options_general, doc, option_count)
report(output, 'Suggest', dikt_has_suggest, options_suggest, doc, option_count)
report(output, 'Compounding', dikt_has_compounding, options_compounding, doc, option_count)
report(output, 'Affix', dikt_has_affix, options_affix, doc, option_count)
report(output, 'Other', dikt_has_other, options_other, doc, option_count)
report(output, 'Deprecated', dikt_has_deprecated, options_deprecated, doc, option_count)
report(output, 'Undocumented', dikt_has_undocumented, options_undocumented, doc, option_count)
