" Function to test a specific URL.
" Will output the response + response headers for the given URL.
function! TestUrl(url)
    execute ":!wget -q -O - --no-check-certificate --server-response '" . a:url . "'"
endfunction

" Copy the current file name to clipboard
function! CopyFileName()
    execute ':let @+ = expand("%:t")'
endfunction

" Copy the current relative file path to clipboard
function! CopyRelativeFilePath()
    execute ':let @+ = expand("%")'
endfunction

" Copy the current full file path to clipboard
function! CopyFullFilePath()
    execute ':let @+ = expand("%:p")'
endfunction

" Remove trailing whitespace
function! StripTrailingWhitespace()
    execute ':%s/\s\+$//e'
endfunction

function! RemoveEmptyLines()
    execute ':g/^\s*$/d'
endfunction

function! ReplaceLineBreaks()
    execute ':%s//\r/g'
endfunction

function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! StartDebugging()
    call DebuggingConfiguration()
    VdebugStart
endfunc

function! HiColors()
    let num = 255
    while num >= 0
        exec 'hi col_'.num.' ctermbg='.num.' ctermfg=white'
        exec 'syn match col_'.num.' "ctermbg='.num.':...." containedIn=ALL'
        call append(0, 'ctermbg='.num.':....')
        let num = num - 1
    endwhile
endfunction

" Author: http://vimrcfu.com/snippet/116
function! Reg()
    reg
    echo "Register: "
    let char = nr2char(getchar())
    if char != "\<Esc>"
        execute "normal! \"".char."p"
    endif
    redraw
endfunction

function! SortParagraph()
    execute ":normal! vip:'<,'>sort\<esc>"
endfunction

" Generate .. _: anchor for headline. Cursor have to be on line with headline.
function! SphinxAnchor()
    normal yyOPI.. _lguuA:V:s/ /-/gllr jj
endfunction

function! OpenUrl()
    if !exists('b:url')
        let b:commandToOpen = exists('b:commandToOpen') ? b:commandToOpen : 'open'
        let b:domain = exists('b:domain') ? b:domain : 'http://phptraining.local'
        let b:documentRoot = exists('b:documentRoot') ? b:documentRoot : getcwd()
        let b:path = exists('b:path') ? b:path : expand("%:p")
        let b:url = substitute(b:path, b:documentRoot, b:domain, "")
    endif

    silent! execute "!" . b:commandToOpen . " " . b:url
endfunction
nnoremap <leader>t :call OpenUrl()<cr>

function! ConvertToTestFilename()
    let l:string = @r
    let l:testName = system('php /home/daniels/Projects/company/emoto2/reuterTypo3/htdocs/test.php "' . l:string . '"')
    execute(':normal i' . l:testName)
endfunction

function! OpenPHPUnitTestFilename()
    let l:fileExtension = expand('%:e')
    let l:filePath = expand('%:r:s?Classes?Tests/Unit?')
    execute(':vsplit ' . l:filePath . 'Test.' . l:fileExtension)
    execute(':normal ]]')
endfunction

function! StartProfiling()
    execute(':profile start profile.log')
    execute(':profile func *')
    execute(':profile file *')
endfunc

function! TelescopeCurrentComposerPackage()
    let l:filePath = split(expand('%:p:h'), '/')

    while !filereadable('/' . join(l:filePath + ['composer.json'], '/')) && len(l:filePath)
        let l:filePath = l:filePath[:-2]
    endwhile

    if len(l:filePath)
        execute(':Telescope find_files cwd=/' . join(l:filePath, '/'))
    else
        echom 'No composer package detected.'
    endif
endfunc

function! Present()
    :StartPresenting
    :Goyo
    set nospell
    " hi! EndOfBuffer ctermfg=#242424
endfunction

command! -nargs=0 Reg call Reg()
