augroup gitdiff
    autocmd!
    " Mark buffers as not modifiable, to make diffput work
    autocmd BufReadPost *_REMOTE_*,*_LOCAL_*,*_BASE_* setlocal nomodifiable
augroup END
