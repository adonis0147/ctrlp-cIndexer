from distutils.core import setup, Extension

module = Extension('cIndexer', sources = ['cIndexer.cc'],
                   extra_compile_args = ['--std=c++11'])

setup(name = 'cIndexer',
      version = '0.1',
      description = 'Indexer for ctrlp',
      ext_modules = [module])

