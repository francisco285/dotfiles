local util = require('autoload.util')
local set_augroups = util.set_augroups

set_augroups({
  diff = {
    { 'FileType', 'diff', [[lua require('autoload.autocmd').diff()]] }
  },

  text = {
    { 'FileType', 'text', [[lua require('autoload.autocmd').text()]] }
  },

  remember_cursor_position = {
    { 'BufReadPost', '*', [[lua require('autoload.autocmd').remember_cursor_position()]] }
  },

  terminal_autoinsert = {
    { 'TermOpen', '*', [[lua require('autoload.autocmd').terminal_autoinsert()]] }
  },

  buf_auto_delete = {
    { 'BufLeave,WinLeave', '*', [[lua require('autoload.autocmd').buf_auto_delete()]] }
  },

  yank_highlight = {
    { 'TextYankPost', '*', [[lua require('autoload.autocmd').yank_highlight()]] }
  },

  custom_highlight_groups = {
    { 'Colorscheme', '*', [[lua require('autoload.autocmd').set_custom_highlight_groups()]] }
  },

  auto_fill_location_list = {
    -- https://www.youtube.com/watch?v=IoyW8XYGqjM
    { 'BufWrite,BufEnter,InsertLeave', '*', [[lua require('autoload.autocmd').auto_fill_location_list()]] }
  },

  smart_cursorline = {
    { 'InsertEnter,WinLeave', '*', [[lua vim.wo.cursorline = false]] },
    { 'InsertLeave,WinEnter', '*', [[lua vim.wo.cursorline = true]] },
  }
})
