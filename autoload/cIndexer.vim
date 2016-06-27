function! cIndexer#Index(dir)
let s:ignore_extensions = g:cIndexer_ignore_extensions + g:cIndexer_custom_ignore_extensions
python << EOF
import vim
import locale
ignore_extensions = vim.eval('s:ignore_extensions')
ignore_pattern = r'^.+\.(%s)$' % ('|'.join(ignore_extensions))
root = vim.eval('a:dir')
result = cIndexer.scan(root, ignore_pattern)
encoding = locale.getdefaultlocale()[-1]
vim.command('let g:ctrlp_allfiles = split("%s")' % result.decode(encoding))
EOF
endfunction
