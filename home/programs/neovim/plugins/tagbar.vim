" Remove quick help etc.
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['+', '-']
" Slows down rendering and is not that helpfull most of the time.
" let g:tagbar_autopreview = 1

let g:tagbar_type_php  = {
    \ 'ctagstype' : 'php',
    \ 'sort' : 0,
    \ 'kinds'   : [
        \ 'n:namespaces:1',
        \ 'i:interfaces:1',
        \ 't:traits:1',
        \ 'c:classes:1',
        \ 'd:constantDefinitions:1',
        \ 'f:functions:0',
    \ ]
\ }

" Show headlines within markdown files
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'c:chapters:0',
        \ 's:sections:0',
        \ 'S:level 2 Sections:0',
        \ 't:level 3 Section:0',
        \ 'T:level 4 Sections:0',
    \ ],
    \ 'sort' : 0,
\ }

let g:tagbar_type_fluid = {
    \ 'ctagstype' : 'html',
    \ 'kinds' : [
        \ 's:sections:0',
        \ 'i:ids:1',
    \ ],
    \ 'sort' : 0,
\ }

let g:tagbar_type_snippets = {
    \ 'ctagstype' : 'snippets',
    \ 'kinds' : [
        \ 's:snippets:1',
    \ ],
    \ 'sort' : 0,
\ }

" Provided by yats bundle
let g:tagbar_type_typescript = {
    \ 'ctagstype' : 'typescript',
    \ 'kinds' : [
        \ 'i:interfaces:0',
        \ 'e:enums:0',
        \ 'c:classes:0',
        \ 'm:members:0',
        \ 'f:functions:0',
        \ 'v:variables:0',
        \ 'd:describe:0',
        \ 's:test:0',
        \ 'o:test todo:0',
    \ ],
    \ 'sort' : 0,
\ }

let g:tagbar_type_apache = {
    \ 'ctagstype' : 'apache',
    \ 'kinds' : [
        \ 's:servers:0',
    \ ],
    \ 'sort' : 0,
\ }

" Configure xliff translation files
let g:tagbar_type_xml = {
    \ 'ctagstype' : 'xml',
    \ 'kinds' : [
        \ 'c:comments:0',
        \ 'i:ids:1',
    \ ],
    \ 'sort' : 0,
\ }

" Show outline of rst files
let g:tagbar_type_rst = {
    \ 'ctagstype': 'reStructuredText',
    \ 'kinds' : [
        \ 'c:chapters:0',
    \ ],
    \ 'sort': 0,
    \ }

" SOURCE: https://github.com/mtscout6/vim-tagbar-css/blob/master/plugin/tagbar-css.vim
let g:tagbar_type_css = {
\  'ctagstype' : 'css',
\  'kinds' : [
\    'v:variables',
\    'c:classes',
\    'i:IDs',
\    't:tags',
\    'm:medias',
\    'k:comments',
\  ]
\}

" E.g. gitlab yaml
let g:tagbar_type_yaml = {
    \ 'ctagstype': 'yaml',
    \ 'kinds' : [
        \'t:toplevel',
    \]
\}

let g:tagbar_type_go = {
    \ 'ctagstype': 'go',
    \ 'kinds' : [
        \'p:package',
        \'f:function',
        \'v:variables',
        \'t:type',
        \'c:const'
    \]
\}
