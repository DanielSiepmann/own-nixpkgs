" Custom Mapping / Key bindings
let mapleader = ","

nnoremap H ^
nnoremap L $

" Toggle paste mode
nnoremap <leader>v :set paste!<cr>
" Stop highlighting of search results.
nnoremap <leader>nh :nohlsearch<cr>

" Configure navigation, e.g. go to buffer, file, ...
nnoremap <leader>pp :lua require('telescope.builtin').builtin({ include_extensions = true })<cr>
nnoremap <leader>pf :Telescope git_files<cr>
nnoremap <leader>pb :Telescope buffers<cr>
nnoremap <leader>pt :Telescope ctags_outline outline<cr>
nnoremap <leader>pr :Telescope custom_runs<cr>
nnoremap <silent> <leader>pc :call TelescopeCurrentComposerPackage()<cr>

" lca = lsp code action
nnoremap <leader>lca :lua vim.lsp.buf.code_action()<cr>

nnoremap <leader>k :NvimTreeToggle<cr>
nnoremap <leader>f :NvimTreeFindFile<cr>
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
