#!/usr/bin/env python3

'''
PROGRAM: Configuration Installer
DESCRIPTION: Installs dot files when creating a fresh Linux install.
AUTHOR: John Higgins
'''

import sys
import os
from os import path
import subprocess as sp

BLACKLIST = [
    'install.py',
    '.gitignore',
    'README.md'
]

def main():
    logger = Logger()
    logger.log(Logger.INFO_LEVEL, 'STARTING INSTALLATION...')
    force = sys.argv[1] == '--force' or sys.argv[1] == '-f'

    home_dir = os.getenv('HOME')
    cwd = os.getcwd()

    files = [f for f in os.listdir() if path.isfile(f) and not ignore(f)]
    home_paths = [path.join(home_dir, f) for f in files]
    sources = [path.join(cwd, f) for f in files]

    for i in range(0, len(files)):
        link(sources[i], home_paths[i], force)

    logger.log(Logger.INFO_LEVEL, 'COMPLETED INSTALLATION!')


def ignore(file_name):
    return file_name in BLACKLIST or not file_name.index('.') == 0


# create a symlink.
def link(source, destination, force=False):
    logger = Logger()
    proc = None

    if force:
        proc = sp.run(args=['ln', '-sf', source, destination], stdout=sp.PIPE, stderr=sp.PIPE)
    else:
        proc = sp.run(args=['ln', '-s', source, destination], stdout=sp.PIPE, stderr=sp.PIPE)

    if proc.returncode == 0:
        logger.log(Logger.INFO_LEVEL, 'LINKED \'%s\' → \'%s\'' %(source, destination))
    else:
        logger.log(Logger.ERROR_LEVEL, 'FAILED TO LINK \'%s\' → \'%s\'' %(source, destination))


class Logger:
    INFO_LEVEL = 0
    WARN_LEVEL = 1
    ERROR_LEVEL = 2

    def __init__(self):
        pass

    
    def log(self, level, msg):
        print('%s ' %(self.level_ansi(level)), end='')
        print(msg)
        self.reset_color()


    def reset_color(self):
        return '\033[0m'


    # Configure color based on logging level.
    def level_ansi(self, level):
        if level == Logger.INFO_LEVEL:
            return f'[\033[32mINFO{self.reset_color()}]'
        elif level == Logger.WARN_LEVEL:
            return f'[\033[33mWARN{self.reset_color()}]'
        else:
            return f'[\033[31mERROR{self.reset_color()}]'


if __name__ == '__main__':
    main()
