if !exists('g:vdebug_options')
    let g:vdebug_options = {}
endif

" Connection infos
" Wait 1 minute for connection
let g:vdebug_options.timeout = 60
let g:vdebug_options.continuous_mode = 1
let g:vdebug_options.ide_key = "vim"
let g:vdebug_options.server = "127.0.0.1"
let g:vdebug_options.port = 9000
" Plugin options
let g:vdebug_options.break_on_open = 0
let g:vdebug_options.watch_window_style = "compact"
" Do not use fancy icons
let g:vdebug_options.marker_default = '*'
let g:vdebug_options.marker_closed_tree = '+'
let g:vdebug_options.marker_open_tree = '-'

" As I don't like to switch FN
let g:vdebug_keymap = {
    \    "run" : "<Leader>5",
    \    "step_over" : "<Leader>2",
    \    "step_into" : "<Leader>3",
    \    "step_out" : "<Leader>4",
    \    "close" : "<Leader>6",
    \    "eval_visual" : "",
\}

" https://github.com/vim-vdebug/vdebug/issues/369
" let g:vdebug_features = {'extended_properties': 1}
