return {
  'psliwka/vim-smoothie',
  map = function()
    local map = require('autoload.util').set_map
    map({ 'n', 'v' }, '<C-d>', [[<Cmd>call smoothie#upwards()<CR>]])
    map({ 'n', 'v' }, '<C-d>', [[<Cmd>call smoothie#downwards()<CR>]])
  end,
  config = function()
    vim.g.smoothie_update_interval = 60
  end
}
