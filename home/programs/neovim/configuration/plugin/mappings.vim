" Custom Mapping / Key bindings
let mapleader = ","

nnoremap H ^
nnoremap L $

" Stop highlighting of search results.
nnoremap <leader>nh :nohlsearch<cr>

" Configure navigation, e.g. go to buffer, file, ...
nnoremap <leader>pp :lua require('fzf-lua').builtin()<CR>
nnoremap <leader>pf :lua require('fzf-lua').git_files()<CR>
nnoremap <leader>pb :lua require('fzf-lua').buffers()<CR>
nnoremap <leader>pt :lua require('fzf-lua').btags()<CR>
nnoremap <silent> <leader>pc :call FilesInCurrentComposerPackage()<cr>

" lca = lsp code action
nnoremap <leader>lca :lua vim.lsp.buf.code_action()<cr>

nnoremap <leader>k :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeFind<cr>
nnoremap <leader>b :TagbarToggle<cr>
nnoremap <leader>u :UndotreeToggle<cr>

nnoremap <leader>am :PhpactorContextMenu<cr>
nnoremap <leader>au :PhpactorImportClass<cr>
nnoremap <leader>ag :PhpactorGotoDefinition<cr>

" Testing
nnoremap <silent> <leader>tn :TestNearest<cr>
nnoremap <silent> <leader>tl :TestLast<cr>
nnoremap <silent> <leader>tf :TestFile<cr>
" Toggle Summary
nnoremap <silent> <leader>ts :UltestSummary<cr>
nnoremap <silent> <leader>tu :Ultest<cr>

nnoremap <leader>so :call SortParagraph()<cr>
nnoremap <silent> <leader>gtt :call OpenPHPUnitTestFilename()<cr>

" Terminal helpers
nnoremap <silent> <leader>e :TREPLSendLine<cr>
vnoremap <silent> <leader>e :TREPLSendSelection<cr>

nmap <leader>db :python3 debugger.run()<cr>

" Escape of terminal more esily.
tnoremap <Esc> <C-\><C-n>
