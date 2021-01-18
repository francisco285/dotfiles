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

augroup CUSTOM_COLORS
  autocmd VimEnter * hi Normal guibg=#000000 ctermbg=0
  autocmd VimEnter * hi SignColumn guibg=#000000 ctermbg=0
  autocmd VimEnter * hi MatchParen ctermfg=197 ctermbg=NONE cterm=bold guifg=#e91e63 guibg=NONE gui=bold
  autocmd VimEnter * hi IncSearch ctermfg=235 ctermbg=44 cterm=bold guifg=#1e222c guibg=#fb4934 gui=bold
  autocmd VimEnter * hi Search ctermfg=235 ctermbg=44 cterm=bold guifg=#1e222c guibg=#fb4934 gui=bold
  " autocmd VimEnter * hi ColorColumn guibg=#0C0C0C
  autocmd VimEnter * hi ColorColumn guibg=#1D2021
  " autocmd VimEnter * hi CursorLine guibg=#0C0C0C
  autocmd VimEnter * hi CursorLine guibg=#1D2021
  autocmd VimEnter * hi CursorLineNr ctermfg=167 guifg=#fb4934 guibg=#0C0C0C
  autocmd VimEnter * hi TabLineFill guifg=#000000
  autocmd VimEnter * hi VertSplit guibg=NONE guifg=#fb4934
augroup END

function s:setActiveWindow()
  setlocal cursorline colorcolumn=79,80
endfunction

function s:setInactiveWindow()
  setlocal nocursorline colorcolumn=
endfunction

augroup WindowManagement
  autocmd!
  autocmd BufEnter,WinEnter,FocusGained * call s:setActiveWindow()
  autocmd BufLeave,WinLeave,FocusLost   * call s:setInactiveWindow()
augroup END

" PLUGINS =====================================================================

" lightline.vim {{{
if !exists('g:lightline')
  let g:lightline = {}
endif

let g:lightline.colorscheme = 'srcery_alter'
" let g:lightline.colorscheme = 'gruvbox'

" lightline.vim }}}
