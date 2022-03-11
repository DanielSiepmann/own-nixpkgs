" Configure when to check
let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0

" Configure how to check
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_enable_signs = 1
let g:syntastic_stl_format = "[E:%F %t]"

" Checkers
let g:syntastic_mode_map={ 'mode': 'active' }

let g:syntastic_filetype_map = { 'json': 'javascript' }

let g:syntastic_javascript_checkers = ["jshint"]
let g:syntastic_typoscript_checkers = ["lint"]
let g:syntastic_yaml_checkers = ["yamllint"]
let g:syntastic_json_checkers = ["jshint"]
let g:syntastic_python_checkers = ["python","pep8"]
let g:syntastic_php_checkers = ["php", "phpcs", "phpstan", "phpmd"]
" Temporarily disable xmllint, as it is really slow
" let g:syntastic_xml_checkers = []

" let g:syntastic_yaml_yamllint_exec = 'python3 -m yamllint'
let g:syntastic_html_tidy_exec = 'tidy5'

let g:syntastic_php_phpstan_args = '--level=max'
let g:syntastic_php_phpcs_args = '--standard=PSR12'
let g:syntastic_php_phpmd_post_args='cleancode,codesize,controversial,design,naming,unusedcode'

" let g:syntastic_typoscript_lint_exec='~/Projects/opensource/typo3-typoscript-lint/typoscript-lint'
" let g:syntastic_typoscript_lint_post_args='-c ./tslint.yaml'

" let g:syntastic_yaml_yamllint_args = '-c ~/.dotfiles/yamllint.yaml'

" Activate debugging:
let g:syntastic_debug = 0
