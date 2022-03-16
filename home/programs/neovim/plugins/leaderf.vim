let g:Lf_WorkingDirectoryMode = 'c'

let g:Lf_FollowLinks = 1
let g:Lf_ShowHidden = 1

let g:Lf_WindowPosition = 'popup'
let g:Lf_HideHelp = 1

let g:Lf_GtagsAutoUpdate = 0

let g:Lf_IgnoreCurrentBufferName = 1

let g:Lf_ShowDevIcons = 0

let g:Lf_PreviewInPopup = 0
let g:Lf_PreviewCode = 0

" TODO: Try to port to existing colorscheme, does it work with load order?
let g:Lf_PopupPalette = {
    \  'dark': {
    \   'Lf_hl_popup_inputText': {
    \       'cterm': 'none',
    \       'ctermfg': 'blue',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_window': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_blank': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_cursor': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_prompt': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_spin': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_normalMode': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_inputMode': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_category': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_nameOnlyMode': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_fullPathMode': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_fuzzyMode': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_regexMode': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_cwd': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_lineInfo': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_popup_total': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_cursorline': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': '235',
    \   },
    \   'Lf_hl_selection': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_match0': {
    \       'cterm': 'none',
    \       'ctermfg': 'blue',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_match1': {
    \       'cterm': 'none',
    \       'ctermfg': 'blue',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_match2': {
    \       'cterm': 'none',
    \       'ctermfg': 'blue',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_match3': {
    \       'cterm': 'none',
    \       'ctermfg': 'blue',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_match4': {
    \       'cterm': 'none',
    \       'ctermfg': 'blue',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_match': {
    \       'cterm': 'none',
    \       'ctermfg': 'blue',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_lineLocation': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_previewTitle': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_winNumber': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_winIndicators': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_winModified': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_winNomodifiable': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_winDirname': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_quickfixFileName': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_quickfixLineNumber': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_quickfixColumnNumber': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_loclistFileName': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_loclistLineNumber': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \   'Lf_hl_loclistColumnNumber': {
    \       'cterm': 'none',
    \       'ctermfg': 'none',
    \       'ctermbg': 'none',
    \   },
    \  }
    \ }
