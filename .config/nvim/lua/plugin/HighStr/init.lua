return {
  'Pocco81/HighStr.nvim',
  map = function()
    local map = require('autoload.util').set_map
    map('x', '<Leader>H', [[:<C-u>HSHighlight<CR>]], { noremap = true, silent = true })
    map('x', '<Bslash>H', [[:<C-u>HSRmHighlight<CR>]], { noremap = true, silent = true })
  end
}
