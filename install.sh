#!/bin/bash

root=`pwd`

cd ./cIndexer
python setup.py build

target=`find . | grep cIndexer.so`
mv $target ../plugin

cd ~/.vim/bundle/ctrlp.vim/
git apply $root/ctrlp.patch
