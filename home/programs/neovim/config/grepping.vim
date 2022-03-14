" Switch vim to use fastes possible tool for grepping

" Use ack over grep
if executable('ack')
    set grepprg=ack\ --nogroup\ --nocolor
    command! -nargs=+ Ag execute 'silent grep! <args>' | copen | redraw!
endif
