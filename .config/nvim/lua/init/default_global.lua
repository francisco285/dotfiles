-- Global options. These are expected to be avaiable for other files
return {
  mapleader = '',
  vim_options = {},
  filetype_options = {},
  ui = {
    -- floating|tab|default
    packer_display_style = 'tab',
    floating = {
      border = {
        style = 'single',
        styles = {
          single = {
            top_left = '┌',
            top = '─',
            top_right = '┐',
            right = '│',
            bottom_right = '┘',
            bottom = '─',
            bottom_left = '└',
            left = '│'
          },
          double = {
            top_left = '╔',
            top = '═',
            top_right = '╗',
            right = '║',
            bottom_right = '╝',
            bottom = '═',
            bottom_left = '╚',
            left = '║'
          }
        }
      }
    }
  },
  treesitter = {
    enable_fold = false,
    setup = {
      highlight = { enable = true },
      ensure_installed = {}
    }
  },
  lsp = {
    signs = {
      error = 'E', warning = 'W', info = 'I', hint = 'H'
    },
    kinds = {
      with_text = true,
      use_codicons = false,
      override = {}
    },
    diagnostic = {
      on_publish_diagnostics = {}
    },
    configs = {}
  },
  colorscheme = 'default',
  statusline = {
    colorscheme = 'gruvbox',
    style = 'thin',
    styles = {
      thin = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' }
      }
    }
  },
  disable_builtin_plugins = {
    ['2html_plugin']    = false,
    ['getscript']       = false,
    ['getscriptPlugin'] = false,
    ['gzip']            = false,
    ['logiPat']         = false,
    ['matchit']         = false,
    ['matchparen']      = false,
    -- NOTE: netrw is needed for some builtin features to work properly, such
    -- as `gx` (`:help gx`) or automatically prompting and downloading missing
    -- spell files when using `:set spelllang=<lang>`
    ['netrwPlugin']     = false,
    ['rrhelper']        = false,
    ['tar']             = false,
    ['tarPlugin']       = false,
    ['vimball']         = false,
    ['vimballPlugin']   = false,
    ['zip']             = false,
    ['zipPlugin']       = false
  },
  enable_plugins = { 'packer' }
}
