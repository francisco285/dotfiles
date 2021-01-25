let mapleader = "\<Space>"

" Escape
  inoremap ç <Esc>
  cnoremap ç <C-c>
  vnoremap ç <Esc>
  nnoremap <silent> ç :echo<cr>
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
" https://github.com/tpope/vim-unimpaired/pull/164
autocmd VimEnter * nnoremap <silent> [<Space> :<C-U>call append(line('.') - 1, repeat([''], v:count1))<CR>
autocmd VimEnter * nnoremap <silent> ]<Space> :<C-U>call append(line('.'), repeat([''], v:count1))<CR>
" Insert line above and below
autocmd VimEnter * nnoremap <silent> []<space>
    \ :<C-U>call append(line('.') - 1, repeat([''], v:count1))<bar>call append(line('.'), repeat([''], v:count1))<CR>
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
nnoremap <silent> <leader>D :silent call <sid>close_hidden_buffers<cr>
" Easier way to jump to last selected buffer
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

" Turn One Line Into Title Caps (from :help g??)
nnoremap <silent> gUt :s/\v<(.)(\w*)/\u\1\L\2/g<cr>

nnoremap <silent> got :call <sid>open_dir_on_tmux(expand('%:p:h'))<cr>
nnoremap <silent> goT :call <sid>open_dir_on_tmux(getcwd())<cr>

function! s:open_dir_on_tmux(dir) abort
  if exists('$TMUX')
    call system('tmux split -h -c ' . a:dir)
  else
    echohl Error | echo 'Not inside tmux' | echohl None
  endif
endfunction

" Zen mode for focus
nnoremap <silent> <Leader>z :call <SID>toggleZenMode()<CR>

function! s:toggleZenMode()
  if !exists('g:ZenModeIsOn')
    let g:ZenModeEnabled = 1
  endif

  if g:ZenModeEnabled
    set showtabline=0
    set laststatus=0
  else
    set showtabline=2
    set laststatus=2
  endif

  let g:ZenModeEnabled = !g:ZenModeEnabled
endfunction

" https://github.com/airblade/dotvim/blob/master/vimrc ========================

" gm jumps to middle of current screen line's text.
function! s:goto_middle()
  " Get buffer width. (http://stackoverflow.com/a/26318602/151007)
  redir => signlist
    execute "silent sign place buffer=".bufnr('')
  redir end
  let signlist = split(signlist, '\n')
  let width = winwidth(0) - &numberwidth - &foldcolumn - (len(signlist) > 2 ? 2 : 0)

  normal g^
  let first_non_blank_char = col('.') % width
  normal g$
  let last_non_blank_char = 1 + ((col('.')-1) % width)
  let middle_non_blank_char = first_non_blank_char + (last_non_blank_char - first_non_blank_char) / 2
  execute "normal g0".middle_non_blank_char."l"
endfunction
nnoremap <silent> gm :call <sid>goto_middle()<CR>

" Visually select the text that was most recently edited/pasted.
" Note: gv selects previously selected area.
nmap gV `[v`]

" Retain cursor position when visually yanking.
xnoremap <expr> y 'my"'.v:register.'y`y'
xnoremap <expr> Y 'my"'.v:register.'Y`y'

" Make * and # work with visual selection.
xnoremap <silent> * yq/p<CR>
xnoremap <silent> # yq?p<CR>

nnoremap <silent> <leader>D :call <sid>close_hidden_buffers()<cr>
" Wipe all hidden buffers.
function! s:close_hidden_buffers()
  let visible = []
  for i in range(1, tabpagenr('$'))
    call extend(visible, tabpagebuflist(i))
  endfor
  for b in filter(range(1, bufnr('$')), {_,b -> bufloaded(b) && index(visible,b) == -1})
    execute 'bw' b
  endfor
endfunction

" Narrow word text object: optional upper-case letter followed by lower-case letters
xnoremap in :<C-U>normal! l?\a\l\+?s<C-V><CR>v/\L/s-<C-V><CR>v:nohlsearch<C-V><CR>gv<CR>
onoremap in :normal vin<CR>
