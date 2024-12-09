" default values for each global variable
" NOTE default value of airline_wintabs_patcher#separator is 2 spaces
let s:defaults = {
    \ 'airline_wintabs_patcher#active_tab_style': 'airline_a',
    \ 'airline_wintabs_patcher#display_mode': 2,
    \ 'airline_wintabs_patcher#post_active_tabs_style': 'airline_c',
    \ 'airline_wintabs_patcher#pre_active_tabs_style': 'airline_c',
    \ 'airline_wintabs_patcher#separator': '  ',
\ }

let s:display_modes = [
    \ [],
    \ ['active_tab'],
    \ ['pre_active_tabs', 'active_tab', 'post_active_tabs'],
\ ]



" initialize global variables, if they do not already exist
function! airline_wintabs_patcher#globals#init()
    " the style for the active tab section
    " must be formatted as a vim-airline-themes-ez-patcher section entry
    " if a section `airline_active_tab` already exists in g:airline_themes_ez_patcher#palette,
    " this value will NOT overwrite it and will be ignored
    let g:airline_wintabs_patcher#active_tab_style = get(g:, 'airline_wintabs_patcher#active_tab_style', s:defaults['airline_wintabs_patcher#active_tab_style'])

    " which of the sections to display
    " 0: no display
    " 1: display active tab only
    " 2: display all tabs
    " if more control over the layout is required, you can directly manipulate
    " g:airline_themes_ez_patcher#layout or g:airline#extensions#default#layout
    " if any of 'pre_active_tabs', 'active_tab', or 'post_active_tabs' is present in
    " g:airline_themes_ez_patcher#layout or g:airline#extensions#default#layout,
    " this value will NOT overwrite the layout and will be ignored
    let g:airline_wintabs_patcher#display_mode = get(g:, 'airline_wintabs_patcher#display_mode', s:defaults['airline_wintabs_patcher#display_mode'])

    " the style for the inactive tabs section after the active tab
    " must be formatted as a vim-airline-themes-ez-patcher section entry
    " if a section `airline_post_active_tabs_style` already exists in g:airline_themes_ez_patcher#palette,
    " this value will NOT overwrite it and will be ignored
    let g:airline_wintabs_patcher#post_active_tabs_style = get(g:, 'airline_wintabs_patcher#post_active_tabs_style', s:defaults['airline_wintabs_patcher#post_active_tabs_style'])

    " the style for the inactive tabs section before the active tab
    " must be formatted as a vim-airline-themes-ez-patcher section entry
    " if a section `airline_pre_active_tabs_style` already exists in g:airline_themes_ez_patcher#palette,
    " this value will NOT overwrite it and will be ignored
    let g:airline_wintabs_patcher#pre_active_tabs_style = get(g:, 'airline_wintabs_patcher#pre_active_tabs_style', s:defaults['airline_wintabs_patcher#pre_active_tabs_style'])

    " the characters separating two tabs in the same section
    " for example, if the first tab is selected, the second and third tabs
    " are in the post_active_tabs section; this would be between '2' and '3'
    " 2 characters are suggested to maintain spacing (there are two spaces
    " between different sections, so including two spaces between tabs in the
    " same section keeps the total size of all sections consistent no matter
    " which tab is selected)
    let g:airline_wintabs_patcher#separator = get(g:, 'airline_wintabs_patcher#separator', s:defaults['airline_wintabs_patcher#separator'])

    " add sections to g:airline according to g:airline_wintabs_patcher#display_mode,
    " if no entries for 'pre_active_tabs', 'active_tab', and/or 'post_active_tabs'
    " already exist in either g:airline_themes_ez_patcher#layout or g:airline#extensions#default#layout
    let l:pre_active_tabs_laid_out = index(g:airline_themes_ez_patcher#layout, 'pre_active_tabs') >= 0
        \ || index(g:airline#extensions#default#layout[0], 'pre_active_tabs') >= 0
        \ || index(g:airline#extensions#default#layout[1], 'pre_active_tabs') >= 0
    let l:active_tab_laid_out = index(g:airline_themes_ez_patcher#layout, 'active_tab') >= 0
        \ || index(g:airline#extensions#default#layout[0], 'active_tab') >= 0
        \ || index(g:airline#extensions#default#layout[1], 'active_tab') >= 0
    let l:post_active_tabs_laid_out = index(g:airline_themes_ez_patcher#layout, 'post_active_tabs') >= 0
        \ || index(g:airline#extensions#default#layout[0], 'post_active_tabs') >= 0
        \ || index(g:airline#extensions#default#layout[1], 'post_active_tabs') >= 0
    if !l:pre_active_tabs_laid_out && !l:active_tab_laid_out && !l:post_active_tabs_laid_out
        call extend(g:airline_themes_ez_patcher#layout, s:display_modes[g:airline_wintabs_patcher#display_mode])
        let l:pre_active_tabs_laid_out = index(g:airline_themes_ez_patcher#layout, 'pre_active_tabs') >= 0
        let l:active_tab_laid_out = index(g:airline_themes_ez_patcher#layout, 'active_tab') >= 0
        let l:post_active_tabs_laid_out = index(g:airline_themes_ez_patcher#layout, 'post_active_tabs') >= 0
    endif

    " add g:airline_wintabs_patcher#pre_active_tabs_style to g:airline_themes_ez_patcher#palette,
    " if an entry for 'airline_pre_active_tabs' does not already exist, and 'pre_active_tabs' is laid out
    if !has_key(g:airline_themes_ez_patcher#palette, 'airline_pre_active_tabs') && l:pre_active_tabs_laid_out
        let g:airline_themes_ez_patcher#palette['airline_pre_active_tabs'] = g:airline_wintabs_patcher#pre_active_tabs_style
    endif

    " add g:airline_wintabs_patcher#active_tab_style to g:airline_themes_ez_patcher#palette,
    " if an entry for 'airline_active_tab' does not already exist, and 'active_tab' is laid out
    if !has_key(g:airline_themes_ez_patcher#palette, 'airline_active_tab') && l:active_tab_laid_out
        let g:airline_themes_ez_patcher#palette['airline_active_tab'] = g:airline_wintabs_patcher#active_tab_style
    endif

    " add g:airline_wintabs_patcher#post_active_tabs_style to g:airline_themes_ez_patcher#palette,
    " if an entry for 'airline_post_active_tabs' does not already exist, and 'post_active_tabs' is laid out
    if !has_key(g:airline_themes_ez_patcher#palette, 'airline_post_active_tabs') && l:post_active_tabs_laid_out
        let g:airline_themes_ez_patcher#palette['airline_post_active_tabs'] = g:airline_wintabs_patcher#post_active_tabs_style
    endif
endfunction
