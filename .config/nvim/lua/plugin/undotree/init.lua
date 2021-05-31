return {
  'mbbill/undotree',
  cmd = 'UndotreeToggle',
  setup = function()
    local map = require('autoload.util').set_map
    map('n', '<Leader>u', [[<Cmd>UndotreeToggle<CR>]])
  end,
  config = function()
    vim.g.undotree_SplitWidth = 40
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_ShortIndicators = 1
    vim.g.undotree_HelpLine = 0
  end
}
