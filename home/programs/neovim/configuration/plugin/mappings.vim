" Custom Mapping / Key bindings
let mapleader = ","

nnoremap H ^
nnoremap L $

" Toggle paste mode
nnoremap <leader>v :set paste!<cr>
" Stop highlighting of search results.
nnoremap <leader>nh :nohlsearch<cr>

" Configure navigation, e.g. go to buffer, file, ...
nnoremap <leader>pp :Telescope builtin<cr>
nnoremap <leader>pf :Telescope git_files<cr>
nnoremap <leader>pb :Telescope buffers<cr>
nnoremap <leader>pt :Telescope ctags_outline outline<cr>
nnoremap <leader>pr :Telescope custom_runs<cr>
nnoremap <silent> <leader>pc :call TelescopeCurrentComposerPackage()<cr>

nnoremap <leader>k :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeFind<cr>
nnoremap <leader>b :TagbarToggle<cr>
nnoremap <leader>u :UndotreeToggle<cr>

nnoremap <leader>a :PhpactorContextMenu<cr>
nnoremap <leader>au :PhpactorImportClass<cr>
nnoremap <leader>ag :PhpactorGotoDefinition<cr>
nnoremap <leader>ah :PhpactorHover<cr>

nnoremap <silent> <leader>tn :TestNearest<cr>
nnoremap <silent> <leader>tl :TestLast<cr>
nnoremap <silent> <leader>tf :TestFile<cr>

nnoremap <leader>so :call SortParagraph()<cr>
nnoremap <silent> <leader>gtt :call OpenPHPUnitTestFilename()<cr>

" Terminal helpers
nnoremap <silent> <leader>e :TREPLSendLine<cr>
vnoremap <silent> <leader>e :TREPLSendSelection<cr>

nmap <leader>db :python3 debugger.run()<cr>

" Escape of terminal more esily.
tnoremap <Esc> <C-\><C-n>