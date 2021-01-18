" Colors support for terminal
if has("termguicolors")
  set termguicolors
elseif &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

let g:style = 'transparent'
let g:theme = 'vim-material'

set background=dark
execute 'colorscheme ' . g:theme

let g:lightline = {}

if g:style ==# 'black'
  autocmd VimEnter * hi Normal guibg=#000000
elseif g:style ==# 'transparent'
  autocmd VimEnter * hi Normal guibg=NONE
  autocmd VimEnter * hi Pmenu guibg=NONE
  autocmd VimEnter * hi FoldColumn guibg=NONE
endif

if g:theme == 'gruvbox'
  let g:gruvbox_contrast_dark='hard'
  let g:gruvbox_invert_selection='0'
  let g:gruvbox_italic = 1
  let g:gruvbox_invert_tabline = 1
  let g:lightline.colorscheme = 'srcery_alter'
  if !(g:style ==# 'normal')
    autocmd VimEnter * hi SignColumn guibg=NONE
    autocmd VimEnter * hi CursorLine guibg=#1D2021
    autocmd VimEnter * hi CursorLineNr guifg=#fb4934 guibg=#1D2021
    autocmd VimEnter * hi ColorColumn guibg=#1D2021
  endif
elseif g:theme == 'vim-material'
  let g:material_style='oceanic'
  let g:lightline.colorscheme = 'tfw_dark'
  if !(g:style ==# 'normal')
    autocmd VimEnter * hi SignColumn guibg=NONE
    autocmd VimEnter * hi CursorLine guibg=#0F111A
    autocmd VimEnter * hi CursorLineNr guibg=#0F111A
    autocmd VimEnter * hi ColorColumn guibg=#0F111A
  endif
endif
