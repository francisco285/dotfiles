-- Global options. These are expected to be avaiable for all the other files
return {
  mapleader = ' ',
  vim_options = {
    background = 'dark',
    backup = false,
    belloff = 'all',
    clipboard = 'unnamed,unnamedplus',
    cmdheight = 1,
    colorcolumn = '80',
    completeopt = 'menuone,noselect',
    confirm = true,
    cursorline = false,
    expandtab = true,
    fillchars = [[vert:│,eob:\ ,fold:\━,foldsep:\│,foldopen:,foldclose:]],
    -- foldcolumn = 'auto',
    foldenable = true,
    foldlevelstart = 99,
    foldmethod = 'marker',
    foldtext = (function()
      function MyFoldText()
        local foldstart = vim.v.foldstart
        local foldend = vim.v.foldend
        -- local folddashes = vim.v.folddashes

        local lines_count = (foldend - foldstart) + 1
        local line = vim.fn.getline(foldstart)
        -- local foldlevel = #folddashes

        return string.format('%s  (%s ℓ)  ', line, lines_count)
      end
      return 'v:lua.MyFoldText()'
    end)(),
    hidden = true,
    hlsearch = true,
    ignorecase = true,
    smartcase = true,
    inccommand = 'nosplit',
    joinspaces = false,
    langmenu = 'en_US-UTF-8',
    lazyredraw = false,
    list = true,
    listchars = 'tab:┣━,nbsp:+,trail:␣,extends:→,precedes:←',
    matchpairs = '(:),{:},[:],<:>',
    mouse = 'a',
    number = true,
    pumblend = 20,
    pumheight = 15,
    relativenumber = true,
    report = 0,
    ruler = false,
    scrolloff = 8,
    selection = 'exclusive',
    shiftwidth = 2,
    shortmess = 'filmnrwxoOtcF',
    showbreak = '↳',
    showmode = true,
    showtabline = 2,
    sidescrolloff = 5,
    -- Value of signcolumn must be changed to `yes` in the `on_attach` function
    -- when using LSP, this way the value is changed only for buffers that have
    -- LSP active
    signcolumn = 'auto',
    smartindent = true,
    softtabstop = 2,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 2,
    termguicolors = true,
    timeout = true,
    timeoutlen = 400,
    undodir = (function()
      local undodir = vim.fn.expand(vim.fn.stdpath('cache') .. '/undo')
      if vim.fn.isdirectory(undodir) == 0 then
        vim.fn.mkdir(undodir, 'p')
      end
      return undodir
    end)(),
    undofile = true,
    updatetime = 300,
    virtualedit = 'block',
    wildcharm = '<Tab>',
    wildignore = '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,*.DS_Store,node_modules/**,bower_modules/**,__pycache__/**',
    wildignorecase = true,
    winblend = 0,
    wrap = false,
    writebackup = false
  },
  filetype_options = {
    cursorline = {
      { value = true, filetypes = { 'packer', 'undotree', 'NvimTree', 'dashboard', 'qf', 'Trouble' } }
    },
    cursorcolumn = {
      { value =  false, filetypes = { 'packer', 'undotree', 'NvimTree', 'dashboard', 'qf', 'Trouble' } }
    },
    showtabline = {
      { value = 0, filetypes = { 'dashboard' } }
    },
    laststatus = {
      { value = 0, filetypes = { 'dashboard' } }
    },
    colorcolumn = {
      { value = '', filetypes = { 'packer', 'undotree', 'NvimTree', 'qf', 'Trouble' } }
    },
    hlsearch = {
      { value = false, filetypes = { 'TelescopePrompt' } }
    }
  },
  ui = {
    -- floating|tab|default
    packer_display_style = 'floating',
    floating = {
      border_chars = {
        style = 'round',
        styles = {
          round = {
            top = '─', right = '│', bottom = '─', left = '│',
            top_left = '╭', top_right = '╮', bottom_right = '╯', bottom_left = '╰'
          },
          single = {
            top = '─', right = '│', bottom = '─', left = '│',
            top_left = '┌', top_right = '┐', bottom_right = '┘', bottom_left = '└'
          },
          double = {
            top = '═', right = '║', bottom = '═', left = '║',
            top_left = '╔', top_right = '╗', bottom_right = '╝', bottom_left = '╚'
          }
        }
      },
    }
  },
  treesitter = {
    enable_fold = true,
    setup = {
      ensure_installed = { 'lua' },
      rainbow = { enable = true },
      -- Built-in Textobjects
      -- @block.inner
      -- @block.outer
      -- @call.inner
      -- @call.outer
      -- @class.inner
      -- @class.outer
      -- @comment.outer
      -- @conditional.inner
      -- @conditional.outer
      -- @frame.inner
      -- @frame.outer
      -- @function.inner
      -- @function.outer
      -- @loop.inner
      -- @loop.outer
      -- @parameter.inner
      -- @parameter.outer
      -- @scopename.inner
      -- @statement.outer
      textobjects = {
        -- Define your own text objects mappings similar to ip (inner
        -- paragraph) and ap (a paragraph).
        select = {
          enable = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['aC'] = '@comment.outer',
            -- These are better handled by targets
            -- ['ab'] = '@block.outer',
            -- ['ib'] = '@block.inner',
            -- ['aa'] = '@parameter.outer',
            -- ['ia'] = '@parameter.inner',
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner'
          }
        },
        -- Define your own mappings to swap the node under the cursor with the
        -- next or previous one, like function parameters or arguments.
        swap = {
          enable = true,
          swap_previous = { ['[a'] = '@parameter.inner' },
          swap_next = { [']a'] = '@parameter.inner' }
        },
        -- Define your own mappings to jump to the next or previous text
        -- object. This is similar to ]m, [m, ]M, [M Neovim's mappings to jump
        -- to the next or previous function.
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer", ["]]"] = "@class.outer"
          },
          goto_next_end = {
            ["]M"] = "@function.outer", ["]["] = "@class.outer"
          },
          goto_previous_start = {
            ["[m"] = "@function.outer", ["[["] = "@class.outer"
          },
          goto_previous_end = {
            ["[M"] = "@function.outer", ["[]"] = "@class.outer"
          }
        }
      }
    }
  },
  lsp = {
    signs = { error = '', warning = '', info = '', hint = '' },
    kinds = { with_text = true, use_codicons = true, override = {} },
    diagnostic = {
      on_publish_diagnostics = {
        underline = true,
        virtual_text = {
          spacing = 2, severity_limit = 'Warning', prefix = '●'
        },
        signs = true,
        update_in_insert = false
      }
    },
    configs = {
      clangd = {},
      jedi_language_server = {},
      cssls = {},
      tsserver = {},
      jsonls = {
        commands = {
          Format = {
            function()
              vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
            end
          }
        }
      },
      html = {},
      -- This language server is not included in CONFIG.md: https://github.com/aca/emmet-ls
      -- Install Command: npm install -g emmet-ls
      emmet_ls = {},
      -- TODO: Check out https://gist.github.com/folke/fe5d28423ea5380929c3f7ce674c41d8
      -- https://www.reddit.com/r/neovim/comments/naig9y/correct_sumneko_lua_lsp_setup_for_initlua_and/
      lua = {
        settings = {
          Lua = {
            runtime = {
              -- LuaJIT in the case of Neovim
              version = 'LuaJIT',
              path = vim.split(package.path, ';')
            },
            diagnostics = {
              -- Get the language server to recognize some global variables
              globals = { 'vim', 'packer_plugins', 'O' }
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
              }
            }
          }
        }
      }
    }
  },
  colorscheme = 'tokyonight',
  statusline = {
    colorscheme = 'tokyonight',
    style = 'thin',
    styles = {
      no_separators = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
      },
      thin = {
        -- Sections should be identified by their respective highlights
        section_separators = { left = '', right = '' },
        component_separators = { left = '│', right = '│' }
      },
      round = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
      },
      powerline = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
      },
      slant_up = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
      },
      slant_down = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' }
      }
    }
  },
  disable_builtin_plugins = {
    '2html_plugin',
    'getscript',
    'getscriptPlugin',
    'gzip',
    'logiPat',
    'matchit',
    -- 'matchparen',
    -- NOTE: netrw is needed for some builtin features to work properly, such
    -- as `gx` (`:help gx`) or automatically prompting and downloading missing
    -- spell files when using `:set spelllang=<lang>`
    -- 'netrwPlugin',
    'rrhelper',
    'tar',
    'tarPlugin',
    'vimball',
    'vimballPlugin',
    'zip',
    'zipPlugin'
  },
  enable_plugins = {
    'packer',
    'telescope',
    'telescope-fzy-native',
    'telescope-asynctasks',
    -- 'emmet-vim',
    -- NOTE: If this PR (https://github.com/neovim/neovim/pull/13654) ever gets
    -- merged, it has a lot of potentital to replace this plugin
    'nvim-colorizer',
    -- 'neoformat',
    -- 'undotree',
    -- 'markdown-preview',
    'vim-floaterm',
    -- 'git-messenger',
    -- 'committia',
    -- 'vimspector',
    'nvim-treesitter',
    'nvim-ts-rainbow',
    -- 'vista',
    -- 'nvim-spectre',
    'tokyonight',
    -- 'material',
    'nvim-bufferline',
    'nvim-tree',
    'nvim-lspconfig',
    'lspsaga',
    -- 'goto-preview', -- Experimental (may replace lspsaga's preview_definition)
    'nvim-compe',
    'lspkind-nvim',
    'lsp_signature',
    'nvim-lightbulb',
    -- 'NrrwRgn',
    -- 'editorconfig-vim',
    'vim-fugitive',
    'tcomment_vim',
    -- 'vim-be-good',
    'gitsigns',
    'vim-maximizer',
    'vim-surround',
    -- 'vim-abolish',
    'lualine',
    -- 'codi',
    -- 'blamer',
    -- 'dashboard-nvim',
    'which-key',
    -- 'vim-smoothie',
    'zen-mode',
    'targets',
    'vim-sonictemplate',
    'trouble',
    -- 'diffview',
    'lsp-colors',
    -- 'HighStr',
    -- 'nvim-autopairs',
    -- 'vim-gist',
    -- 'indent-blankline',
    -- 'nvim-ts-autotag',
    -- 'bracey',
    'nvim-bqf',
    'firenvim',
    'nvim-lspinstall',
    'todo-comments',
    -- 'lsp-status',
    -- 'ultisnips',
    -- 'octo',
    'asyncrun',
    'asynctasks',
    -- 'nvim-scrollview',
    -- 'vim-doge',
    'vim-localvimrc',
    'nvim-treesitter-textobjects',
    'gruvbox'

    -- Other plugins:
    -- 'yamatsum/nvim-nonicons'
    -- 'AndrewRadev/splitjoin.vim'
    -- 'romgrk/nvim-treesitter-context'
    -- 'bfredl/nvim-miniyank'
    -- 'monaqa/dial.nvim'
    -- 'AndrewRadev/sideways.vim'
    -- 'rhysd/conflict-marker.vim'
    -- 'AndrewRadev/linediff.vim'
    -- 'AndrewRadev/switch.vim'

    -- Not tested:
    -- 'nvim-treesitter/nvim-tree-docs' -- May replace vim-doge
    -- 'nvim-telescope/telescope-project.nvim'
    -- (dap) -- May replace vimspector
      -- 'mfussenegger/nvim-dap'
      -- 'Pocco81/DAPInstall.nvim'
      -- 'theHamsta/nvim-dap-virtual-text'
      -- 'rcarriga/nvim-dap-ui'
      -- 'mfussenegger/nvim-jdtls'
      -- 'mfussenegger/nvim-dap-python'

    -- TODO: Enhancement, features, and more:
    -- - Consistent signs AND highlight groups across lspconfig, trouble.nvim, lualine, etc...
    -- - Collaborative editing
    --   - use('jbyuki/instant.nvim') -- Collaborative editing in Neovim using built-in capabilities
    --   - https://floobits.com/help/plugins/nvim
    -- - Better emmet ('aca/emmet-ls' should handle this but it is not working very well)
    -- - Plugin for taking notes
    --   - use('vhyrro/neorg') -- Sort of org-mode for Neovim (not usable yet for end-users)
    --   - use('marcushwz/nvim-workbench')
    -- - LSP Enhancement
    --   - Code lens
    --      - Maybe these links can help:
    --        - https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_codeLens
    --        - https://github.com/neovim/neovim/pull/13165
    --          - More specifically this comment: https://github.com/neovim/neovim/pull/13165#issuecomment-739505204
    --        - https://github.com/jubnzv/virtual-types.nvim/
    --        - https://github.com/neovim/neovim/pull/14056
    --        - https://github.com/josa42/nvim-lsp-codelenses/blob/2a29e040d0d3b7f6564a797feb644358d5069cad/lua/jg/lsp/codelenses.lua
    -- - Database integration
    --   - use('tpope/vim-dadbod')
    --   - use('kristijanhusak/vim-dadbod-ui')
    --   - use('kristijanhusak/vim-dadbod-completion')
    -- - Wrapper for tests
    --   - use('vim-test/vim-test') -- Run your tests at the speed of thought
    --   - use('rcarriga/vim-ultest') -- The ultimate testing plugin for (Neo)Vim
    -- Misc
    --   - use('codota/tabnine-vim') -- Advanced AI based autocomplete for all programming languages

    -- Awesome Neovim plugins:
    -- https://github.com/rockerBOO/awesome-neovim
  }
}
