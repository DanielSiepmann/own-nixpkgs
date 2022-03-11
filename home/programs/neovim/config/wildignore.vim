" NOTE: Also keep grepping.vim in sync for CtrlP

" Ignore some files and folders
set wildignore+=tags.bak

" Version and other general unimportant files.
set wildignore+=*.rej
set wildignore+=*.orig
set wildignore+=*.resolve
set wildignore+=*.swp

" Docs
set wildignore+=*/compiledDocs*

" Python
set wildignore+=*.pyc
set wildignore+=*.egg*
set wildignore+=*/venv*

" Ruby on Rails
set wildignore+=*/tmp

" Node.js
set wildignore+=*/node_modules
set wildignore+=*/bower_components

" Python Projects
set wildignore+=*/venv
set wildignore+=*/__pycache__

" PHP Projects
set wildignore+=composer.lock

" PHP Codeception
set wildignore+=*/_output

" TYPO3 doc render result
set wildignore+=*/Documentation-GENERATED-temp

" Not possible in TYPO3 installations
" set wildignore+=Web
" set wildignore+=bin
set wildignore+=**/*.bat

" TYPO3
" set wildignore+=*/typo3
" set wildignore+=*/typo3_src
set wildignore+=*/_migrated
set wildignore+=*/_processed_
set wildignore+=*/_temp_
" set wildignore+=*/fileadmin
set wildignore+=*/fileadmin/images
set wildignore+=*/fileadmin/mediapool
set wildignore+=*/fileadmin/user_upload
set wildignore+=*/typo3conf/l10n
set wildignore+=*/typo3temp
set wildignore+=*/var
set wildignore+=*/uploads

" Symfony
set wildignore+=*/app/cache
set wildignore+=*__CG__*
