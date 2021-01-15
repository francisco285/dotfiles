let mapleader = "\<Space>"

" Escape
  inoremap ç <Esc>
  cnoremap ç <C-c>
  vnoremap ç <Esc>
  inoremap Ç <Esc>
  cnoremap Ç <C-c>
  vnoremap Ç <Esc>
  tnoremap <c-space><c-space> <c-\><c-n>

" Y behaves like D and C
nnoremap Y y$
" More regex-like search
nnoremap / /\v
" Toggle hlsearch
nnoremap <silent> <leader>/ :set hlsearch!<cr>
" Put neovim into the background even if it is in insert mode
inoremap <c-z> <c-o><c-z>
" Optionally use <c-h> and <c-l> as left/right arrows for simple movements
inoremap <c-h> <left>
inoremap <c-l> <right>
" Execute shell command more easily
nnoremap ! :!
" $ do not select eol in visual mode
vnoremap $ $h
" Easier macro repeat
nnoremap Q @q
" Delete/Paste in visual without relying on the registers/clipboard
vnoremap <leader>d "_d
vnoremap <leader>D "_D
vnoremap <leader>p "_dp
vnoremap <leader>P "_dP
" Centralize screen after using the } and { commands
nnoremap { {zz
nnoremap } }zz
" j and k behave better when wrap is set
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" Buffer navigation
nnoremap <expr> <silent> <leader>n (v:count == 0 ? ":bn<cr>" : ":<c-u>exec 'bn ' . v:count<cr>")
nnoremap <silent> <leader>N :bl
nnoremap <expr> <silent> <leader>p (v:count == 0 ? ":bp<cr>" : ":<c-u>exec 'bp ' . v:count<cr>")
nnoremap <silent> <leader>P :bf
" Delete buffer
nnoremap <silent> <leader>d :silent bd<cr>
nnoremap <silent> <leader>D :silent %bd<cr>
" Easier jump to last active buffer
nnoremap <leader><leader> <c-^>
" Tab as 'leader' for window operations instead of <c-w>
nmap <tab> <C-w>
" Easier window split
nnoremap <silent> <tab>sh :<c-u>abo vert split<cr>
nnoremap <silent> <tab>sj :<c-u>bel split<cr>
nnoremap <silent> <tab>sk :<c-u>abo split<cr>
nnoremap <silent> <tab>sl :<c-u>bel vert split<cr>
nnoremap <tab>v <nop>
" Easier navigation through history
nnoremap + <c-i>
nnoremap - <c-o>
nnoremap <c-o> <nop>
" Save
nnoremap <silent> <leader>w :silent update<cr>
nnoremap <silent> <leader>W :silent update<cr>
" Quit
nnoremap <silent> <leader>q :q<cr>
nnoremap <silent> <leader>Q :qall<cr>
nnoremap <silent> <leader>x :x<cr>
" Better navigation in command mode
cnoremap <expr> <c-h> (pumvisible() ? "\<up>": "\<left>")
cnoremap <expr> <c-j> (pumvisible() ? "\<right>": "\<down>")
cnoremap <expr> <c-k> (pumvisible() ? "\<left>": "\<up>")
cnoremap <expr> <c-l> (pumvisible() ? "\<down>": "\<right>")
cnoremap <c-b> <s-left>
cnoremap <c-e> <s-right>
" Insert directory of the current buffer in command mode
cnoremap <c-space> <c-r>=expand('%:p:h')<cr>/
" Show completion options
cnoremap <expr> <c-d> getcmdpos()>strlen(getcmdline())?"\<lt>C-D>":"\<lt>Del>"

" Zen mode for focus
nnoremap <silent> <Leader>z :call <SID>toggleZenMode()<CR>

function! s:toggleZenMode()
  if !exists('g:ZenModeIsOn')
    let g:ZenModeIsOn = 1
  endif

  if exists('$TMUX')
    silent !tmux set status > /dev/null 2>&1
  endif

  if g:ZenModeIsOn
    set showtabline=0
    set laststatus=0
  endif

  if !g:ZenModeIsOn
    set showtabline=2
    set laststatus=2
  endif

  let g:ZenModeIsOn = !g:ZenModeIsOn
endfunction
