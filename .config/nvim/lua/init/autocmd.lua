local util = require('autoload.util')
local set_augroups = util.set_augroups

set_augroups({
  remember_cursor_position = {
    { 'BufReadPost', '*', [[lua require('autoload.init.autocmd').remember_cursor_position()]] }
  },

  terminal_autoinsert = {
    { 'TermOpen', '*', [[lua require('autoload.init.autocmd').terminal_autoinsert()]] }
  },

  buf_auto_delete = {
    { 'BufLeave,WinLeave', '*', [[lua require('autoload.init.autocmd').buf_auto_delete()]] }
  },

  yank_highlight = {
    { 'TextYankPost', '*', [[lua require('autoload.init.autocmd').yank_highlight()]] }
  },

  custom_highlight_groups = {
    { 'Colorscheme', '*', [[lua require('autoload.init.autocmd').set_custom_highlight_groups()]] }
  },

  lsp_set_loclist = {
    { 'User', 'LspDiagnosticsChanged', [[lua vim.lsp.diagnostic.set_loclist({ open_loclist = false })]] },
    { 'BufEnter,BufWinEnter', '*', [[lua vim.lsp.diagnostic.set_loclist({ open_loclist = false })]] }
  }
})
