import sys
from setuptools import setup, Extension

if sys.platform != 'win32':
    extra_compile_args = ['--std=c++11', '-Wno-write-strings']
else:
    extra_compile_args = []

module = Extension('cIndexer', sources=['cIndexer.cc'],
                   extra_compile_args=extra_compile_args)

setup(name='cIndexer',
      version='0.1',
      description='Indexer for ctrlp',
      ext_modules=[module])

