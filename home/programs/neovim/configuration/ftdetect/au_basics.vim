augroup general
    autocmd!
    " What does this do?! Were does it come from?
    " autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " Delete fugitive buffer on leave
    autocmd BufReadPost fugitive://* set bufhidden=delete

    " To prevent ui from switching back and forth, always activate gutter
    " Doesn't seem to work anymore, not too important
    " sign define dummy
    " autocmd BufEnter *.* :execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

    " Remove whitespace at end of line
    autocmd BufWritePre,BufRead *.xlf,*.xml,*.html,*.php,*.js,*.css,*.scss,*.vim,*.vimrc :call StripTrailingWhitespace()

    " I'm working to much on foreign code, so do not retab on read or prior write anymore
    " autocmd BufWritePre,BufRead *.xlf,*.xml,*.html,*.php,*.js,*.css,*.scss,*.vim,*.vimrc :retab!

augroup END
