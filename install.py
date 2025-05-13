#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import glob
import shutil

path = os.environ.get("PATH").replace(os.environ.get("HOME") + '/.rye/shims', '')
os.system('PATH=%s cd cIndexer && python3 setup.py build' % path)

extensions = ['*.so', '*.pyd', '*.dll']
path = './cIndexer/build/*'

for extension in extensions:
    for file in glob.glob('%s/%s' % (path, extension)):
        shutil.copy(file, './autoload')
        os.remove(file)

