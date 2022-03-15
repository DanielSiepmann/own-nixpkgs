let g:ctrlp_follow_symlinks = 2
" Default to regex mode
let g:ctrlp_regexp = 1
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:10'
" let g:ctrlp_open_new_file = '0'
" let g:ctrlp_lazy_update = 1
let g:ctrlp_show_hidden = 1

let g:ctrlp_types = ['fil', 'buf', 'buftag']

let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_max_files = 0
let g:ctrlp_clear_cache_on_exit = 0

" Configure completion for tags in buffer,
" e.g. configure which kinds to complete for css.
let g:ctrlp_buftag_types = {
  \ 'css' : '--css-types=vcit',
  \ 'typescript' : '--typescript-types=cnfvmitesod',
  \ 'xml' : '--xml-types=ci',
  \ 'rst' : '--reStructuredText-types=csSt',
  \ 'markdown' : '--Markdown-types=csStT',
  \ 'fluid' : '--xml-types=si',
  \ 'apache' : '--apache-types=s',
  \ 'yaml' : '--yaml-types=t',
\ }
