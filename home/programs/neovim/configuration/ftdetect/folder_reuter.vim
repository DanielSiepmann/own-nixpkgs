augroup reuterFolder
    autocmd!
    autocmd BufEnter **/emoto2/**/Unit/** execute "call ReuterSetupPhpUnitUnit()"
    autocmd BufEnter **/emoto2/**/Functional/** execute "call ReuterSetupPhpUnitFunctional()"
    autocmd BufEnter **/microservices/cms/**/*.js :setlocal tabstop=2 shiftwidth=2
    autocmd BufEnter **/emoto2/**/.git/COMMIT_EDITMSG let b:ale_gitcommit_gitlint_options = '-c general.contrib=contrib-title-conventional-commits'
augroup END

" As long as we use older phpunit which does not provider proper testdox output
function! ReuterSetupPhpUnitUnit()
    let g:test#php#phpunit#options = {
        \ 'file': '',
        \ 'nearest': '',
    \}
endfunction

function! ReuterSetupPhpUnitFunctional()

    " TYPO3 v8
    let g:test#php#phpunit#options = {
        \ 'file': '-c phpunit.functional.xml.dist --stop-on-error --stop-on-failure',
        \ 'nearest': '-c phpunit.functional.xml.dist',
    \}

    " TYPO3 v10
    let g:test#php#phpunit#options = {
        \ 'file': '--stop-on-error --stop-on-failure --testdox',
        \ 'nearest': '--testdox',
    \}

endfunction
