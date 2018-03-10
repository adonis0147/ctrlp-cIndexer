let s:plugin_path = escape(expand('<sfile>:p:h'), '\')

function! python#Init()
exec python#PythonUntilEOF()
import vim
import os
sys.path.insert(0, vim.eval('s:plugin_path'))
try:
    import cIndexer
except:
    print('Error: Module cIndexer missing!')
sys.path.pop(0)
EOF
endfunction

function! python#PythonUntilEOF()
	return python#UsePython3() ? 'python3 << EOF' : 'python << EOF'
endfunction

function! python#UsePython3()
	return has('python3')
endf
