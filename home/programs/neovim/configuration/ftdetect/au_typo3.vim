augroup typo3
    autocmd!
    " Clear some caches depending on files saved. Only works if cwd is document root
    autocmd BufWritePost **/sites/**/*.yaml :silent !rm */**/cache/**/sites-configuration.php
    autocmd BufWritePost **/local_packages/**/Sites/**/*.yaml :silent !rm */**/cache/**/sites-configuration.php
    autocmd BufWritePost **/Configuration/RequestMiddlewares.php :silent !rm */**/cache/**/middlewares_*
    autocmd BufWritePost **/Configuration/Backend/Routes.php :silent !rm */**/cache/**/BackendRoutesFromPackages_*
    autocmd BufWritePost **/Configuration/Services.yaml,**/Configuration/Services/*.yaml,**/Configuration/Services.php :silent !rm */**/cache/**/DependencyInjectionContainer_*

    " Extbase
    " Performance issues for extbase, keep an eye
    " autocmd BufWritePost **/Classes/**/*.php :silent !rm -rf */**/cache*/**/extbase/*
    autocmd BufWritePost **/Configuration/Extbase/Persistence/Classes.php :silent !rm */**/cache*/**/extbase/PersistenceClasses_*

    autocmd BufWritePost **/ext_tables.php :silent !rm */**/cache*/**/ext_tables_*
    autocmd BufWritePost **/ext_localconf.php :silent !rm */**/cache*/**/ext_localconf_*
    autocmd BufWritePost **/Configuration/TCA/** :silent !rm */**/cache*/**/tca_base_*
    autocmd BufWritePost **/*.xlf :silent !rm */**/cache/**/l10n/*
    autocmd BufWritePost **/*.yml,**/*.yaml :silent !rm */**/cache/**/yamlsettings_form*
    " Performance issues for typoscript, keep an eye
    " Disable for now as cache flushing is slow.
    " One can reload without browser cache in order to get changes applied.
    " autocmd BufWritePost *.tsconfig,*.typoscript,*.ts,*/TypoScript/*.ts,*/TypoScript/*.txt :silent !rm -rf */**/var/**/pages/*
    " autocmd BufWritePost *.tsconfig,*.typoscript,*.ts,*/TypoScript/*.ts,*/TypoScript/*.txt :silent !rm -rf */**/var/**/pagesection/*
    " autocmd BufWritePost *.tsconfig,*.typoscript,*.ts,*/TypoScript/*.ts,*/TypoScript/*.txt :silent !rm -rf */**/var/**/cache_pages/*
    " autocmd BufWritePost *.tsconfig,*.typoscript,*.ts,*/TypoScript/*.ts,*/TypoScript/*.txt :silent !rm -rf */**/var/**/cache_pagesection/*

    " ext:news
    autocmd BufWritePost **/Classes/Domain/Model/News.php :silent !rm -rf */**/var/cache/code/news/*

    " Also update ftdetect/typoscript.vim for detection of Typoscript
    " autocmd BufWritePost *.tsconfig,*.typoscript,*.ts,*/TypoScript/*.ts,*/TypoScript/*.txt :redraw!

    " Fix draw issue after potential error message in tmux environment
    " => Should fix output instead of forcing redraw, just workaround.
    " autocmd BufWritePost **/*.xlf,**/*.yml,**/*.yaml,**/ext_localconf.php,**/ext_tables.php,**/TCA/**,**/*.php :redraw!

    autocmd BufEnter,BufRead **/de.*.xlf :setlocal spelllang=de
augroup END
