setlocal commentstring=//\ %s

" Activate spell chechking in php files, within php
set spell spelllang=en
syn spell toplevel
" Deactivate spell checking for now
set nospell

setlocal omnifunc=v:lua.vim.lsp.omnifunc
