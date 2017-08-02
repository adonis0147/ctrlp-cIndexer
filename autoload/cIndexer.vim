function! cIndexer#Index(dir)
let s:ignore_extensions = g:cIndexer_ignore_extensions + g:cIndexer_custom_ignore_extensions
let s:ignore_directories = g:cIndexer_ignore_directories + g:cIndexer_custom_ignore_directories
python << EOF
import vim
import locale
ignore_extensions = vim.eval('s:ignore_extensions')
ignore_file_pattern = r'^.+\.(%s)$' % ('|'.join(ignore_extensions))
ignore_directories = vim.eval('s:ignore_directories')
ignore_dir_pattern = r'/(%s)$' % ('|'.join(ignore_directories))
root = '/'.join(os.path.split(vim.eval('a:dir')))
encoding = locale.getdefaultlocale()[-1]
result = cIndexer.scan(root.decode('utf-8').encode(encoding), ignore_file_pattern, ignore_dir_pattern)
vim.command('let g:ctrlp_allfiles = split("%s", "\n")' % result.decode(encoding, 'ignore'))
vim.command('call add(g:ctrlp_allfiles, "")')
EOF
endfunction

