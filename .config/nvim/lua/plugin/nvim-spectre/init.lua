-- Alternative: 'brooth/far.vim'
-- Alternative: 'eugen0329/vim-esearch/'
return {
  'windwp/nvim-spectre',
  module = 'spectre',
  map = function()
    local set_map = require('autoload.util').set_map
    set_map('n', '<leader>S', '<Cmd>lua require("spectre").open()<CR>')
    set_map('n', '<leader>s', '<Cmd>lua require("spectre").open({ search_text = vim.fn.expand("<cword>") })<CR>', { noremap = true })
    set_map('v', '<leader>s', '<Cmd>lua require("spectre").open_visual()<CR>', { noremap = true })
  end,
  requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' }
}
