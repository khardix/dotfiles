#!/usr/bin/env python3
"""
    dotfiles.urldispatch
    ~~~~~~~~~~~~~~~~~~~~

    Simple script for launching an application for specific URLs.

    Based on <https://github.com/LukeSmithxyz/voidrice/blob/master/.scripts/linkhandler>.

    :copyright: (c) 2018 by Khardix.
"""

import re
import subprocess
import sys
from collections import ChainMap
from functools import partial
from os import environ, path
from urllib.parse import urlparse

sh = partial(subprocess.run, shell=True, stdout=subprocess.PIPE, encoding='utf-8')
ex = partial(subprocess.Popen, shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


#: The program to use if no match is found
FALLBACK = environ.get('BROWSER', 'firefox')
#: Image viewer for displaying images
IMAGE = 'feh'
#: Video playback
VIDEO = 'mpv --really-quiet --x11-name=urlplayer'
#: Video playback on loop
VIDEO_LOOP = ' '.join((VIDEO, '--loop'))
#: Console text/html
TEXT = 'w3m -o auto_image=TRUE'
#: Download to HDD
DOWNLOAD = f'wget -P {sh("xdg-user-dir DOWNLOAD").stdout.strip()}'

#: Selection of program based on file extension
DISPATCH_EXT = ChainMap(
    dict.fromkeys('jpg png jpeg'.split(), IMAGE),
    dict.fromkeys('gif'.split(), VIDEO_LOOP),
    dict.fromkeys('webm mp4 mkv'.split(), VIDEO),
    dict.fromkeys('pdf flac mp3 opus'.split(), DOWNLOAD),
)

#: Selection of program based on website
DISPATCH_SITE = ChainMap(
    dict.fromkeys('youtube.com youtu.be'.split(), VIDEO),
)


def site(full_site_name: str) -> str:
    return full_site_name.lstrip('w.')


def ext(filename: str) -> str:
    return path.splitext(filename)[-1].lstrip('.')


def main(url: str):
    url = urlparse(url)
    handler = (DISPATCH_SITE.get(site(url.netloc))
               or DISPATCH_EXT.get(ext(url.path))
               or FALLBACK)
    return ex(f'{handler} {url.geturl()} & disown')


if __name__ == '__main__':
    main(sys.argv[1] if len(sys.argv) > 1 else sys.stdin.readline())
