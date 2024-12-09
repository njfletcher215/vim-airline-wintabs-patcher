" init
if exists('g:airline_wintabs_patcher#loaded')
    finish
endif
let g:airline_wintabs_patcher#loaded = 1

call airline_wintabs_patcher#globals#init()


" Register custom section with Airline
function! AirlineInit()
    call airline#parts#define_function('pre_active_tabs', 'airline_wintabs_patcher#utils#get_pre_active_tabs')
    call airline#parts#define_function('active_tab', 'airline_wintabs_patcher#utils#get_active_tab')
    call airline#parts#define_function('post_active_tabs', 'airline_wintabs_patcher#utils#get_post_active_tabs')
    let g:airline_section_pre_active_tabs = airline#section#create_right(['pre_active_tabs'])
    let g:airline_section_active_tab = airline#section#create_right(['active_tab'])
    let g:airline_section_post_active_tabs = airline#section#create_right(['post_active_tabs'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

