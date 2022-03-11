let g:ale_set_quickfix = 0
let g:ale_set_loclist = 1
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_echo_cursor = 1
let g:ale_virtualtext_cursor = 1
let g:ale_cursor_detail = 0
let g:ale_virtualtext_prefix = "! "

" Does not work with 3.0.0 and newer, due to:
"   nvim/bundle/ale/autoload/ale/linter.vim
"   for l:linter in reverse(l:possibly_duplicated_linters)
"       if index(l:name_list, l:linter.name) < 0
"           call add(l:name_list, l:linter.name)
"           call add(l:combined_linters, l:linter)
"       endif
"   endfor
" let g:ale_pattern_options = {
"     \ '\.tsconfig$': {
"         \ 'ale_enabled': 0
"     \ },
"     \ '\.typoscript$': {
"         \ 'ale_enabled': 0
"     \ }
" \ }

function! DSConfigurePhpStan()
    let g:ale_php_phpstan_executable = 'vendor/bin/phpstan'
endfunction
call DSConfigurePhpStan()

" Do not lint when open a file
let g:ale_lint_on_enter = 0
" Do not lint when chaning file type
let g:ale_lint_on_filetype_changed = 0

" Do not interrupt writing to much, wait longer for start linting.
let g:ale_lint_delay = 1000
" Turn auto linting while writing off
let g:ale_lint_on_text_changed = 'never'

" Configure signs to use
let g:ale_sign_error = '>'
let g:ale_sign_warning = '!'
" let g:ale_sign_info = '-'
" let g:ale_sign_style_error = '>'
" let g:ale_sign_style_warning = '!'

let g:ale_php_phpcs_standard = 'PSR12'

let g:ale_languagetool_executable = 'languagetool-commandline'
