local config = {}

function config.telescope()
  local set_augroup = require('autoload.util').set_augroup

  set_augroup('Telescope', {
    { 'User', 'TelescopePreviewerLoaded', 'lua vim.wo.wrap, vim.wo.number = true, true' }
  })

  local actions = require('telescope.actions')
  require('telescope').setup({
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case'
      },
      prompt_prefix = '❯ ',
      selection_caret = '❯ ',
      prompt_position = 'top',
      winblend = 20,
      preview_cutoff = 0,
      width = 0.8,
      sorting_strategy = 'ascending',
      layout_strategy = 'horizontal',
      scroll_strategy = 'cycle',
      color_devicons = true,
      preview_cutoff = 0,
      file_sorter = require('telescope.sorters').get_fzy_sorter,
      layout_defaults = {
        horizontal = {
          preview_width = 0.6,
          width_padding = 0.08,
        },
        vertical = {
          preview_height = 0.4,
          width_padding = 0.08,
        }
      },
      mappings = {
        i = {
          ['<M-j>'] = actions.move_selection_next,
          ['<M-k>'] = actions.move_selection_previous,
          ['<C-x>'] = false,
          ['<M-s>'] = actions.select_horizontal,
          ['<M-v>'] = actions.select_vertical,
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
          ['<M-q>'] = actions.smart_send_to_qflist + actions.open_qflist
        },
        n = {
          ['<M-j>'] = actions.move_selection_next,
          ['<M-k>'] = actions.move_selection_previous,
          ['<C-x>'] = false,
          ['<M-s>'] = actions.select_horizontal,
          ['<M-v>'] = actions.select_vertical,
          ['q'] = actions.close,
          ['j'] = actions.move_selection_next,
          ['k'] = actions.move_selection_previous,
          ['<M-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
          ['gg'] = actions.move_to_top,
          ['G'] = actions.move_to_bottom
        }
      }
    }
  })
end

function config.emmet()
  vim.g.user_emmet_complete_tag = 0
  vim.g.user_emmet_install_global = 0
  vim.g.user_emmet_install_command = 0
  vim.g.user_emmet_mode = 'i'
end

function config.nvim_colorizer()
  require('colorizer').setup({
    '*',
    css = { css = true },
    html = { mode = 'foreground' }
  })
end

function config.vim_prettier()
  vim.g['prettier#autoformat_require_pragma'] = 0
end

function config.undotree()
  vim.g.undotree_SplitWidth = 40
  vim.g.undotree_SetFocusWhenToggle = 1
  vim.g.undotree_ShortIndicators = 1
  vim.g.undotree_HelpLine = 0
end

function config.vim_instant_markdown()
  vim.g.instant_markdown_autostart = 0
  vim.g.instant_markdown_browser = "$BROWSER --new-window"
end

function config.vim_floaterm()
  vim.g.floaterm_autoclose = 2
  vim.g.floaterm_title = 'Terminal $1/$2'
  vim.g.floaterm_borderchars = '─│─│╭╮╯╰'
  vim.g.floaterm_width = 0.9
  vim.g.floaterm_height = 0.9
  vim.g.floaterm_opener = 'tabe'

  vim.cmd([[highlight! link FloatermBorder TSFunction]])

  local set_augroup = require('autoload.util').set_augroup
  set_augroup('vim_floaterm', {
    { 'Colorscheme', '*', 'lua vim.cmd([[highlight! link FloatermBorder TSFunction]])' }
  })
end

function config.git_messenger()
  vim.g.git_messenger_no_default_mappings = 1
  vim.g.git_messenger_always_into_popup = 1
  vim.g.git_messenger_preview_mods = 'botright'
end

function config.committia()
  vim.g.committia_min_window_width = 0
end

