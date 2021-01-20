" Colors support for terminal
if has("termguicolors")
  set termguicolors
elseif &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

set background=dark

if !exists('g:lightline')
  let g:lightline = {}
endif

autocmd VimEnter * call SetTheme('gruvbox')

function! SetTheme(name, ...) abort
  if a:0 > 1 | throw 'Too many arguments' | endif
  let style = (exists('a:1') ? a:1 : 'normal')

  if a:name == 'gruvbox'
    let g:gruvbox_contrast_dark='hard'
    let g:gruvbox_invert_selection='0'
    let g:gruvbox_italic = 1
    let g:gruvbox_invert_tabline = 1
    let g:lightline.colorscheme = 'srcery_alter'

    colorscheme gruvbox

    if !(style ==# 'normal')
      highlight CursorLine guibg=#1D2021
      highlight CursorLineNr guifg=#fb4934 guibg=#1D2021
      highlight CursorColumn guibg=#1D2021
      highlight ColorColumn guibg=#1D2021
    endif
  elseif a:name == 'vim-material'
    let g:material_style='oceanic'
    let g:lightline.colorscheme = 'tfw_dark'

    colorscheme vim-material

    if !(style ==# 'normal')
      highlight CursorLine guibg=#0F111A
      highlight CursorLineNr guibg=#0F111A
      highlight CursorColumn guibg=#0F111A
      highlight ColorColumn guibg=#0F111A
    endif
  else
    execute "colorscheme " . a:name
  endif

  if style ==# 'black'
    highlight Normal guibg=#000000
    highlight SignColumn guibg=#000000
  elseif style ==# 'transparent'
    highlight SignColumn guibg=NONE
    highlight Normal guibg=NONE
    highlight Pmenu guibg=NONE
    highlight FoldColumn guibg=NONE
  endif

  call s:set_gitgutter_colors()
  call s:set_telescope_colors()

  call lightline#enable()
endfunction

" https://vi.stackexchange.com/questions/12293/read-values-from-a-highlight-group
function! s:return_highlight_term(group, term)
  let output = execute('hi ' . a:group)
  return matchstr(output, a:term . '=\zs\S*')
endfunction

function! s:set_gitgutter_colors() abort
  let gutter_bg = s:return_highlight_term('SignColumn', 'guibg')
  let gutter_bg = (gutter_bg == '' ? 'NONE' : gutter_bg)

  execute "highlight GitGutterAdd          guibg=" . gutter_bg . " guifg=#00FF00"
  execute "highlight GitGutterChange       guibg=" . gutter_bg . " guifg=#FFFF00"
  execute "highlight GitGutterDelete       guibg=" . gutter_bg . " guifg=#FF0000"
  execute "highlight GitGutterChangeDelete guibg=" . gutter_bg . " guifg=#0000FF"
endfunction

function! s:set_telescope_colors() abort
  if exists('g:colors_name') && g:colors_name ==# 'gruvbox'
    let telescope_foreground  = '#FB4934'
    let telescope_border_foreground = '#FE8019'
  elseif exists('g:colors_name') && g:colors_name ==# 'vim-material'
    let telescope_foreground  = '#89DDFF'
    let telescope_border_foreground = '#89DDFF'
  else
    highlight link TelescopeSelection Visual
    highlight link TelescopeSelectionCaret TelescopeSelection
    highlight link TelescopeNormal Normal
    highlight link TelescopePromptPrefix Identifier
    highlight link TelescopeMatching Special
    highlight link TelescopeMultiSelection Type
    highlight link TelescopeBorder TelescopeNormal
    highlight link TelescopePromptBorder TelescopeBorder
    highlight link TelescopeResultsBorder TelescopeBorder
    highlight link TelescopePreviewBorder TelescopeBorder
    return
  endif

  highlight TelescopeSelection      gui=bold
  highlight TelescopeSelectionCaret guifg=blue
  highlight TelescopeNormal         guibg=NONE
  highlight TelescopePromptPrefix   guifg=red

  execute "highlight TelescopeMatching       " . "guifg=" . telescope_foreground
  execute "highlight TelescopeMultiSelection " . "guifg=" . telescope_foreground
  execute "highlight TelescopeBorder         " . "guifg=" . telescope_border_foreground
  execute "highlight TelescopePromptBorder   " . "guifg=" . telescope_border_foreground
  execute "highlight TelescopeResultsBorder  " . "guifg=" . telescope_border_foreground
  execute "highlight TelescopePreviewBorder  " . "guifg=" . telescope_border_foreground
endfunction
