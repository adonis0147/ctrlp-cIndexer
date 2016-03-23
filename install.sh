#!/bin/bash

root=`pwd`

cd ./cIndexer
python setup.py build

target=`find . | grep -P 'cIndexer.(so|dll|pyd)'`
mv $target ../plugin

cd $root/../ctrlp.vim/
git apply $root/ctrlp.patch

