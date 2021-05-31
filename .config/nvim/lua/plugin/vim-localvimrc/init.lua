return {
  'embear/vim-localvimrc',
  setup = function()
    vim.g.localvimrc_persistent = 1
    vim.g.localvimrc_persistence_file = vim.fn.expand(vim.fn.stdpath('data') .. '/.localvimrc_persistent')
  end
}
