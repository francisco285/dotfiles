return {
  'folke/todo-comments.nvim',
  setup = function()
    local map = require('autoload.util').set_map
    map('n', '<Bslash>tt', [[<Cmd>TodoTrouble<CR>]])
    map('n', '<Bslash>ts', [[<Cmd>TodoTelescope<CR>]])
  end,
  config = function()
    require('todo-comments').setup({})
  end,
  requires = 'nvim-lua/plenary.nvim'
}
