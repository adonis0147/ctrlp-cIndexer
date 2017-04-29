#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import glob
import shutil

os.system('cd cIndexer && python setup.py install')

extensions = ['*.so', '*.pyd', '*.dll']
path = './cIndexer/build/*'

for extension in extensions:
    for file in glob.glob('%s/%s' % (path, extension)):
        shutil.copy(file, './autoload')
        os.remove(file)

