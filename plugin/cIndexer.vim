let s:plugin_path = escape(expand('<sfile>:p:h'), '\')

python << EOF
import vim
import sys
import os
sys.path.insert(0, os.path.abspath(vim.eval('s:plugin_path')))
import cIndexer
sys.path.pop(0)
EOF

let g:cIndexer_ignore_extensions = [
    \ 'o', 'obj', 'lib', 'so', 'dll', 'exe',
    \ 'pyc', 'pyd',
    \ 'class',
    \ 'fla', 'swf',
    \ 'bmp', 'png', 'jpg', 'gif',
    \ 'tga', 'ktx', 'pvr', 'dds',
    \ 'mp3', 'wma', 'avi', 'wmv', 'mp4', 'mkv',
    \ 'zip', 'rar', 'tar\.gz', 'tgz',
    \ 'doc', 'docx', 'ppt', 'pptx', 'xls', 'xlsx',
    \ 'bak', 'swp',
    \ ]

if !exists('g:cIndexer_custom_ignore_extensions')
    let g:cIndexer_custom_ignore_extensions = []
endif

