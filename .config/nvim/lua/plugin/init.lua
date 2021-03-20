local util = require('autoload.util')

local function packer_bootstrap()
  local execute = vim.api.nvim_command
  local fn = vim.fn

  local install_path = util.join_paths(fn.stdpath('data'), 'site', 'pack', 'packer', 'opt', 'packer.nvim')

  if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute([[packadd packer.nvim]])
  end
end

packer_bootstrap()

local setup = require('plugin.setup')
local config = require('plugin.config')

vim.cmd('packadd packer.nvim')

require('packer').startup(
function(use)
  use { 'wbthomason/packer.nvim', opt = true }

  use {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    setup = setup.telescope,
    config = config.telescope,
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-lua/popup.nvim' }
    }
  }

  use {
    'mattn/emmet-vim',
    ft = { 'html', 'css', 'javascript', 'javascriptreact', 'vue', 'typescript', 'typescriptreact' },
    config = config.emmet_vim
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = config.nvim_colorizer
  }

  use {
    'prettier/vim-prettier',
    cmd = { 'Prettier', 'PrettierAsync', 'PrettierPartial', 'PrettierFragment', 'PrettierVersion', 'PrettierCli', 'PrettierCliPath', 'PrettierCliVersion' },
    ft = { 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html' },
    run = 'npm install',
    setup = setup.vim_prettier,
    config = config.vim_prettier
  }

  use {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    setup = setup.undotree,
    config = config.undotree
  }

  use {
    'instant-markdown/vim-instant-markdown',
    ft = 'markdown',
    config = config.vim_instant_markdown
  }

  use {
    'voldikss/vim-floaterm',
    cmd = { 'FloatermToggle', 'FloatermNew' },
    setup = setup.vim_floaterm,
    config = config.vim_floaterm
  }

  use {
    'rhysd/git-messenger.vim',
    cmd = 'GitMessenger',
    setup = setup.git_messenger,
    config = config.git_messenger
  }

  use {
    'rhysd/committia.vim',
    ft = 'gitcommit',
    config = config.committia
  }

  use {
    'puremourning/vimspector',
    cmd = 'VimspectorLaunch',
    setup = setup.vimspector
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = config.nvim_treesitter
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter'
  }

  use {
    'liuchengxu/vista.vim',
    cmd = 'Vista',
    setup = setup.vista,
    config = config.vista
  }

  use {
    'brooth/far.vim',
    cmd = { 'Far', 'Fardo', 'Farf', 'Farp', 'Farr', 'Farundo' },
    setup = setup.far,
    config = config.far
  }

  use {
    'glepnir/zephyr-nvim',
    config = config.zephyr_nvim
  }

  use {
    'akinsho/nvim-bufferline.lua',
    setup = setup.nvim_bufferline,
    config = config.nvim_bufferline,
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- TODO: Configure LSP integration when (and if) it is implemented
  -- https://github.com/kyazdani42/nvim-tree.lua/issues/227
  use {
    'kyazdani42/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
    setup = setup.nvim_tree,
    config = config.nvim_tree,
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    after = 'zephyr-nvim',
    config = config.galaxyline
  }

  use {
    'neovim/nvim-lspconfig',
    event = 'BufRead *',
    setup = setup.nvim_lspconfig,
    config = config.nvim_lspconfig
  }

  use {
    'hrsh7th/nvim-compe',
    setup = setup.nvim_compe,
    config = config.nvim_compe,
    event = 'InsertEnter *'
  }

  use {
    'glepnir/lspsaga.nvim',
    cmd = 'Lspsaga',
    setup = setup.lspsaga,
    requires = 'neovim/nvim-lspconfig'
  }

  use {
    'kosayoda/nvim-lightbulb',
    event = 'BufRead *',
    config = config.nvim_lightbulb
  }

  use {
    'chrisbra/NrrwRgn',
    cmd = { 'NarrowRegion', 'NR' },
    setup = setup.NrrwRgn
  }

  use {
    'editorconfig/editorconfig-vim'
  }

  use {
    'lambdalisue/gina.vim',
    cmd = 'Gina',
    setup = setup.gina
  }

  use {
    'tomtom/tcomment_vim',
    event = 'BufRead *',
    setup = setup.tcomment_vim
  }

  use {
    'ThePrimeagen/vim-be-good',
    cmd = 'VimBeGood'
  }

  use {
    'justinmk/vim-dirvish',
    cmd = 'Dirvish',
    setup = setup.vim_dirvish
  }

  use {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead *',
    setup = setup.gitsigns,
    config = config.gitsigns,
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }

  use {
    'AndrewRadev/splitjoin.vim',
    cmd = { 'SplitjoinJoin', 'SplitjoinSplit' },
    setup = setup.splitjoin
  }

  use {
    'justinmk/vim-gtfo',
    event = 'BufRead *'
  }

  use {
    'szw/vim-maximizer',
    cmd = 'MaximizerToggle',
    setup = setup.vim_maximizer
  }

  use {
    'tpope/vim-surround',
    requires = 'tpope/vim-repeat'
  }

  -- Other interesting plugins:
  -- 'tpope/vim-dadbod'
  -- 'kristijanhusak/vim-dadbod-ui'
  -- 'hrsh7th/vim-vsnip'
  -- 'mattn/vim-sonictemplate'
  -- 'pechorin/any-jump.vim'
  -- 'junegunn/vim-journal'
  -- 'tpope/vim-surround'
  -- 'wellle/targets.vim'
  -- 'tpoppe/vim-fugitive'
  -- 'junegunn/goyo.vim'
  -- 'codota/tabnine-vim'
  -- 'cohama/lexima.vim'
  -- Note: I am probably not going to use lexima anymore, but if I do, it is
  -- nice to save this piece of code (useful for html):
  -- vim.fn['lexima#add_rule']({'char': '<CR>', 'at': [[>\%#<]], 'input_after': '<CR>', 'filetype': 'html'})
end
)
