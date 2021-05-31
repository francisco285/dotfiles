return {
  'GustavoKatel/telescope-asynctasks.nvim',
  config = function()
    local asynctasks = packer_plugins['asynctasks.vim']
    if asynctasks and not asynctasks.loaded then
      require('packer').loader('asynctasks.vim')
    end
  end,
  setup = function()
    local map = require('autoload.util').set_map
    map('n', '<M-;>t', [[<Cmd>Telescope asynctasks all results_title=false preview_title=false<CR>]])
  end,
  -- Telescope extensions must be loaded in telescope config
  opt = true
}
