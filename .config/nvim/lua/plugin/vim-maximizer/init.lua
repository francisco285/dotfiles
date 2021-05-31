return {
  'szw/vim-maximizer',
  cmd = 'MaximizerToggle',
  setup = function()
    vim.g.maximizer_restore_on_winleave = 1

    local map = require('autoload.util').set_map
    -- WARNING: Do not remove the '!' from this command, it will make it not restore layout sometimes
    map({ 'n', 't' }, '<M-f>', [[<Cmd>silent! MaximizerToggle!<CR>]])
  end
}
