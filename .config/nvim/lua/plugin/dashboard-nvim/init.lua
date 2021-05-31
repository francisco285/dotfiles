return {
  'glepnir/dashboard-nvim',
  setup = function()
    vim.g.dashboard_default_executive = 'telescope'
    local map = require('autoload.util').set_map
    map('n', '<Bslash>ss', '<Cmd>SessionSave<CR>')
    map('n', '<Bslash>sl', '<Cmd>SessionLoad<CR>')
  end,
  config = function()
    local util = require('autoload.util')
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

    local map_strings = {
      [[lua vim.api.nvim_buf_set_keymap(0, 'n', '1', '<Cmd>DashboardJumpMark<CR>', {})]],
      [[lua vim.api.nvim_buf_set_keymap(0, 'n', '2', '<Cmd>DashboardChangeColorscheme<CR>', {})]],
      [[lua vim.api.nvim_buf_set_keymap(0, 'n', '3', '<Cmd>DashboardFindFile<CR>', {})]],
      [[lua vim.api.nvim_buf_set_keymap(0, 'n', '4', '<Cmd>DashboardFindHistory<CR>', {})]],
      [[lua vim.api.nvim_buf_set_keymap(0, 'n', '5', '<Cmd>DashboardFindWord<CR>', {})]],
      [[lua vim.api.nvim_buf_set_keymap(0, 'n', '6', '<Cmd>SessionLoad<CR>', {})]],
      [[lua vim.api.nvim_buf_set_keymap(0, 'n', '7', '<Cmd>DashboardNewFile<CR>', {})]],
      [[lua vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<Cmd>quit<CR>', {})]]
    }

    local augroup_table = {}
    for _, map in ipairs(map_strings) do
      table.insert(augroup_table, { 'FileType', 'dashboard', map })
    end

    util.set_augroup('dashboard_buf_maps', augroup_table)
  end
}
