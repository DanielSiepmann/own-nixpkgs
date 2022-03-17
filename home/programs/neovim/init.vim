set background=dark
set t_Co=256
colorscheme smyckblue

set timeoutlen=1000
set ttimeoutlen=1000

set nonumber
set cursorline

set foldcolumn=0
set foldmethod=indent
set foldlevelstart=1

set laststatus=2
" Don't jump to first line, e.g. on buffer switch
set nostartofline
" Extend completion using spelling if enabled for buffer.
set complete+=kspell
set completeopt=menu,menuone

" Allow syntax highlighting and other file / language specific things
syntax enable
" Activate filetype detection and auto indent
filetype plugin indent on

" Show command in bottom of the screen
set showcmd
set showmode
" More useful command-line completion
set wildmenu
" Auto-completion menu
set wildmode=longest,list:full

" Adjust splitting
set splitbelow
set splitright

" Disable wrap of line
set nowrap
" Test line for wrapping: This should be a very long line with many characters and words so I can test whether this Line get's wrapped or not and how other settings like sidescroll are applied.
set sidescrolloff=5
" Show current line in middle of screen
set scrolloff=1000

" Custom highlighting
" Highlight whitespace at end of line as error
" match Error /\s\+$/
match Todo /TODO\|NOTE\|todo\|TASK/
match ERROR /♥/
" match ERROR /!.*!/
