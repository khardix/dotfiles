#!/usr/bin/python
# -*- coding: utf-8 -*-

"""Custom hooks for alot."""


import os
import subprocess


SCRIPT_DIR = os.path.dirname(os.path.realname(__file__))


def pre_global_exit(**kwargs):
    """Clean gmail on exit"""

    subprocess.call(['sh', SCRIPT_DIR+'/scripts/clean-gmail-inbox.sh'])
