augroup fesFolder
    autocmd!
    autocmd BufEnter **/fes-de/** let g:ale_php_phpstan_executable = 'bin/phpstan'
augroup END
