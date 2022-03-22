augroup sacFolder
    autocmd!
    autocmd BufEnter **/sac/**/Configuration/**/*.typoscript :setlocal tabstop=2 shiftwidth=2
    autocmd BufEnter **/sac/**/*.xlf :setlocal noexpandtab
augroup END

