#!/bin/bash

root=`pwd`

cd ./cIndexer
python setup.py build

target=`find . | grep -E 'cIndexer\.(so|dll|pyd)'`
mv $target ../autoload

cd $root/../ctrlp.vim/
git apply $root/ctrlp.patch

