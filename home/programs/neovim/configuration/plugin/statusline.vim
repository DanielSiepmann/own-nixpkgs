set statusline=%h%w "Show modi, help, preview.
set statusline+=\ %f "Show file name
set statusline+=%= "Switch to right side.
set statusline+=%m "Show modification of file
set statusline+=%r "Show readonly mode of file
set statusline+=%*
set statusline+=%y "Show filetype
set statusline+=[%{&fileencoding?&fileencoding:&encoding}] " Show encoding
set statusline+=[%{&ff}] "Show lineendings
set statusline+=\ %c "Show current column.
set statusline+=,%4l "Show current line.
set statusline+=/%L "Show total line count.
set statusline+=\ %3p%% "Show percentage of file.
