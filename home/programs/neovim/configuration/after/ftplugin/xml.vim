" Activate spell chechking in xml files, within tags only
set spell spelllang=en
syn spell toplevel
" Disable spell chacking in attributes
syn region  xmlString contained start=+"+ end=+"+ contains=xmlEntity,@NoSpell display
syn region  xmlString contained start=+'+ end=+'+ contains=xmlEntity,@NoSpell display

" TODO: Find a way to distribute the files
" augroup xliff
"     autocmd!
"     autocmd BufEnter **/*.xlf :let g:syntastic_xml_xmllint_args = '-schema ~/.dotfiles/xsd/xliff-core-1.2-strict.xsd'
"     autocmd BufEnter **/*.xlf :let g:ale_xml_xmllint_options = '-schema ~/.dotfiles/xsd/xliff-core-1.2-strict.xsd'
" augroup END
