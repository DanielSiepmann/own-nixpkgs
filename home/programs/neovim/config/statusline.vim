set statusline=%h%w "Show modi, help, preview.
set statusline+=\ %f "Show file name
set statusline+=%= "Switch to right side.
set statusline+=%m "Show modification of file
set statusline+=%r "Show readonly mode of file

if exists("SyntasticStatuslineFlag")
    set statusline+=%{SyntasticStatuslineFlag()}
endif

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    
    return l:counts.total == 0 ? '' : printf(
        \   '[%dW %dE]',
        \   all_non_errors,
        \   all_errors
    \)
endfunction
if exists("ale#statusline#Count")
    set statusline+=%{LinterStatus()}
endif
set statusline+=%*
" Proceed with status line
set statusline+=%y "Show filetype
set statusline+=[%{&fileencoding?&fileencoding:&encoding}] " Show encoding
set statusline+=[%{&ff}] "Show lineendings
set statusline+=\ %c "Show current column.
set statusline+=,%4l "Show current line.
set statusline+=/%L "Show total line count.
set statusline+=\ %3p%% "Show percentage of file.
