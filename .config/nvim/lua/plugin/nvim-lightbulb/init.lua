return {
  'kosayoda/nvim-lightbulb',
  config = function()
    local set_augroup = require('autoload.util').set_augroup

    set_augroup('lightbulb', {
      { 'CursorHold,CursorHoldI', '*', [[lua require('nvim-lightbulb').update_lightbulb()]] }
    })
  end,
  after = 'nvim-lspconfig',
  requires = 'neovim/nvim-lspconfig'
}
