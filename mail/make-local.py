#!/usr/bin/python3

"""Make certain configs localized (use local environment variables)"""

import os
import re


ENVVAR = re.compile('\$\{(?P<varname>\w+)\}')


def expand_env_vars(input: str) -> str:
    """Expands environment variables (defined by ENVVAR) in input."""

    return re.sub(ENVVAR, lambda m: os.environ[m.group('varname')], input)


def make_local(infile: str, outfile: str) -> None:
    """Modify a file."""

    with open(infile, mode='r') as instream, open(outfile, mode='w') as outstream:
        for line in instream:
            print(expand_env_vars(line), file=outstream, end='')


if __name__ == '__main__':
    mydir = os.path.dirname(os.path.realpath(__file__))

    make_local(mydir+'/alot/config.template', mydir+'/alot/config')
