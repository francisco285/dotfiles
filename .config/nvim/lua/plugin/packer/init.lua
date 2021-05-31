return {
  'wbthomason/packer.nvim',
  setup = function()
    local map = require('autoload.util').set_map
    map('n', '<Bslash>pc', [[<Cmd>PackerCompile<CR>]])
    map('n', '<Bslash>pC', [[<Cmd>PackerClean<CR>]])
    map('n', '<Bslash>pi', [[<Cmd>PackerInstall<CR>]])
    map('n', '<Bslash>pl', [[:PackerLoad ]], { noremap = true })
    map('n', '<Bslash>pp', [[<Cmd>PackerProfile<CR>]])
    map('n', '<Bslash>ps', [[<Cmd>PackerStatus<CR>]])
    map('n', '<Bslash>pS', [[<Cmd>PackerSync<CR>]])
    map('n', '<Bslash>pu', [[<Cmd>PackerUpdate<CR>]])
  end,
  opt = true
}
