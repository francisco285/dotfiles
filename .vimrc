inoremap <silent> ç <Esc>
inoremap <silent> Ç <Esc>
vnoremap <silent> ç <Esc>
vnoremap <silent> Ç <Esc>
cnoremap <silent> ç <c-c>
cnoremap <silent> Ç <c-c>

syntax on
filetype plugin on
filetype indent on

set langmenu=en_US.UTF-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set updatetime=100
set history=5000
set langmenu=en_US.UTF-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set updatetime=100
set history=5000
set splitbelow
set splitright
set hidden
set wildcharm=<Tab>
set wildignorecase
set wildignore+=*node_modules/*,*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
set wildignore+=*.png,*.jpeg,*.jpg,*.gif
set wildignore+=*.mp4,*.mkv
set wildignore+=*.mp3,*.m4a
set wildignore+=*.pdf
set signcolumn=yes
set showtabline=2
set ignorecase
set smartcase
set incsearch
set nohlsearch
set list
set listchars=tab:>-,extends:»,precedes:«,trail:•
set autoindent
set smartindent
set nowrap
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set relativenumber
set number
set clipboard=unnamed,unnamedplus
set backspace=indent,eol,start
set noruler
set confirm
set mouse=a
" set fillchars=vert:\│,eob:\ ,foldsep:\ ,foldopen:▾,foldclose:▸
set cmdheight=2
set cmdwinheight=10
set laststatus=2
set nostartofline
set noshowmode
" set inccommand=nosplit
set nowritebackup
set noswapfile
set tildeop
set timeout
set timeoutlen=500
set shortmess=filmnrwxoOtcF
set belloff=all
set virtualedit=block
set nobackup
set undodir=~/.vim/undo
set undofile
set guioptions-=mTrL
set cursorline
set colorcolumn=79,80

command! W w
autocmd FileType * set formatoptions-=c formatoptions-=r formatoptions-=o

inoremap <silent> ç <Esc>

autocmd FileType html,vim set matchpairs+=<:>
autocmd FileType help set relativenumber
autocmd FileType help set number

call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'sainnhe/lightline_foobar.vim'
Plug 'ryanoasis/vim-devicons'
call plug#end()

set background=dark
hi Normal guibg=black ctermbg=gray
colorscheme gruvbox

nnoremap <silent> <c-p> :FZF<cr>
nnoremap <silent> <c-b> :Buffers<cr>

" Display horizontal menu of suggestions when hit tab
set wildmenu
set wildmode=full

let mapleader = " "

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

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }

let g:lightline#bufferline#number_separator = ': '
let g:lightline#bufferline#unnamed = 'untitled'

function! ReturnBranchString() abort
  let options = ["\ue725", "\uE0A0"]
  if !exists('g:loaded_fugitive') || g:loaded_fugitive == 0
    return ''
  endif

  if FugitiveHead() !=# ''
    return options[0] . ' ' . FugitiveHead()
  else
    return ''
  endif
endfunction

if !exists('g:lightline')
  let g:lightline = {}
endif

let g:lightline.active = {
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'cocstatus', 'readonly', 'filename', 'modified' ]
      \   ],
      \ }

let g:lightline.enable = {
      \ 'tabline': 1
      \ }

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

let g:lightline.separator = { 'left': "\ue0b8", 'right': "\ue0be" }
let g:lightline.subseparator = { 'left': "\ue0b9", 'right': "\ue0b9" }
let g:lightline.tabline_separator = { 'left': "\ue0bc", 'right': "\ue0ba" }
let g:lightline.tabline_subseparator = { 'left': "\ue0bb", 'right': "\ue0bb" }

let g:lightline.tab_component = {
      \ }
let g:lightline.tab_component_function = {
      \ 'filename': 'lightline#tab#filename',
      \ 'modified': 'lightline#tab#modified',
      \ 'readonly': 'lightline#tab#readonly',
      \ 'tabnum': 'Tab_num',
      \ 'branch_string': 'ReturnBranchString',
      \ }
let g:lightline.component = {
      \ 'bufinfo': '%{bufname("%")}:%{bufnr("%")}',
      \ 'vim_logo': "\ue7c5",
      \ 'mode': '%{lightline#mode()}',
      \ 'absolutepath': '%F',
      \ 'relativepath': '%f',
      \ 'filename': '%t',
      \ 'filesize': "%{HumanSize(line2byte('$') + len(getline('$')))}",
      \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
      \ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
      \ 'modified': '%M',
      \ 'bufnum': '%n',
      \ 'paste': '%{&paste?"PASTE":""}',
      \ 'readonly': '%R',
      \ 'charvalue': '%b',
      \ 'charvaluehex': '%B',
      \ 'percent': '',
      \ 'percentwin': '%P',
      \ 'spell': '%{&spell?&spelllang:""}',
      \ 'lineinfo': '☰ %1p%%  %l:%-2v',
      \ 'line': '%l',
      \ 'column': '%c',
      \ 'close': '%999X X ',
      \ 'winnr': '%{winnr()}'
      \ }

function! FormatDirectory(dir) abort
  if !(type(a:dir) == type(""))
    return
  endif

  if a:dir ==# $HOME
    return '~'
  endif

  let folders = split(a:dir, '/')

  if len(folders) >= 2
    let first_and_second_folders = '/' . join(folders[0:1], '/')
    if first_and_second_folders ==# $HOME
      return '~' . '/' . join(folders[2:-1], '/')
    endif
  else
    return a:dir
  endif
endfunction

function! FormatCwd() abort
  return FormatDirectory(getcwd())
endfunction

let g:lightline.component_function = {
      \   'cocstatus': 'coc#status',
      \   'gitbranch': 'FugitiveHead',
      \   'branch_string': 'ReturnBranchString',
      \   'current_working_directory': 'FormatCwd'
      \ }

let g:lightline.component_expand = {
      \ 'buffers': 'lightline#bufferline#buffers',
      \ }

let g:lightline.component_type = {
      \ 'buffers': 'tabsel'
      \ }

let g:lightline.tabline = {
      \ 'left': [ [ 'vim_logo', 'buffers' ] ],
      \ 'right': [ [ 'branch_string', 'current_working_directory' ] ]
      \ }

let g:lightline.tab = {
      \ 'active': [ 'tabnum', 'devicons_filetype', 'filename', 'modified' ],
      \ 'inactive': [ 'tabnum', 'devicons_filetype', 'filename', 'modified' ] }

let g:lightline.component_raw = {'buffers': 1}

let g:lightline#bufferline#clickable = 1

let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#enable_nerdfont = 1

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

let g:lightline.colorscheme = 'gruvbox'
