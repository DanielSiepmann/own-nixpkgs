let g:neoterm_default_mod = 'botright'

" Source: https://github.com/kassio/neoterm/issues/81
" Allow rerun of last terminal command.
let g:my_last_t_command = ''
function! MyT(args)
    let g:my_last_t_command = a:args
    silent call neoterm#do(g:my_last_t_command)
endfunction

command! -bar -complete=shellcmd -nargs=+ T silent call MyT(<q-args>)
command! -bar ReT silent call MyT(g:my_last_t_command)
