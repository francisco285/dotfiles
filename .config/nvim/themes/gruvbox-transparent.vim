" Colors support for terminal
if has("termguicolors")
  set termguicolors
elseif &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
set background=dark
colorscheme gruvbox

let g:gruvbox_italic = 1
let g:gruvbox_invert_tabline = 1

if !exists('g:lightline')
  let g:lightline = {}
endif

let g:lightline.colorscheme = 'srcery_alter'
" let g:lightline.colorscheme = 'gruvbox'

augroup CUSTOM_COLORS
  " Transparency
  autocmd VimEnter * hi Normal guibg=NONE ctermbg=0
  autocmd VimEnter * hi SignColumn guibg=NONE ctermbg=NONE
  autocmd VimEnter * hi Pmenu guibg=NONE

  autocmd VimEnter * hi MatchParen ctermfg=197 ctermbg=NONE cterm=bold guifg=#e91e63 guibg=NONE gui=bold
  autocmd VimEnter * hi IncSearch ctermfg=235 ctermbg=44 cterm=bold guifg=#1e222c guibg=#fb4934 gui=bold
  autocmd VimEnter * hi Search ctermfg=235 ctermbg=44 cterm=bold guifg=#1e222c guibg=#fb4934 gui=bold
  autocmd VimEnter * hi ColorColumn guibg=#1D2021
  " autocmd VimEnter * hi CursorLine guibg=#191919
  autocmd VimEnter * hi CursorLine guibg=#1D2021
  " autocmd VimEnter * hi CursorLineNr guibg=#191919
  autocmd VimEnter * hi CursorLineNr guibg=#1D2021
  autocmd VimEnter * hi TabLineFill guifg=#000000
  autocmd VimEnter * hi VertSplit guibg=NONE guifg=#fb4934
augroup END

let g:transparency_enabled = 1

" PLUGINS =====================================================================

" lightline.vim {{{
if !exists('g:lightline')
  let g:lightline = {}
endif

let g:lightline.colorscheme = 'srcery_alter'
" let g:lightline.colorscheme = 'gruvbox'
" lightline.vim }}}
