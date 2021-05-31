-- Alternative: 'lambdalisue/gina.vim'
-- Alternative: 'TimUntersberger/neogit'
return {
  'tpope/vim-fugitive',
  setup = function()
    local map = require('autoload.util').set_map
    map('n', '<Bslash>gb', [[<Cmd>Git branch<CR>]])
    map('n', '<Bslash>gc', [[<Cmd>Git commit<CR>]])
    map('n', '<Bslash>gd', [[<Cmd>Git diff<CR>]])
    map('n', '<Bslash>gs', [[<Cmd>Git status<CR>]])
    map('n', '<Bslash>G', [[<Cmd>Git<CR>]])
    map('n', '<Bslash>gS', [[<Cmd>Git show<CR>]])
  end
}
