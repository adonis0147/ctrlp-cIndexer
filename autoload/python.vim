let s:plugin_path = escape(expand('<sfile>:p:h'), '\')

function! python#Init()
python << EOF
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

