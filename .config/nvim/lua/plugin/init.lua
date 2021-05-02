local util = require('autoload.util')

local function packer_bootstrap()
  local cmd = vim.api.nvim_command
  local fn = vim.fn
  local install_path = fn.expand(fn.stdpath('data') .. 'site/pack/packer/start/packer.nvim')

  if fn.empty(fn.glob(install_path)) > 0 then
    cmd('silent !git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    cmd([[packadd packer.nvim]])
    local post_sync_commands = {
      [[lua require('packer.display').quit();]],
      [[vim.cmd('silent! PackerCompile');]],
      [[vim.cmd('silent! Dashboard');]],
      -- TODO: Find a way to make this actually get displayed, the current
      -- behavior is treesitter messages being shown instead.
      -- TODO: It would be even better to show it on a floating window.
      [[vim.cmd('echo "Installation completed"')]]
    }
    util.set_augroup('bootstrap', {
      { 'VimEnter', '*', [[echo 'Installing...' | silent! PackerSync]] },
      { 'User', 'PackerComplete', '++once', '++nested', unpack(post_sync_commands) }
    })
  end
end

packer_bootstrap()

local map = require('plugin.map')
local setup = require('plugin.setup')
local config = require('plugin.config')

require('packer').init({
  display = {
    open_cmd = 'tabnew [packer]'
  }
})

require('packer').startup(
function(use)
  local function custom_use(plugin_table)
    if plugin_table.map then
      plugin_table.map()
      plugin_table.map = nil
    end

    use(plugin_table)
  end

  custom_use('wbthomason/packer.nvim')

  custom_use({
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    map = map.telescope,
    setup = setup.telescope,
    config = config.telescope,
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-lua/popup.nvim' }
    }
  })

  -- TODO: Remove it when/if 'https://github.com/aca/emmet-ls' start working
  -- nicely
  custom_use({
    'mattn/emmet-vim',
    ft = { 'html', 'css', 'javascript', 'javascriptreact', 'vue', 'typescript', 'typescriptreact' },
    config = config.emmet_vim
  })

  custom_use({
    'norcalli/nvim-colorizer.lua',
    config = config.nvim_colorizer
  })

  custom_use({
    'prettier/vim-prettier',
    cmd = { 'Prettier', 'PrettierAsync', 'PrettierPartial', 'PrettierFragment', 'PrettierVersion', 'PrettierCli', 'PrettierCliPath', 'PrettierCliVersion' },
    ft = { 'javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html' },
    run = 'npm install',
    map = map.vim_prettier,
    setup = setup.vim_prettier,
    config = config.vim_prettier
  })

  custom_use({
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    map = map.undotree,
    setup = setup.undotree,
    config = config.undotree
  })

  custom_use({
    'instant-markdown/vim-instant-markdown',
    ft = 'markdown',
    config = config.vim_instant_markdown
  })

  -- Alternatives:
  -- 'numToStr/FTerm.nvim'
  -- 'kassio/neoterm'
  custom_use({
    'voldikss/vim-floaterm',
    cmd = { 'FloatermToggle', 'FloatermNew' },
    map = map.vim_floaterm,
    setup = setup.vim_floaterm,
    config = config.vim_floaterm
  })

  custom_use({
    'rhysd/git-messenger.vim',
    cmd = 'GitMessenger',
    map = map.git_messenger,
    setup = setup.git_messenger,
    config = config.git_messenger
  })

  custom_use({
    'rhysd/committia.vim',
    ft = 'gitcommit',
    config = config.committia
  })

  -- Alternative: 'mfussenegger/nvim-dap'
  custom_use({
    'puremourning/vimspector',
    map = map.vimspector,
    fn = 'vimspector#Launch'
  })

  custom_use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = config.nvim_treesitter
  })

  custom_use({
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  })

  custom_use({
    'p00f/nvim-ts-rainbow',
    after = 'nvim-treesitter',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  })

  custom_use({
    'romgrk/nvim-treesitter-context',
    after = 'nvim-treesitter',
    cmd = 'TSContextEnable',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  })

  custom_use({
    'liuchengxu/vista.vim',
    cmd = 'Vista',
    map = map.vista,
    config = config.vista
  })

  custom_use({
    'brooth/far.vim',
    cmd = { 'Far', 'Fardo', 'Farf', 'Farp', 'Farr', 'Farundo' },
    map = map.far,
    setup = setup.far,
    config = config.far
  })

  custom_use({
    'christianchiarulli/nvcode-color-schemes.vim',
    config = config.nvcode_color_schemes
  })

  custom_use({
    'akinsho/nvim-bufferline.lua',
    map = map.nvim_bufferline,
    setup = setup.nvim_bufferline,
    config = config.nvim_bufferline,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  })

  -- TODO: Configure LSP integration when (and if) it is implemented
  -- https://github.com/kyazdani42/nvim-tree.lua/issues/227
  -- (update): This feature is in progress here -> https://github.com/kyazdani42/nvim-tree.lua/pull/260
  custom_use({
    'kyazdani42/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
    map = map.nvim_tree,
    setup = setup.nvim_tree,
    config = config.nvim_tree,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  })

  custom_use({
    'AndrewRadev/sideways.vim',
    cmd = { 'SidewaysLeft', 'SidewaysRight' },
    map = map.sideways
  })

  custom_use({
    'neovim/nvim-lspconfig',
    event = 'BufRead *',
    map = map.nvim_lspconfig,
    setup = setup.nvim_lspconfig,
    config = config.nvim_lspconfig
  })

  custom_use({
    'hrsh7th/nvim-compe',
    map = map.nvim_compe,
    setup = setup.nvim_compe,
    config = config.nvim_compe,
    event = 'InsertEnter *'
  })

  custom_use({
    'glepnir/lspsaga.nvim',
    cmd = 'Lspsaga',
    map = map.lspsaga,
    setup = setup.lspsaga,
    after = 'nvim-lspconfig',
    requires = 'neovim/nvim-lspconfig'
  })

  custom_use({
    'kosayoda/nvim-lightbulb',
    event = 'BufRead *',
    config = config.nvim_lightbulb
  })

  custom_use({
    'chrisbra/NrrwRgn',
    cmd = { 'NarrowRegion', 'NR' },
    setup = setup.NrrwRgn
  })

  custom_use('editorconfig/editorconfig-vim')

  -- Alternative: 'tpoppe/vim-fugitive'
  custom_use({
    'lambdalisue/gina.vim',
    cmd = 'Gina',
    map = map.gina,
    setup = setup.gina
  })

  custom_use({
    'tomtom/tcomment_vim',
    event = 'BufRead *',
    map = map.tcomment_vim,
    setup = setup.tcomment_vim
  })

  custom_use({
    'ThePrimeagen/vim-be-good',
    cmd = 'VimBeGood'
  })

  custom_use({
    'justinmk/vim-dirvish',
    cmd = 'Dirvish',
    map = map.vim_dirvish,
    setup = setup.vim_dirvish
  })

  custom_use({
    'lewis6991/gitsigns.nvim',
    event = 'BufRead *',
    map = map.gitsigns,
    setup = setup.gitsigns,
    config = config.gitsigns,
    requires = {
      'nvim-lua/plenary.nvim'
    }
  })

  custom_use({
    'AndrewRadev/splitjoin.vim',
    cmd = { 'SplitjoinJoin', 'SplitjoinSplit' },
    map = map.splitjoin,
    setup = setup.splitjoin
  })

  custom_use({
    'justinmk/vim-gtfo',
    event = 'BufRead *'
  })

  custom_use({
    'szw/vim-maximizer',
    cmd = 'MaximizerToggle',
    map = map.vim_maximizer,
    setup = setup.vim_maximizer
  })

  custom_use({
    'tpope/vim-surround',
    requires = 'tpope/vim-repeat'
  })

  custom_use('tpope/vim-abolish')

  custom_use({
    'hoob3rt/lualine.nvim',
    config = config.lualine,
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  })

  custom_use({
    'bfredl/nvim-miniyank',
    map = map.nvim_miniyank,
    config = config.nvim_miniyank
  })

  custom_use({
    'metakirby5/codi.vim',
    cmd = 'Codi',
    config = config.codi
  })

  -- Alternative: 'f-person/git-blame.nvim'
  custom_use({
    'APZelos/blamer.nvim',
    config = config.blamer
  })

  custom_use({
    'glepnir/dashboard-nvim',
    map = map.dashboard,
    config = config.dashboard
  })

  custom_use({
    'liuchengxu/vim-which-key',
    cmd = 'WhichKey',
    map = map.vim_which_key,
    config = config.vim_which_key
  })

  custom_use({
    'psliwka/vim-smoothie',
    config = config.vim_smoothie
  })

  custom_use({
    'junegunn/goyo.vim',
    map = map.goyo,
    cmd = 'Goyo'
  })

  custom_use({
    'wellle/targets.vim',
    event = 'BufRead *'
  })

  custom_use({
    'tversteeg/registers.nvim',
    config = config.registers
  })

  custom_use({
    'kevinhwang91/nvim-bqf',
    ft = 'qf'
  })

  -- Broken (https://github.com/hrsh7th/vim-vsnip/issues/183)
  custom_use({
    'hrsh7th/vim-vsnip',
    map = map.vim_vsnip,
    requires = {
      -- Broken (Makes it slow to enter insert mode for the first time after
      -- startup)
      'rafamadriz/friendly-snippets'
    }
  })

  custom_use('rhysd/conflict-marker.vim')

  custom_use('mattn/vim-sonictemplate')

  custom_use({
    'monaqa/dial.nvim',
    map = map.dial
  })

  custom_use({
    'AndrewRadev/linediff.vim',
    cmd = 'Linediff'
  })

  -- Note: When setting this plugin to load on the ':Switch' command, for some
  -- reason when it is used the first time the cursor jumps to some random place
  -- whithin the file and only after this the plugin starts working normally
  custom_use({
    'AndrewRadev/switch.vim',
    map = map.switch,
    setup = setup.switch
  })

  custom_use({
    'nacro90/numb.nvim',
    config = config.numb
  })

  -- -- Broken (causes Neovim to have bad performance)
  -- custom_use({
  --   'lukas-reineke/indent-blankline.nvim',
  --   config = function()
  --     vim.g.indent_blankline_buftype_exclude = { 'terminal' }
  --     vim.g.indent_blankline_filetype_exclude = {
  --       'help',
  --       'startify',
  --       'dashboard',
  --       'packer',
  --       'neogitstatus',
  --       'diff',
  --       'gitmessengerpopup',
  --       'lspinfo',
  --       'qf',
  --       'text',
  --       ''
  --     }
  --     vim.g.indent_blankline_char = '│'
  --     vim.g.indent_blankline_use_treesitter = true
  --     vim.g.indent_blankline_show_trailing_blankline_indent = false
  --     vim.g.indent_blankline_show_first_indent_level = false
  --   end,
  --   branch = 'lua'
  -- })

  -- -- Broken (does not respect custom command and throws an error)
  -- custom_use({
  --   'turbio/bracey.vim',
  --   run = 'npm install --prefix server',
  --   setup = function()
  --     vim.g.bracey_browser_command = 'brave-browser'
  --   end
  -- })

  -- -- Broken (does not work at all)
  -- custom_use('windwp/nvim-ts-autotag')

  -- -- Broken (very slow)
  -- custom_use('glacambre/firenvim')

  -- -- Broken (painful to setup in lua and its implementation is sort of a workaround due to wildmenu limitations)
  -- custom_use('gelguy/wilder.nvim')

  -- Not tested yet:
  -- 'tpope/vim-dadbod' -- Database
  -- 'kristijanhusak/vim-dadbod-ui' -- Database
  -- 'kristijanhusak/vim-dadbod-completion' -- Database
  -- 'kkoomen/vim-doge' -- (Do)cumentation (Ge)nerator
  -- 'pechorin/any-jump.vim' -- Go to definition for any language
  -- 'codota/tabnine-vim' -- Advanced AI based autocomplete for all programming languages
  -- 'mattn/vim-gist' -- Easily create gists
  -- 'TimUntersberger/neogit' -- Magit clone for Neovim
  -- 'mattn/webapi-vim'
  -- 'nvim-treesitter/nvim-treesitter-refactor'
  -- 'jbyuki/instant.nvim' -- Collaborative editing in Neovim using built-in capabilities
  -- 'pwntester/octo.nvim' -- Edit and review GitHub issues and pull requests from the comfort of your favorite editor
  -- 'vim-test/vim-test' -- Run your tests at the speed of thought
  -- 'rcarriga/vim-ultest' -- The ultimate testing plugin for (Neo)Vim
  -- 'kabouzeid/nvim-lspinstall' -- Provides ':LspInstall' command to easily install language server protocols
  -- 'tamago324/nlsp-settings.nvim' -- A plugin for setting Neovim LSP with JSON files

  -- TODO:
  -- - Database integration
  -- - Github integration
  -- - Wrapper for tests
  -- - Simpler way to install language-servers
  -- - Live-server (bracey should handle this but it is not working)
  -- - Better emmet ('https://github.com/aca/emmet-ls' should handle this but it is not working very well)
  -- - Code lens

  -- Neovim lua guide:
  -- https://github.com/nanotee/nvim-lua-guide
  -- Awesome Neovim plugins:
  -- https://github.com/rockerBOO/awesome-neovim
end
)
