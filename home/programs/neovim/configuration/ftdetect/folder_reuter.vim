augroup reuterFolder
    autocmd!
    autocmd BufEnter **/emoto2/**/Unit/** execute "call ReuterSetupPhpUnitUnit()"
    autocmd BufEnter **/emoto2/**/Functional/** execute "call ReuterSetupPhpUnitFunctional()"
    autocmd BufEnter **/emoto2/**/.git/COMMIT_EDITMSG let b:ale_gitcommit_gitlint_options = '-c general.contrib=contrib-title-conventional-commits'

    autocmd BufEnter **/microservices/cms/**/*.js :setlocal tabstop=2 shiftwidth=2

    autocmd BufEnter **/reuter/**/Unit/** execute "call ReuterSetupPhpUnitUnit()"
    autocmd BufEnter **/reuter/**/Functional/** execute "call ReuterSetupPhpUnitFunctional()"
    autocmd BufEnter **/reuter/**/.git/COMMIT_EDITMSG let b:ale_gitcommit_gitlint_options = '-c general.contrib=contrib-title-conventional-commits'
augroup END

" As long as we use older phpunit which does not provider proper testdox output
function! ReuterSetupPhpUnitUnit()
    let g:test#php#phpunit#options = {
        \ 'file': '--testdox --colors',
        \ 'nearest': '--testdox --colors',
    \}
endfunction

function! ReuterSetupPhpUnitFunctional()
    let g:test#php#phpunit#options = {
        \ 'file': '--stop-on-error --stop-on-failure --testdox --colors',
        \ 'nearest': '--testdox --colors',
    \}

endfunction
