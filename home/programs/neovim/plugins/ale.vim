let g:ale_set_quickfix = 0
let g:ale_set_loclist = 1
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_sign_column_always = 1
let g:ale_echo_cursor = 0
let g:ale_hover_cursor = 0
let g:ale_cursor_detail = 0
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = "! "

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

let g:ale_php_phpcs_standard = 'PSR12'

let g:ale_php_phpstan_executable = 'vendor/bin/phpstan'
