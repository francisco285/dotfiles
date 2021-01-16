" True colors support for terminal
if (has("termguicolors"))
  set termguicolors
elseif &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

let g:material_style='oceanic'
set background=dark
colorscheme vim-material

augroup CUSTOM_COLORS
  " Transparency
  autocmd VimEnter * hi Normal guibg=NONE
  autocmd VimEnter * hi SignColumn guibg=NONE ctermbg=NONE
  autocmd VimEnter * hi Pmenu guibg=NONE

  autocmd VimEnter * hi MatchParen ctermfg=197 ctermbg=NONE cterm=bold guifg=#e91e63 guibg=NONE gui=bold
  autocmd VimEnter * hi IncSearch ctermfg=235 ctermbg=44 cterm=bold guifg=#1e222c guibg=#e91e63 gui=bold
  autocmd VimEnter * hi Search ctermfg=235 ctermbg=44 cterm=bold guifg=#1e222c guibg=#e91e63 gui=bold
  autocmd VimEnter * hi ColorColumn guibg=#0F111A
  autocmd VimEnter * hi CursorLine guibg=#0F111A
  autocmd VimEnter * hi CursorLineNr guibg=#0F111A
  autocmd VimEnter * hi TabLineFill guifg=#000000
  autocmd VimEnter * hi TabLineSel guibg=#61AFEF guifg=black
  autocmd VimEnter * hi VertSplit guibg=#7199EE guifg=#181A1F
augroup END

augroup WindowManagement
  autocmd!
  autocmd BufEnter,WinEnter,FocusGained * setlocal cursorline colorcolumn=79,80
  autocmd BufLeave,WinLeave,FocusLost   * setlocal nocursorline colorcolumn=
augroup END

let g:transparency_enabled = 1

" PLUGINS =====================================================================

" dashboard-nvim {{{
autocmd VimEnter * highlight DashboardHeader guifg=#7199EE
autocmd VimEnter * highlight DashboardCenter guifg=#89DDFF
autocmd VimEnter * highlight DashboardFooter guifg=#7199EE
" dashboard-nvim }}}

" lightline.vim {{{
if !exists('g:lightline')
  let g:lightline = {}
endif

let g:lightline.colorscheme = 'tfw_dark'
" let g:lightline.colorscheme = 'moons'
" let g:lightline.colorscheme = 'material'
" lightline.vim }}}
