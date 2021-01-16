syntax on
filetype plugin on
filetype indent on

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
set fillchars=vert:\│,eob:\ ,foldsep:\ ,foldopen:▾,foldclose:▸
set cmdheight=2
set cmdwinheight=10
set laststatus=2
set nostartofline
set noshowmode
set inccommand=nosplit
set nowritebackup
set noswapfile
set tildeop
set timeout
set timeoutlen=500
set shortmess=filmnrwxoOtcF
set belloff=all
set virtualedit=block
set nobackup
set undodir=~/.nvim/undo
set undofile
set guioptions-=mTrL
set cursorline

command! W w
autocmd FileType * set formatoptions-=c formatoptions-=r formatoptions-=o

" Syntax highlight for embedded script highlighting
" see: https://neovim.io/doc/user/syntax.html#g%3Avimsyn_embed
let g:vimsyn_embed = 'lPr'
