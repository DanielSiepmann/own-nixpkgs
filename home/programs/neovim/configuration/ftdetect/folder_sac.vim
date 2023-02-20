augroup sacFolder
    autocmd!
    autocmd BufEnter **/sac/**/Configuration/**/*.typoscript :setlocal tabstop=2 shiftwidth=2
    autocmd BufEnter **/sac/**/*.xlf :setlocal noexpandtab
    autocmd BufEnter **/sac/**/.git/COMMIT_EDITMSG let b:ale_gitcommit_gitlint_options = '-c T7.regex="\[.*\] \w+-\d+ .*"'
    autocmd BufEnter **/sac/**/Unit/** execute "call SacSetupPhpUnitUnit()"
    autocmd BufEnter **/sac/**/Functional/** execute "call SacSetupPhpUnitFunctional()"
augroup END

function! SacSetupPhpUnitUnit()
    let g:test#php#phpunit#options = {
        \ 'file': '--configuration phpunit.unit.xml.dist --testdox --colors',
        \ 'nearest': '--configuration phpunit.unit.xml.dist --testdox --colors',
    \}
endfunction

function! SacSetupPhpUnitFunctional()
    let g:test#php#phpunit#options = {
        \ 'file': '--configuration phpunit.functional.xml.dist --testdox --colors',
        \ 'nearest': '--configuration phpunit.functional.xml.dist --testdox --colors',
    \}
endfunction
