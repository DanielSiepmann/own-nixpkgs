augroup sacFolder
    autocmd!
    autocmd BufEnter **/sac/**/Configuration/**/*.typoscript :setlocal tabstop=2 shiftwidth=2
    autocmd BufEnter **/sac/**/*.xlf :setlocal noexpandtab
    autocmd BufEnter **/sac/**/.git/COMMIT_EDITMSG let b:ale_gitcommit_gitlint_options = '-c T7.regex="\[.*\] \w+-\d+ .*"'
augroup END

