-- Alternative: 'Pocco81/TrueZen.nvim'
-- Alternative: 'junegunn/goyo.vim'
return {
  'folke/zen-mode.nvim',
  cmd = { 'ZenMode' },
  setup = function()
    local map = require('autoload.util').set_map
    map('n', '<Leader>z', [[<Cmd>ZenMode<CR>]])
  end,
  config = function()
    require('zen-mode').setup({
      window = {
        backdrop = 1,
        width = 0.8,
        options = {
          colorcolumn = ''
        }
      },
      plugins = {
        gitsigns = { enabled = true },
        tmux = { enabled = true }
      }
    })
  end
}
