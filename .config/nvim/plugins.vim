" Install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo $VIMCONFIG/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | echo "Plugin manager 'vim-plug' installed"
endif

call plug#begin('~/.nvim/plugged')

Plug 'frazrepo/vim-rainbow'
Plug 'gruvbox-community/gruvbox'
Plug 'hzchirs/vim-material'
Plug 'tomtom/tcomment_vim'
Plug 'mg979/vim-visual-multi'
Plug 'sheerun/vim-polyglot'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'mbbill/undotree'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'sainnhe/lightline_foobar.vim'
Plug 'szw/vim-maximizer'
Plug 'nvim-lua/telescope.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'djoshea/vim-autoread'
Plug 'tpope/vim-fugitive'
Plug 'voldikss/vim-floaterm'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pseewald/vim-anyfold'
Plug 'tpope/vim-surround'
Plug 'puremourning/vimspector'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'cohama/lexima.vim'
Plug 'DougBeney/pickachu'
Plug 'ap/vim-css-color'

" Plug 'glepnir/dashboard-nvim'
" Plug 'metakirby5/codi.vim'
" Plug 'editorconfig/editorconfig-vim'
" Plug 'Yggdroot/indentLine'
" Plug 'AndrewRadev/tagalong.vim'
" Plug 'alvan/vim-closetag'
" Plug 'machakann/vim-highlightedyank'
" Plug 'ratheesh/vim-extended-ft'
" Plug 'junegunn/vim-slash'

call plug#end()
