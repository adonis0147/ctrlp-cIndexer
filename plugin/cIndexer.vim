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

let g:cIndexer_ignore_directories = [
	\ '\.git', '\.hg', '\.svn',
	\ ]

if !exists('g:cIndexer_custom_ignore_extensions')
	let g:cIndexer_custom_ignore_extensions = []
endif

if !exists('g:cIndexer_custom_ignore_directories')
	let g:cIndexer_custom_ignore_directories = []
endif

function! s:Init()
	call python#Init()
endfunction

call s:Init()

