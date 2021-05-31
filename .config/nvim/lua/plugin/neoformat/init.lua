return {
  'sbdchd/neoformat',
  map = function()
    local map = require('autoload.util').set_map
    map('n', '<Bslash>F', [[<Cmd>Neoformat<CR>]])
  end
}