function config.nvim_treesitter()
  vim.cmd([[set foldmethod=expr]])
  vim.cmd([[set foldexpr=nvim_treesitter#foldexpr()]])
  require('nvim-treesitter.configs').setup({
    highlight = {
      enable = true
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner'
        }
      },
      swap = {
        enable = true,
        swap_next = {
          ["]a"] = "@parameter.inner",
        },
        swap_previous = {
          ["[a"] = "@parameter.inner",
        }
      },
      move = {
        enable = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer"
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer"
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer"
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer"
        }
      }
    },
    rainbow = {
      enable = true
    },
    ensure_installed = { 'lua', 'json' }
  })
end

function config.vista()
  vim.g['vista#renderer#enable_icon'] = 1
  vim.g.vista_disable_statusline = 1
  vim.g.vista_default_executive = 'nvim_lsp'
  vim.g.vista_echo_cursor_strategy = 'floating_win'
  vim.g.vista_executive_for = { markdown = 'toc' }
end

function config.far()
  vim.g['far#source'] = 'rg'
end

function  config.nvcode_color_schemes()
  vim.g.nvcode_termcolors = 256
  vim.cmd([[colorscheme palenight]])
end

function config.nvim_bufferline()
  require('bufferline').setup({
    options = {
      view = 'multiwindow',
      numbers = 'ordinal',
      number_style = '',
      mappings = false,
      buffer_close_icon= '',
      modified_icon = '',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      max_name_length = 18,
      max_prefix_length = 15,
      tab_size = 18,
      diagnostics = 'nvim_lsp',
      show_buffer_close_icons = true,
      always_show_bufferline = true
    }
  })
end

function config.nvim_tree()
  vim.g.nvim_tree_follow = 1
  vim.g.nvim_tree_hide_dotfiles = 1
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_quit_on_open = 1
  local tree_cb = require('nvim-tree.config').nvim_tree_callback
  vim.g.nvim_tree_bindings = {
    ['<CR>']           = tree_cb('edit'),
    ['l']              = tree_cb('edit'),
    ['o']              = tree_cb('edit'),
    ['<2-LeftMouse>']  = tree_cb('edit'),
    ['<2-RightMouse>'] = tree_cb('cd'),
    ['<C-]>']          = tree_cb('cd'),
    ['v']              = tree_cb('vsplit'),
    ['s']              = tree_cb('split'),
    ['<C-t>']          = tree_cb('tabnew'),
    ['h']              = tree_cb('close_node'),
    ['<BS>']           = tree_cb('close_node'),
    ['<S-CR>']         = tree_cb('close_node'),
    ['<Tab>']          = tree_cb('preview'),
    ['I']              = tree_cb('toggle_ignored'),
    ['H']              = tree_cb('toggle_dotfiles'),
    ['R']              = tree_cb('refresh'),
    ['a']              = tree_cb('create'),
    ['d']              = tree_cb('remove'),
    ['r']              = tree_cb('rename'),
    ['<C-r>']          = tree_cb('full_rename'),
    ['x']              = tree_cb('cut'),
    ['c']              = tree_cb('copy'),
    ['p']              = tree_cb('paste'),
    ['[c']             = tree_cb('prev_git_item'),
    [']c']             = tree_cb('next_git_item'),
    ['-']              = tree_cb('dir_up'),
    ['q']              = tree_cb('close')
  }
  vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
     unstaged = 'A',
     staged = 'A',
     unmerged = 'U',
     renamed = 'R',
     untracked = '?'
    }
  }
end

function config.nvim_compe()
  require('compe').setup({
    enabled = true,
    debug = false,
    min_length = 1,
    preselect = 'disable',
    allow_prefix_unmatch = false,
    max_abbr_width = 50,
    max_kind_width = 50,
    max_menu_width = 50,
    source = {
      -- Common: ~
      path   = true,  -- Path completion.
      -- path = {
      --   kind = ''
      -- },
      buffer = true,  -- Buffer completion.
      tags   = true,  -- Tag completion.
      spell  = true,  -- Spell file completion.
      calc   = true,  -- Lua math expressions.
      omni   = false, -- Omni completion. (Warning: It has a lot of side-effect.)
      emoji  = true,  -- Emoji completion.

      -- Neovim-specific: ~
      nvim_lsp = true, -- Neovim's builtin LSP completion.
      nvim_lua = true, -- Neovim's Lua "stdlib" completion.

      -- External plugins: ~
      -- Completion for external plugins.
      -- Make sure you have the corresponding plugin installed.
      vim_lsp         = false, -- vim-lsp completion.
      vim_lsc         = false, -- vim-lsc completion.
      vsnip           = true, -- vim-vsnip completion.
      ultisnips       = false, -- UltiSnips completion.
      snippets_nvim   = false, -- snippets.nvim completion.
      nvim_treesitter = true   -- nvim-treesitter completion.
    }
  })
