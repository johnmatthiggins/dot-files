#!/usr/bin/env python3

import os
from os import path
import subprocess as sp

BLACKLIST = [
    'install.py',
    '.gitignore',
    'README.md'
]

def main():
    print('[\033[32mINFO\033[0m] STARTING INSTALLATION...')

    home_dir = os.getenv('HOME')
    cwd = os.getcwd()

    files = [f for f in os.listdir() if path.isfile(f) and not ignore(f)]
    home_paths = [path.join(home_dir, f) for f in files]
    sources = [path.join(cwd, f) for f in files]

    for i in range(0, len(files)):
        link(sources[i], home_paths[i])

    print('[\033[32mINFO\033[0m] COMPLETED INSTALLATION!')


def ignore(file_name):
    return file_name in BLACKLIST


# create a symlink.
def link(source, destination):
    proc = sp.run(args=['ln', '-s', source, destination], stdout=sp.PIPE, stderr=sp.PIPE)

    if proc.returncode == 0:
        print('[\033[32mINFO\033[0m] LINKED \'%s\' -> \'%s\'' %(source, destination))
    else:
        print('[\033[31mERROR\033[0m] FAILED TO LINK \'%s\' -> \'%s\'' %(source, destination))



if __name__ == '__main__':
    main()
