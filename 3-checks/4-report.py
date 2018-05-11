#!/usr/bin/env python3

from glob import glob
from os.path import isdir, isfile

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

            # write confusion matrix
            #TODO