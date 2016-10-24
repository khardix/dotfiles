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


def relative(path: str) -> str:
    """Make path relative to script dir."""

    mydir = os.path.dirname(os.path.realpath(__file__))

    return os.path.join(mydir, path)


if __name__ == '__main__':

    templates = [
        map(relative, ('alot/config.template', 'alot/config')),
        map(relative, ('notmuch-config.template', 'notmuch-config'))
    ]

    for template, expanded in templates:
        make_local(template, expanded)
