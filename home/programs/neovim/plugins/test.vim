let g:test#strategy = 'neoterm'

" configure additional options per test kind.
" e.g. add --debug for nearest to get additional information during
" development of the test.
let g:test#php#codeception#options = {
    \ 'nearest': '--env local --html --debug',
    \ 'file': '--env local --html --debug',
\}

let g:test#php#codeception#options = {
    \ 'nearest': '--env production --debug',
    \ 'file': '--env production --debug',
\}

let g:test#php#phpunit#options = {
    \ 'nearest': '--testdox',
    \ 'file': '--testdox',
\}

if !exists('g:test#php#codeception#suite')
  let g:test#php#codeception#suite = 'acceptance'
endif
