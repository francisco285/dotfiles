-- Alternative: 'simrat39/symbols-outline.nvim'
return {
  'liuchengxu/vista.vim',
  cmd = 'Vista',
  setup = function()
    local map = require('autoload.util').set_map
    map('n', '<Bslash>S', [[<Cmd>Vista<CR>]])
  end,
  config = function()
    vim.g['vista#renderer#enable_icon'] = 1
    vim.g.vista_disable_statusline = 1
    vim.g.vista_default_executive = 'nvim_lsp'
    vim.g.vista_echo_cursor_strategy = 'floating_win'
    vim.g.vista_executive_for = { markdown = 'toc' }
  end
}
