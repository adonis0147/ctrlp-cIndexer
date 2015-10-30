function! cIndexer#Index(dir)
let s:ignore_extensions = g:cIndexer_ignore_extensions + g:cIndexer_custom_ignore_extensions
python << EOF
import vim
ignore_extensions = vim.eval('s:ignore_extensions')
ignore_pattern = r'^.+\.(%s)$' % ('|'.join(ignore_extensions))
root = vim.eval('a:dir')
files = cIndexer.scan(root, ignore_pattern)
vim.command('let g:ctrlp_allfiles = %s' % files)
EOF
endfunction

