local config = {}

function config.telescope()
  vim.api.nvim_exec([[
  augroup Telescope
    autocmd!
    autocmd User TelescopePreviewerLoaded lua vim.wo.wrap, vim.wo.number = true, true
  augroup END
  ]], false)

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
  vim.g.floaterm_width = 0.9
  vim.g.floaterm_height = 0.9
  vim.cmd('highlight! link FloatermBorder TSFunction')
end

function config.git_messenger()
  vim.g.git_messenger_no_default_mappings = 1
  vim.g.git_messenger_always_into_popup = 1
  vim.g.git_messenger_preview_mods = 'botright'
end

function config.committia()
  vim.g.committia_min_window_width = 0
end

function config.vimspector()
  vim.cmd([[command! VimspectorConfig lua vim.cmd('edit' .. vim.fn.getcwd() .. require('autoload.util').join_paths('vimspector', '.vimspector.json']])
end

function config.nvim_treesitter()
  vim.api.nvim_command('set foldmethod=expr')
  vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
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

function config.zephyr_nvim()
  vim.cmd('colorscheme zephyr')
  vim.cmd('highlight Normal guibg=#0F111A')
  vim.cmd('highlight NormalFloat guibg=#0F111A')
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

function config.galaxyline()
  -- REFERENCE: https://github.com/ChristianChiarulli/nvim/blob/ceb88951b034e5367e9adf7929c3dde601f76e09/lua/plugins/galaxyline-config.lua

  local condition = require('galaxyline.condition')

  local buffer_not_empty = function()
    if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
      return true
    end
    return false
  end

  local checkwidth = function()
    local squeeze_width  = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
      return true
    end
    return false
  end

  -- https://vi.stackexchange.com/a/12294
  local function return_highlight_term(group, term)
    local fn = vim.fn
    local output = fn.execute('silent! hi ' .. group)
    local result = fn.matchstr(output, term .. [[=\zs\S*]])
    return result == '' and 'None' or result
  end

  if not packer_plugins['nvim-lspconfig'].loaded then
    vim.cmd([[packadd nvim-lspconfig]])
  end

  local colors = {
    bg = return_highlight_term('StatusLine', 'guibg'),
    fg = return_highlight_term('CursorLineNr', 'guifg'),
    separator = return_highlight_term('Normal', 'guibg'),
    error = '#e95678',
    warn = '#f0c674',
    hint = '#36d0e0',
    info = '#42a8ed'
  }

  local separator = ' │ '

  local components_left = {
    {
      CWD = {
        provider = function() return vim.fn.fnamemodify(vim.fn.getcwd(), ':t') end,
        icon = '   ',
        separator = ' ',
        separator_highlight = { colors.bg, colors.fg },
        highlight = { colors.bg, colors.fg, 'bold' },
      }
    },
    {
      GitBranch = {
        provider = 'GitBranch',
        icon = '  ',
        condition = condition.check_git_workspace,
        highlight = { colors.fg, colors.bg }
      }
    },
    {
      DiagnosticError = {
        provider = 'DiagnosticError',
        icon = ' ',
        highlight = { colors.error, colors.bg }
      }
    },
    {
      DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = { colors.warn, colors.bg }
      }
    },
    {
      DiagnosticHint = {
        provider = 'DiagnosticHint',
        icon = '   ',
        highlight = { colors.hint, colors.bg }
      }
    },
    {
      DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = '  ',
        highlight = { colors.info, colors.bg }
      }
    }
  }

  local components_right = {
    {
      Indentation = {
        provider = function() return '' end,
        separator = '%{printf("%s %s", &tabstop, &expandtab ? (&tabstop == 1 ? "Space" : "Spaces") : (&tabstop == 1 ? "Tab" : "Tabs"))}',
        separator_highlight = { colors.fg, colors.bg }
      }
    },
    {
      FileFormat = {
        provider = 'FileFormat',
        separator = ' │ ',
        separator_highlight = { colors.separator, colors.bg },
        highlight = { colors.fg, colors.bg }
      }
    },
    {
      LineInfo = {
        provider = 'LineColumn',
        separator = ' │ ',
        separator_highlight = { colors.separator, colors.bg },
        highlight = { colors.fg, colors.bg }
      }
    },
    {
      PerCent = {
        provider = 'LinePercent',
        separator = ' │',
        separator_highlight = { colors.separator, colors.bg },
        highlight = { colors.fg, colors.bg }
      }
    }
  }

  local galaxyline = require('galaxyline')

  for index, value in ipairs(components_left) do
    galaxyline.section.left[index] = value
  end

  for index, value in ipairs(components_right) do
    galaxyline.section.right[index] = value
  end
end

function config.nvim_compe()

  vim.api.nvim_exec([[
  augroup trigger_completion
    autocmd!
    autocmd InsertEnter * silent! call compe#complete()
  augroup END
  ]], false)

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
      vsnip           = false, -- vim-vsnip completion.
      ultisnips       = false, -- UltiSnips completion.
      snippets_nvim   = false, -- snippets.nvim completion.
      nvim_treesitter = true   -- nvim-treesitter completion.

    }
  })
end

function config.gitsigns()
  vim.api.nvim_exec([[
     function! GitSignsColors()
         highlight GitSignsAdd          guifg=#00FF00 guibg=None ctermfg=Green  ctermbg=None
         highlight GitSignsChange       guifg=#FF7700 guibg=None ctermfg=Yellow ctermbg=None
         highlight GitSignsChangeDelete guifg=#0000FF guibg=None ctermfg=Blue   ctermbg=None
         highlight GitSignsDelete       guifg=#FF0000 guibg=None ctermfg=Red    ctermbg=None
         highlight GitSignsTopDelete    guifg=#FF0000 guibg=None ctermfg=Red    ctermbg=None
     endfunction

     call GitSignsColors()

     augroup GitSignsColors
         autocmd!
         autocmd ColorScheme * call GitSignsColors()
     augroup END
  ]], false)

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
  vim.api.nvim_exec([[
  augroup lightbulb
    autocmd!
    autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()
  augroup END
  ]], false)
end

function config.nvim_lspconfig()
  local lsp = require('lspconfig')

  -- html
  -- Enable (broadcasting) snippet capability for completion
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local language_servers = {
    clangd = {},
    html = { capabilities = capabilities },
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
    }
  }

  local on_attach = function(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec([[
      hi! link LspReferenceRead Pmenu
      hi! link LspReferenceText Pmenu
      hi! link LspReferenceWrite Pmenu
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
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

return config
