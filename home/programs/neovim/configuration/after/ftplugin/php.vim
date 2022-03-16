setlocal commentstring=//\ %s

" Activate spell chechking in php files, within php
set spell spelllang=en
syn spell toplevel
" Deactivate spell checking for now
set nospell

if exists('&omnifunc') && exists('g:loaded_phpactor')
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
endif

