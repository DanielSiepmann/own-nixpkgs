" Switch vim to use fastes possible tool for grepping

" Use ack over grep
if executable('ack')
    set grepprg=ack\ --nogroup\ --nocolor
    command! -nargs=+ Ag execute 'silent grep! <args>' | copen | redraw!
endif

" Use ag over ack. The Silver Searcher
if executable('ag')
    " Use ag over grep and ack
    set grepprg=ag\ --vimgrep\ --ignore\ tags
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    " -U ignores .gitignore and such
    " The command to use, can be used to build g:ctrlp_user_command dynamic,
    " see configs/folderspecific/sphinx.vim
    let g:dsiepmann_user_command = 'ag %s -l --nocolor -U -f -g ""'
    " TODO: Improve auto ignore, e.g. on wildignore?
    "       See: :h variables
    "       See: :h :for

    " Also show hidden files and folders
    let g:dsiepmann_user_command = g:dsiepmann_user_command . " --hidden"

    let g:dsiepmann_user_command = g:dsiepmann_user_command . " --ignore \".git\""

    " Node
    let g:dsiepmann_user_command = g:dsiepmann_user_command . " --ignore \"node_modules\""

    " PHPUnit reports
    let g:dsiepmann_user_command = g:dsiepmann_user_command . " --ignore \"report\""
    " Codeception
    let g:dsiepmann_user_command = g:dsiepmann_user_command . " --ignore \"_output\""

    " TYPO3 doc render result
    let g:dsiepmann_user_command = g:dsiepmann_user_command . " --ignore \"Documentation-GENERATED-temp\""

    " TYPO3
    let g:dsiepmann_user_command = g:dsiepmann_user_command . " --ignore \"typo3temp\""
    let g:dsiepmann_user_command = g:dsiepmann_user_command . " --ignore \"/var\""

    " TYPO3 - clients (emoto2_
    let g:dsiepmann_user_command = g:dsiepmann_user_command . " --ignore \"typo3conf/ext/e2_*\""
    let g:dsiepmann_user_command = g:dsiepmann_user_command . " --ignore \"typo3export\""

    let g:dsiepmann_user_command = g:dsiepmann_user_command . " --ignore \"app/cache\""
    let g:dsiepmann_user_command = g:dsiepmann_user_command . " --ignore \"compiledDocs\""
    let g:dsiepmann_user_command = g:dsiepmann_user_command . " --ignore \"Data\""

    let g:ctrlp_user_command = g:dsiepmann_user_command
    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
    " Disable "intelegent" working path mode, instead use vim one.
    " This way you can search the whole project, even if you are inside a
    " composer subpackage
    let g:ctrlp_working_path_mode = ''
    command! -nargs=+ Ag execute 'silent grep! <args>' | copen | redraw!
endif
