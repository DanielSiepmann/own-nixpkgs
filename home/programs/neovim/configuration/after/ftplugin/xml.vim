" Activate spell chechking in xml files, within tags only
set spell spelllang=en
syn spell toplevel
" Disable spell chacking in attributes
syn region  xmlString contained start=+"+ end=+"+ contains=xmlEntity,@NoSpell display
syn region  xmlString contained start=+'+ end=+'+ contains=xmlEntity,@NoSpell display

augroup xliff
    autocmd!
    " xsd is installed via home manager
    autocmd BufEnter **/*.xlf :let g:ale_xml_xmllint_options = '-schema ~/.local/share/xsd/xliff-core-1.2-strict.xsd'
augroup END
