" parse the wintabs string to determine which tab is active, which are before the active tab, and which are after
function! airline_wintabs_patcher#utils#parse_wintabs_string()
    let l:input = wintabs#ui#get_vimtabs_fragment()
    let l:pattern = '\v%(#WintabsInactive#|#WintabsActive#|\s\w+\s)'
    let l:matches = []
    call substitute(l:input, l:pattern, '\=add(l:matches, submatch(0))', 'g')

    let l:tabs = {'pre_active': [], 'active': [], 'post_active': []}
    let l:current_group = 'pre_active'

    for l:item in l:matches
        if l:item ==# '#WintabsActive#'
            let l:current_group = 'active'
        elseif l:current_group ==# 'active' && l:item ==# '#WintabsInactive#'
            let l:current_group = 'post_active'
        elseif l:item =~ '\s\w\+\s'
            call add(l:tabs[l:current_group], l:item[1:-2])
        endif
    endfor

    return l:tabs
endfunction



" build a string representation of the tabs in the specified tabs_list
function! airline_wintabs_patcher#utils#format_tabs_section(tabs_list)
    let l:tabs_str = ''
    for l:tab in a:tabs_list
        let l:tabs_str .= l:tab . g:airline_wintabs_patcher#separator
    endfor
    return l:tabs_str[:-1 * (len(g:airline_wintabs_patcher#separator) + 1)]
endfunction

" airline does not allow parameters to be passed to a define_function, so each of these must be separate functions
" return the pre_active tabs
function! airline_wintabs_patcher#utils#get_pre_active_tabs()
    return airline_wintabs_patcher#utils#format_tabs_section(airline_wintabs_patcher#utils#parse_wintabs_string()['pre_active'])
endfunction

" return the active tab
function! airline_wintabs_patcher#utils#get_active_tab()
    return airline_wintabs_patcher#utils#format_tabs_section(airline_wintabs_patcher#utils#parse_wintabs_string()['active'])
endfunction

" return the post_active tabs
function! airline_wintabs_patcher#utils#get_post_active_tabs()
    return airline_wintabs_patcher#utils#format_tabs_section(airline_wintabs_patcher#utils#parse_wintabs_string()['post_active'])
endfunction
