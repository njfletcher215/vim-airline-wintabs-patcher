# vim-airline-wintabs-patcher

A supplementary plugin for [vim-airline](https://github.com/vim-airline/vim-airline) and [vim-wintabs](https://github.com/zefei/vim-wintabs) that integrates wintabs' tab indicators with airline's tabline and theme, allowing the user to view the active and inactive tabs when airline is using the tabline and wintabs is using the statusline.

## Installation

Use your favorite plugin manager to install. I recommend [vim-plug](https://github.com/junegunn/vim-plug):

This plugin depends on [vim-airline](https://github.com/vim-airline/vim-airline) and [vim-wintabs](https://github.com/zefei/vim-wintabs), of course, and also [vim-airline-themes-ez-patcher](https://github.com/njfletcher215/vim-airline-themes-ez-patcher), so be sure to install those first.

```vim
call plug#begin()

" dependencies
Plug 'vim-airline/vim-airline'
Plug 'zefei/vim-wintabs'
Plug 'njfletcher215/vim-airline-themes-ez-patcher'

" plugin
Plug 'njfletcher215/vim-airline-wintabs-patcher'

call plug#end()
```

## Basic Usage

In your `.vimrc`, set wintabs to use the statusline and airline to use the tabline. Technically this plugin will still function when wintabs is using the tabline and airline is using the statusline (the default configuration for each), but it would be redundant, since the wintabs tab indicators would be visible anyway.
```vim
" display wintabs buffers in statusline
let g:wintabs_display='statusline'

" display airline statusline in the tabline
let g:airline_statusline_ontop=1
```

I recommend also setting the statusline and tabline to be always visible.
```vim
" always show the statusline
set laststatus=2

" always show the tabline
set showtabline=2
```

The wintabs tab indicators will now be visible in the tabline, alongside the default airline statusline.

## Configuration Options

### `g:airline_wintabs_patcher#active_tab_style`
**Type**: String | Dictionary
**Default**: `"airline_a"`

The [vim-airline-themes-ez-patcher section](https://github.com/njfletcher215/vim-airline-themes-ez-patcher/blob/main/README.md#gairline_themes_ez_patcherpalette)-style section definition for the active tab.

The section name should *not* be passed.

ex:
```vim
let g:airline_wintabs_patcher#active_tab_style = {
    'foreground': 'airline_a',  " copy the foreground color for each mode from airline_a
    'background': {
        'base': {  " and set the background color for each mode to black
            'Xterm': 0,
            'hexcode': '#000000'
        }
    }
}
```

If a section `airline_active_tab` already exists in `g:airline_themes_ez_patcher#palette`, this value will be ignored and that section definition will be used instead.

### `g:airline_wintabs_patcher#display_mode`
**Type**: Number
**Default**: 2

The display format for the tab indicators.
- `0`: No display
- `1`: Display active tab only
- `2`: Display all tabs

If more control over the layout is required, you can directly manipulate `g:airline_themes_ez_patcher#layout` or `g:airline#extensions#default#layout`. See the [vim-airline-themes-ez-patcher docs](https://github.com/njfletcher215/vim-airline-themes-ez-patcher/blob/main/README.md#gairline_themes_ez_patcherlayout) or the [vim-airline docs](https://github.com/vim-airline/vim-airline/blob/master/doc/airline.txt) for more information.

If any one of the sections `"pre_active_tabs"`, `"active_tab"`, or `"post_active_tabs"` is found in either `g:airline_themes_ez_patcher#layout` or `g:airline#extensions#default#layout`, this value will be ignored and the custom layout will be used.

### `g:airline_wintabs_patcher#post_active_tabs_style`
**Type**: String | Dictionary
**Default**: `"airline_c"`

The [vim-airline-themes-ez-patcher section](https://github.com/njfletcher215/vim-airline-themes-ez-patcher/blob/main/README.md#gairline_themes_ez_patcherpalette)-style section definition for the inactive tabs following the active tab.

The section name should *not* be passed.

ex:
```vim
let g:airline_wintabs_patcher#post_active_tabs_style = {
    'foreground': 'airline_c',  " copy the foreground color for each mode from airline_c
    'background': {
        'base': {  " and set the background color for each mode to black
            'Xterm': 0,
            'hexcode': '#000000'
        }
    }
}
```

If a section `airline_post_active_tabs` already exists in `g:airline_themes_ez_patcher#palette`, this value will be ignored and that section definition will be used instead.

### `g:airline_wintabs_patcher#pre_active_tabs_style`
**Type**: String | Dictionary
**Default**: `"airline_c"`

The [vim-airline-themes-ez-patcher section](https://github.com/njfletcher215/vim-airline-themes-ez-patcher/blob/main/README.md#gairline_themes_ez_patcherpalette)-style section definition for the inactive tabs preceding the active tab.

The section name should *not* be passed.

ex:
```vim
let g:airline_wintabs_patcher#pre_active_tabs_style = {
    'foreground': 'airline_c',  " copy the foreground color for each mode from airline_c
    'background': {
        'base': {  " and set the background color for each mode to black
            'Xterm': 0,
            'hexcode': '#000000'
        }
    }
}
```

If a section `airline_pre_active_tabs` already exists in `g:airline_themes_ez_patcher#palette`, this value will be ignored and that section definition will be used instead.

### `g:airline_wintabs_patcher#separator`
**Type**: String
**Default**: "  " (2 spaces)

The character(s) separating two tabs in the same section. For example, if the first tab is active, the second and third tabs would both be in the `post_active_tabs` section, and this value would be between '2' and '3' (but NOT between '1' and '2').

A 2-character separator is recommended, as that maintains the same spacing no matter which tab is active, but it is not required.

## Questions or Issues?

Feel free to open an issue on GitHub if something's not working or not clear.
Alternatively, you can contact the developer at njfletcher215@gmail.com