end

function config.gitsigns()
  require('plugin.functions').gitsigns.set_colors()

  local set_augroup = require('autoload.util').set_augroup
  set_augroup('GitSignsColors', {
    { 'ColorScheme', '*', [[lua require('plugin.functions').gitsigns.set_colors()]] }
  })

  require('gitsigns').setup({
    signs = {
      add          = { hl = 'GitSignsAdd'   , text = '│' },
      change       = { hl = 'GitSignsChange', text = '│' },
      changedelete = { hl = 'GitSignsChangeDelete', text = '│' },
      delete       = { hl = 'GitSignsDelete', text = '│' },
      topdelete    = { hl = 'GitSignsTopDelete', text = '│' },
    }
  })
end

function config.nvim_lightbulb()
  local set_augroup = require('autoload.util').set_augroup

  set_augroup('lightbulb', {
    { 'CursorHold,CursorHoldI', '*', [[lua require('nvim-lightbulb').update_lightbulb()]] }
  })
end

function config.nvim_lspconfig()
  local lsp = require('lspconfig')

  -- Enable (broadcasting) snippet capability for completion
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- Note: it looks like there's actually a difference between using
  -- 'lspconfig/configs' and using 'lspconfig.configs' here, it only works when
  -- a / is used
  require('lspconfig/configs').emmet_ls = {
    default_config = {
      cmd = { 'emmet-ls', '--stdio' },
      filetypes = { 'html', 'css' },
      root_dir = function()
        return vim.loop.cwd()
      end,
      settings = {}
    }
  }

  local language_servers = {
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
    html = { capabilities = capabilities },
    -- This language server is not documented in CONFIG.md, here is the link:
    -- https://github.com/aca/emmet-ls
    emmet_ls = { on_attach = on_attach }
  }

  local on_attach = function(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec([[
      highlight! link LspReferenceRead Pmenu
      highlight! link LspReferenceText Pmenu
      highlight! link LspReferenceWrite Pmenu

      " TODO: Find a way to adapt it to use require('autoload.util').set_augroup
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> silent! lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()
      augroup END
      ]], false)
    end
  end

  for language_server, setup in pairs(language_servers) do
    if setup.on_attach == nil then
      setup.on_attach = on_attach
    end
    lsp[language_server].setup(setup)
  end

  function _G.reload_lsp()
    vim.lsp.stop_client(vim.lsp.get_active_clients())
    vim.cmd([[edit]])
  end

  function _G.open_lsp_log()
    local path = vim.lsp.get_log_path()
    vim.cmd('edit ' .. path)
  end

  vim.cmd([[command! -nargs=0 LspLog call v:lua.open_lsp_log()]])
  vim.cmd([[command! -nargs=0 LspRestart call v:lua.reload_lsp()]])

  vim.fn.sign_define('LspDiagnosticsSignError', { texthl = 'LspDiagnosticsSignError', text = '', numhl = 'LspDiagnosticsSignError' })
  vim.fn.sign_define('LspDiagnosticsSignWarning', { texthl = 'LspDiagnosticsSignWarning', text = '', numhl = 'LspDiagnosticsSignWarning' })
  vim.fn.sign_define('LspDiagnosticsSignInformation', { texthl = 'LspDiagnosticsSignInformation', text = '', numhl = 'LspDiagnosticsSignInformation' })
  vim.fn.sign_define('LspDiagnosticsSignHint', { texthl = 'LspDiagnosticsSignHint', text = '', numhl = 'LspDiagnosticsSignHint' })
end

function config.lualine()
  local function get_hl_fg(hl_name)
    local utils = require('lualine.utils.utils')
    return utils.extract_highlight_colors(hl_name, 'guifg')
  end
  require('lualine').setup({
    options = {
      theme = 'material',
      section_separators = {'', ''},
      component_separators = {'│', '│'},
      icons_enabled = true
    },
    sections = {
      -- lualine_a = { { 'mode', upper = true } },
      lualine_a = { { function() return ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t') end } },
      lualine_b = { { 'branch', icon = '' }, {
        'diff',
        color_added = '#00FF00',
        color_modified = '#FFA500',
        color_removed = '#FF0000',
        symbols = {
          added = '+', modified = '~', removed = '-'
        }
      } },
      lualine_c = { {
        'diagnostics',
        sources = { 'nvim_lsp' },
        color_error = '#F00000',
        color_warn = '#FFA500',
        color_info = '#ADD8E6'
      } },
      lualine_x = {
        'encoding',
        'fileformat',
        'filetype',
        function()
          local get_option = vim.api.nvim_buf_get_option
          return (get_option(0, 'expandtab') and 'Spaces: ' or 'Tabs: ') .. get_option(0, 'shiftwidth')
        end
      },
      lualine_y = {
        function()
          -- https://github.com/glepnir/galaxyline.nvim/blob/505bd8a2912f75b3c9cc439db3bd31ae514230cd/lua/galaxyline/provider_lsp.lua#L2-L16
          local msg = 'No Active LSP'

          local buf_ft = vim.api.nvim_buf_get_option(0,'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end

          local blacklisted_clients = { emmet_ls = true }
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes,buf_ft) ~= -1 then
              if blacklisted_clients[client.name] == nil then
                return ' ' .. client.name
              end
            end
          end

          return msg
        end
      },
      lualine_z = { 'location' }
    },
    inactive_sections = {
      lualine_a = { 'filename' },
      lualine_b = { },
      lualine_c = { },
      lualine_x = { },
      lualine_y = { },
      lualine_z = { 'location' }
    },
    extensions = { }
  })
end

function config.blamer()
  vim.g.blamer_enabled = 1
  vim.g.blamer_show_in_insert_modes = 0
  vim.g.blamer_delay = 500
  vim.g.blamer_prefix = ' '
  vim.g.blamer_relative_time = 1
end

function config.dashboard()
  vim.g.dashboard_default_executive = 'telescope'
  vim.g.dashboard_custom_shortcut = {
    book_marks         = '1',
    change_colorscheme = '2',
    find_file          = '3',
    find_history       = '4',
    find_word          = '5',
    last_session       = '6',
    new_file           = '7',
  }
  vim.g.dashboard_custom_header = {
    ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
    ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
    ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
    ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
    ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
    ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝'
  }
end

function config.vim_which_key()
  vim.g.which_key_max_size = 5
  vim.g.which_key_align_by_seperator = 1
  vim.g.which_key_hspace = 1
  vim.g.which_key_use_floating_win = 0

  vim.g.which_key_timeout = 100
  vim.g.which_key_display_names = { ['<CR>'] = '↵', ['<TAB>'] = '⇆', [' '] = '␣' }

  vim.g.which_key_map = {
    ['0'] = 'which_key_ignore',
    ['1'] = 'which_key_ignore',
    ['2'] = 'which_key_ignore',
    ['3'] = 'which_key_ignore',
    ['4'] = 'which_key_ignore',
    ['5'] = 'which_key_ignore',
    ['6'] = 'which_key_ignore',
    ['7'] = 'which_key_ignore',
    ['8'] = 'which_key_ignore',
    ['9'] = 'which_key_ignore'
  }

  vim.fn['which_key#format']('<Cmd>')

  vim.fn['which_key#register']('<Space>', 'g:which_key_map')
end

function config.vim_smoothie()
  vim.g.smoothie_update_interval = 60
end

function config.registers()
  vim.g.registers_tab_symbol = '⇆'
  vim.g.registers_space_symbol = '␣'
end

function config.numb()
  require('numb').setup()
end

return config
